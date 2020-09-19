from .item_handler import ItemHandler

class DictItemHandler(ItemHandler):
    def can_handle(self, item):
        return isinstance(item, dict)

    def handle(self, item):
        args = ''
        if len(item) != 1:
            return _error()
        binary = list(item.keys())[0]
        if not isinstance(item[binary], list):
            return _error()
        for arg in item[binary]:
            if isinstance(arg, str):
                if arg[0] == '+':
                    args = '{} {}'.format(arg, args)
                else:
                    args += ' --{}'.format(arg)
            elif isinstance(arg, dict):
                if len(item) != 1:
                    return _error()
                key = list(arg.keys())[0]
                if not isinstance(arg[key], str):
                    return _error()
                args += ' --{} {}'.format(key, arg[key])
            else:
                return _error()
        return True, binary, args

def _error():
    return False, '', ''
