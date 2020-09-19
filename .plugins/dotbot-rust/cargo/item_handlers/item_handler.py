class ItemHandler(object):
    def can_handle(self, item):
        raise NotImplementedError

    def handle(self, item):
        raise NotImplementedError