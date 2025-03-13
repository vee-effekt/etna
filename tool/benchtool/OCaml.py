from benchtool.BenchTool import BenchTool, Entry
from benchtool.Types import BuildConfig, Config, LogLevel, ReplaceLevel, TrialArgs

import json
import os
import re
import subprocess
import ctypes
import platform
import random

STRATEGIES_DIR = 'lib/Strategies'
IMPL_PATH = 'lib/'
SPEC_PATH = 'lib/spec.ml'

class OCaml(BenchTool):
    """OCaml bench tool with CPU pinning for subprocesses (Linux-specific)"""
    
    def __init__(self, results: str, core_id: int = None, log_level: LogLevel = LogLevel.INFO, replace_level: ReplaceLevel = ReplaceLevel.REPLACE):
        """Initialize with optional CPU core pinning"""
        super().__init__(
            Config(start='(*',
                   end='*)',
                   ext='.ml',
                   path='workloads/OCaml',
                   ignore='nothing',
                   strategies=STRATEGIES_DIR,
                   impl_path=IMPL_PATH,
                   spec_path=SPEC_PATH), results, log_level, replace_level)
        self.core_id = core_id

    def all_properties(self, workload: Entry) -> list[Entry]:
        spec = os.path.join(workload.path, self._config.spec_path)
        with open(spec) as f:
             contents = f.read()
             regex = re.compile(r'prop_[^\s]*')
             matches = regex.findall(contents)
             return list(dict.fromkeys(matches))

    def _build(self, cfg: BuildConfig):
        with self._change_dir(cfg.path):
            self._shell_command(['dune', 'build'])
    
    def _run_trial(self, workload_path: str, params: TrialArgs):
        def reformat(filename):
            if filename.endswith('.json'):
                new_filename = os.path.splitext(filename)[0] + '.txt'
                os.rename(filename, new_filename)
        with self._change_dir(workload_path):
            for _ in range(params.trials):
                seed = 0
                if self.core_id is not None:
                    # Run the subprocess with CPU affinity pinning
                    cmd = ['dune', 'exec', params.workload, '--', params.framework, params.property, params.strategy, params.file, str(seed)]
                    self._pinned_shell_command(cmd, self.core_id)
                else:
                    # Run the subprocess normally
                    self._shell_command(['dune', 'exec', params.workload, '--', params.framework, params.property, params.strategy, params.file, str(seed)])
        reformat(params.file)

    def _pinned_shell_command(self, cmd: list[str], core_id: int) -> None:
        """Run a shell command with CPU pinning using Linux taskset"""
        try:
            # Use taskset to pin the process to a specific core
            pinned_cmd = ['taskset', '-c', str(core_id)] + cmd
            
            process = subprocess.run(
                pinned_cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                check=False
            )
            
            # Debug logging always shows full output
            if self._log_level == LogLevel.DEBUG:
                if process.stdout:
                    self._log(f"Command output: {process.stdout}", LogLevel.DEBUG)
                if process.stderr:
                    self._log(f"Command error output: {process.stderr}", LogLevel.DEBUG)
            
            # Always report errors regardless of log level
            if process.returncode != 0:
                error_msg = f"Command failed with exit code {process.returncode}"
                if process.stderr:
                    error_msg += f": {process.stderr}"
                self._log(error_msg, LogLevel.ERROR)
                return False
            
            return True
            
        except Exception as e:
            self._log(f"Error running {cmd} with taskset: {e}", LogLevel.ERROR)
            return False

    def _preprocess(self, workload: Entry) -> None:
        pass