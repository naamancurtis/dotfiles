from .item_handler import ItemHandler

class StrItemHandler(ItemHandler):
    def can_handle(self, item):
        return isinstance(item, str)

    def handle(self, item):
        return True, item, ''