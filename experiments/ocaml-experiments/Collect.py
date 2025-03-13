import argparse
import os
import multiprocessing as mp
from multiprocessing import Queue, Manager
import psutil
import time
import logging
from typing import List, Tuple, Dict, Any, Set
from benchtool.OCaml import OCaml
from ocaml_with_pinning import PinnedOCaml  # Import our custom class
from benchtool.Types import BuildConfig, ReplaceLevel, TrialConfig, PBTGenerator
from benchtool.Tasks import tasks

DEFAULT_DIR = 'oc3'
REPLACE = False

WORKLOADS = ['BST', 'RBT', 'STLC']
STRATEGIES : list[PBTGenerator] = [
    PBTGenerator('base', 'bespoke'),
    PBTGenerator('base', 'bespokeStaged'),
    PBTGenerator('base', 'bespokeStagedC'),
    PBTGenerator('base', 'bespokeStagedCSR'),
    PBTGenerator('base', 'bespokeSingle'),
    PBTGenerator('base', 'bespokeSingleStaged'),
    PBTGenerator('base', 'bespokeSingleStagedC'),
    PBTGenerator('base', 'bespokeSingleStagedCSR'),
    PBTGenerator('base', 'type'),
    PBTGenerator('base', 'staged'),
    PBTGenerator('base', 'stagedC'),
    PBTGenerator('base', 'stagedCSR'),
]

TRIALS = 1
TIMEOUT = 65
MAX_WORKERS = 64  # Number of cores to use

# Configure logging
logger = logging.getLogger("benchtool-parallel")
FORMAT = {
    'fmt': '%(asctime)s [%(levelname)s] [%(filename)s/%(funcName)s] %(message)s',
    'datefmt': '%Y-%m-%d %H:%M:%S',
}
logging.basicConfig(level=logging.INFO, format=FORMAT['fmt'], datefmt=FORMAT['datefmt'])

def worker(task_queue: Queue, result_queue: Queue, core_id: int, results_path: str, replace: bool):
    """Worker function that processes tasks from the queue and pins to a specific CPU core."""
    # Pin this process to the specified CPU core
    p = psutil.Process()
    try:
        p.cpu_affinity([core_id])
        logger.info(f"Worker {core_id} pinned to CPU core {core_id}")
    except AttributeError:
        # cpu_affinity not available on all platforms
        logger.warning(f"Worker {core_id} could not be pinned (unsupported platform)")
    
    # Create a dedicated PinnedOCaml tool instance for this worker
    # Each worker needs its own instance to prevent race conditions
    replace_level = ReplaceLevel.REPLACE if replace else ReplaceLevel.SKIP
    tool = PinnedOCaml(
        results=results_path,
        core_id=core_id,  # Pass the core_id to pin subprocesses
        log_level=logging.INFO,
        replace_level=replace_level
    )
    
    # Process tasks until the queue is empty
    tasks_processed = 0
    while True:
        try:
            # Get task from queue with a timeout
            task = task_queue.get(timeout=1)
            
            # Check for termination signal
            if task is None:
                logger.info(f"Worker {core_id} received termination signal")
                break
                
            # Unpack the task
            workload, variant_name, strategy, property_name = task
            
            # Find the variant
            variant = None
            for v in tool.all_variants(workload):
                if v.name == variant_name:
                    variant = v
                    break
            
            if variant is None:
                logger.error(f"Worker {core_id}: Variant {variant_name} not found for {workload.name}")
                result_queue.put((False, f"Variant {variant_name} not found"))
                continue
            
            # Build and run the trial
            logger.info(f"Worker {core_id} processing: {workload.name}/{variant.name}/{strategy.framework}.{strategy.strategy}/{property_name}")
            
            try:
                build_config = BuildConfig(
                    path=workload.path,
                    clean=False,
                    build_common=False,
                    build_strategies=True,
                    build_fuzzers=False,
                    no_base=True,
                )
                
                run_trial = tool.apply_variant(workload, variant, build_config)
                
                trial_config = TrialConfig(
                    workload=workload,
                    strategy=strategy.strategy,
                    framework=strategy.framework,
                    property=property_name,
                    label=strategy.framework + strategy.strategy.capitalize(),
                    trials=TRIALS,
                    timeout=TIMEOUT,
                    short_circuit=False
                )
                
                run_trial(trial_config)
                
                # Report success
                tasks_processed += 1
                result_queue.put((True, f"Completed: {workload.name}/{variant.name}/{strategy.framework}.{strategy.strategy}/{property_name}"))
                
            except Exception as e:
                logger.error(f"Worker {core_id} error: {str(e)}")
                result_queue.put((False, f"Error: {str(e)}"))
                
        except Queue.Empty:
            # No more tasks available right now
            continue
        except Exception as e:
            # Catch any unexpected errors
            logger.error(f"Worker {core_id} unexpected error: {str(e)}")
            result_queue.put((False, f"Unexpected error: {str(e)}"))
    
    logger.info(f"Worker {core_id} completed {tasks_processed} tasks")
    return tasks_processed

def collect_parallel(directory: str, num_workers: int = MAX_WORKERS, workloads=WORKLOADS, strategies=STRATEGIES):
    """Parallel implementation of the collect function using multiple processes"""
    # Create results directory if it doesn't exist
    if not os.path.exists(directory):
        os.makedirs(directory)
        
    results_path = directory
    
    # Create a manager for the shared queues
    manager = Manager()
    task_queue = manager.Queue()
    result_queue = manager.Queue()
    
    # Create a temporary instance to enumerate the tasks
    # No need to pin this instance as it's just for enumeration
    temp_tool = OCaml(
        results=results_path,
        log_level=logging.INFO,
        replace_level=ReplaceLevel.SKIP  # Just for enumeration
    )
    
    # Find all tasks
    total_tasks = 0
    logger.info("Enumerating benchmark tasks...")
    
    for workload_name in workloads:
        workload = None
        
        # Find the workload by name
        for w in temp_tool.all_workloads():
            if w.name == workload_name:
                workload = w
                break
                
        if workload is None:
            logger.warning(f"Workload {workload_name} not found, skipping")
            continue
            
        logger.info(f"Processing workload: {workload.name}")
        
        # Get all variants for this workload
        variants = [v for v in temp_tool.all_variants(workload) if v.name != 'base']
        if not variants:
            logger.warning(f"No non-base variants found for {workload.name}")
            continue
            
        # Get all properties for this workload
        properties = temp_tool.all_properties(workload)
        if not properties:
            logger.warning(f"No properties found for {workload.name}")
            continue
            
        # Add tasks to the queue
        for variant in variants:
            for strategy in strategies:
                for property_name in properties:
                    # Check if this property should be tested for this workload/variant
                    if workload.name in ['BST', 'RBT', 'STLC']:
                        prop_key = property_name.split('_')[1]
                        if prop_key not in tasks[workload.name][variant.name]:
                            continue
                    
                    # Add task to queue
                    task_queue.put((workload, variant.name, strategy, property_name))
                    total_tasks += 1
    
    logger.info(f"Total benchmark tasks: {total_tasks}")
    
    if total_tasks == 0:
        logger.error("No tasks found to run!")
        return
        
    # Adjust number of workers based on available cores and tasks
    num_workers = min(num_workers, total_tasks, psutil.cpu_count() or 1)
    logger.info(f"Starting {num_workers} worker processes...")
    
    # Start the worker processes
    processes = []
    for i in range(num_workers):
        p = mp.Process(
            target=worker,
            args=(task_queue, result_queue, i, results_path, REPLACE)
        )
        p.start()
        processes.append(p)
        
    # Monitor progress
    completed = 0
    start_time = time.time()
    errors = 0
    
    try:
        while completed < total_tasks and any(p.is_alive() for p in processes):
            try:
                # Get results with timeout
                success, message = result_queue.get(timeout=1)
                completed += 1
                
                if not success:
                    errors += 1
                    logger.error(f"Task error: {message}")
                
                # Calculate progress and ETA
                elapsed = time.time() - start_time
                if completed > 0:
                    avg_time_per_task = elapsed / completed
                    remaining_tasks = total_tasks - completed
                    eta_seconds = avg_time_per_task * remaining_tasks
                    
                    # Format ETA
                    eta_hours = int(eta_seconds // 3600)
                    eta_minutes = int((eta_seconds % 3600) // 60)
                    eta_seconds = int(eta_seconds % 60)
                    
                    # Progress update
                    logger.info(
                        f"Progress: {completed}/{total_tasks} ({completed/total_tasks*100:.1f}%) - "
                        f"ETA: {eta_hours:02d}:{eta_minutes:02d}:{eta_seconds:02d} - "
                        f"Errors: {errors}"
                    )
            except Queue.Empty:
                # Just a timeout, continue
                pass
                
    except KeyboardInterrupt:
        logger.info("Keyboard interrupt detected, stopping workers...")
        # Clean termination
        for p in processes:
            if p.is_alive():
                p.terminate()
    
    # Wait for processes to complete
    for p in processes:
        p.join(timeout=5)
        if p.is_alive():
            p.terminate()
    
    # Final status
    total_time = time.time() - start_time
    hours = int(total_time // 3600)
    minutes = int((total_time % 3600) // 60)
    seconds = int(total_time % 60)
    
    logger.info(f"Benchmark completed: {completed}/{total_tasks} tasks")
    logger.info(f"Total time: {hours:02d}:{minutes:02d}:{seconds:02d}")
    logger.info(f"Successful tasks: {completed - errors}")
    logger.info(f"Failed tasks: {errors}")

if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--data', help='path to folder for JSON data')
    p.add_argument('--cores', type=int, default=MAX_WORKERS, help='number of CPU cores to use')
    args = p.parse_args()
    
    dir = args.data if args.data else DEFAULT_DIR
    results_path = f'{os.getcwd()}/{dir}'
    
    # Set multiprocessing start method
    mp.set_start_method('spawn')
    
    # Run the parallel collection
    collect_parallel(results_path, num_workers=args.cores)