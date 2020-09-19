import os
import subprocess

import dotbot

from .item_handlers import *

class Cargo(dotbot.Plugin):
    _directive = 'cargo'

    def __init__(self, context):
        super(self.__class__, self).__init__(context)
        self._load_item_handlers()

    def _load_item_handlers(self):
        self._item_handlers = [handler() for handler in ItemHandler.__subclasses__()]

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError('Shell cannot handle directive {}'.format(directive))

        success = True
        with open(os.devnull, 'w') as devnull:
            for item in data:
                if not self._handle_item(item, devnull):
                    self._log.warning('Invalid cargo item: {}'.format(item))
                    success = False

        if success:
            self._log.info('All Rust binaries have been installed')
        else:
            self._log.error('Some Rust binaries were not successfully installed')
        return success

    def _handle_item(self, item, devnull):
        for handler in self._item_handlers:
            if handler.can_handle(item):
                success, binary, args = handler.handle(item)
                if success:
                    return self._run_cargo_command(binary, args, devnull)
        return False

    def _run_cargo_command(self, binary, args, devnull):
        if len(args) > 0 and args[0] == '+':
            try:
                toolchain, args = args.split(' ', 1)
            except ValueError:
                toolchain, args = args, ''
        else:
            toolchain = ''
        cmd = ' '.join('cargo {} install --force {} {}'.format(toolchain, args, binary).split())
        self._log.info('Installing Rust binary: {} [{}]'.format(binary, cmd))
        result = subprocess.run(cmd, shell=True, stdin=devnull, stdout=devnull, stderr=subprocess.PIPE, cwd=self._context.base_directory())
        return self._check_cargo_command_output(binary, result)

    def _check_cargo_command_output(self, binary, result):
        if result.returncode != 0:
            self._log.error(result.stderr.decode())
            self._log.warning('Rust binary {} could not be installed'.format(binary))
            return False
        return True
