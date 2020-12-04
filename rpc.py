import os
import sys
import time
from Gen4.GameContext import GameContext

GAME_NAME = 0
GAME_VER = 1 
MAP = 2
CLIENT_ID = "510206500052926496"

if __name__ == "__main__":
    try:
        from pypresence import Presence
    except ModuleNotFoundError:
        os.system('{} -m pip install -U '.format(sys.executable) + "pypresence -q")
        import pypresence

    RPC = Presence(CLIENT_ID)
    RPC.connect()

    # Start epoch time
    startTime = int(time.time())

    # Open out.dat. If the file does not exist, create it and then open it.
    try:
        f = open(os.path.join(sys.path[0],"out.dat"), "rb")
    except FileNotFoundError:
        print("It seems out.dat does not exist. Creating new file...")
        open("out.dat", "w+").close()
        print("out.dat created. Attempting to open...")
        f = open(os.path.join(sys.path[0],"out.dat"), "rb")
        print("File opened successfully!\n")

    # Init game context
    gc = GameContext(0, 0, 0)

    while True:
        # Parse out.dat's contents into a list
        f.seek(0,0)
        out = f.readlines()
        out = [int(i) for i in out]

        # Update the game context if out.dat is not empty
        try:
            gc.update(out[GAME_NAME], out[GAME_VER], out[MAP])
        except IndexError:
            print("It seems out.dat is empty. Retrying in 1 second...")
            time.sleep(1)
            continue
        
        # Update RPC
        print("\nUpdating RPC Activity:\nMap: " + gc.header() + " " + "Game Ver: " + gc.title() + " (" + gc.region() + ")")
        RPC.update(state = gc.header(), details = gc.title(), large_image = gc.img(), start = startTime)
        
        # Discord API limit
        time.sleep(5)