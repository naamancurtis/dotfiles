import os
import subprocess

import dotbot

class Rustup(dotbot.Plugin):
    _directive = 'rust'

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError('Shell cannot handle directive {}'.format(directive))
        return False
