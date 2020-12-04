from Gen4.headers import *
from Gen4.game import *

class GameContext:
    def __init__(self, title, ver, map):
        self._title = title
        self._ver = ver
        self._map = map


    def update(self, title, ver, map):
        self._title = title
        self._ver = ver
        self._map = map

    def header(self):
        if (self._ver == TITLES_TO_VAL["D/P Demo"]
        or self._ver == TITLES_TO_VAL["Diamond/Pearl"]
        or self._ver == TITLES_TO_VAL["DP Aug 06 Debug"]):
            if self._map < 557:
                return HEADERS_DP[self._map]
            else:
                return "Jubilife City (Void)"

    def title(self):
        return "Pokemon " + VAL_TO_TITLES[self._title]

    def map(self):
        return self._map

    def region(self):
        return REGIONS[self._ver]

    def img(self):
        return IMAGE_TITLES[self._title]