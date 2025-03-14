import argparse
import os
from benchtool.OCaml import OCaml
from benchtool.Types import BuildConfig, ReplaceLevel, TrialConfig, PBTGenerator
from benchtool.Tasks import tasks

DEFAULT_DIR = 'oc3'
REPLACE = False

WORKLOADS = ['BST']
STRATEGIES : list[PBTGenerator] = [
    # PBTGenerator('base', 'bespoke'),
    # PBTGenerator('base', 'bespokeStaged'),
    # PBTGenerator('base', 'bespokeStagedC'),
    # PBTGenerator('base', 'bespokeStagedCSR'),
    # PBTGenerator('base', 'bespokeSingle'),
    # PBTGenerator('base', 'bespokeSingleStaged'),
    # PBTGenerator('base', 'bespokeSingleStagedC'),
    # PBTGenerator('base', 'bespokeSingleStagedCSR'),
    PBTGenerator('base', 'type'),
    PBTGenerator('base', 'staged'),
    PBTGenerator('base', 'stagedC'),
    PBTGenerator('base', 'stagedCSR'),
]

TRIALS = 3
TIMEOUT = 65

def collect(directory: str, workloads=WORKLOADS, strategies=STRATEGIES):
    tool = OCaml(directory, replace_level=ReplaceLevel.REPLACE if REPLACE else ReplaceLevel.SKIP)

    for workload in tool.all_workloads():
        if workload.name not in workloads:
            continue

        for variant in tool.all_variants(workload):
            if variant.name == 'base':
                continue

            run_trial = tool.apply_variant(workload, variant, BuildConfig(
                        path=workload.path,
                        clean=False,
                        build_common=False,
                        build_strategies=True,
                        build_fuzzers=False,
                        no_base=True,
                    ))

            for property in tool.all_properties(workload):
                for strategy in strategies:
                    if workload.name in ['BST',
                                         'RBT',
                                         'STLC']:
                        if property.split('_')[1] not in tasks[workload.name][variant.name]:
                            continue



                    cfg = TrialConfig(workload=workload,
                                        strategy=strategy.strategy,
                                        framework=strategy.framework,
                                        property=property,
                                        label=strategy.framework + strategy.strategy.capitalize(),
                                        trials=TRIALS,
                                        timeout=TIMEOUT,
                                        short_circuit=False)

                    run_trial(cfg)


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--data', help='path to folder for JSON data')
    p.add_argument('--workload', help='single workload to run')
    args = p.parse_args()
    dir = args.data if args.data else DEFAULT_DIR
    workloads = [args.workload] if args.workload else WORKLOADS
    results_path = f'{os.getcwd()}/{dir}'
    collect(results_path, workloads = workloads)