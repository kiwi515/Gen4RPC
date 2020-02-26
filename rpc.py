import os
import sys
import time

def chomp(string1): # removes \n from string
    return string1.rstrip("\r\n")

try:
    from pypresence import Presence, Activity
except ModuleNotFoundError:
    os.system('{} -m pip install -U '.format(sys.executable) + "pypresence -q")
    import pypresence

# out.dat constants (for readability)
gameNameOffset = 0
gameVerOffset = 1 
mapOffset = 2
#

# app client id
client_id = "510206500052926496"

# establish RPC
RPC = Presence(client_id)
RPC.connect()

# establish client activity
pkm = Activity(RPC)

# keeps track of time elapsed
pkm.start = int(time.time())

# create list of regions
GameRegion = open(os.path.join(sys.path[0], "Region"), "r")
gameList = GameRegion.readlines()
GameRegion.close()

# create list of game names
Name = open(os.path.join(sys.path[0],"GameName"), "r")
nameList = Name.readlines()
Name.close()

# create list of game image names
Image = open(os.path.join(sys.path[0],"GameImage"), "r")
imageList = Image.readlines()
Image.close()

# create list of D/P map headers
DP = open(os.path.join(sys.path[0],"DPheaders"), "r")
DPheaderList = DP.readlines()
DP.close()

#PT = open("PTheaders", "r")
#PTheaderList = PT.readlines()
#PT.close()

#HGSS = open("HGSSheaders", "r")
#HGSSheaderList = HGSS.readlines()
#HGSS.close()

luaStats = open(os.path.join(sys.path[0],"out.dat"), "rb")

while True:
    luaStats.seek(0,0) # move to beginning of file
    luaStatsList = luaStats.readlines() # read all lines from file into a list
    luaStatsList = [int(i) for i in luaStatsList] # convert emulator output to integers
    
    # get game name
    if luaStatsList[gameNameOffset] != 4:
        gameName = "Pokémon " + nameList[ luaStatsList[gameNameOffset] ]
    else:
        gameName = nameList[ luaStatsList[gameNameOffset] ]
    
	# map nr validation check
    if luaStatsList[mapOffset] > 557:
	    mapHeader = "Jubilife City (> 557)"
    else:
	    mapHeader = DPheaderList[ luaStatsList[mapOffset] ] # get map header
	
    gameVer = gameList[ luaStatsList[gameVerOffset] ] # get game region
    gameImage = imageList[ luaStatsList[gameNameOffset] ] # get game image
    #gameImage = gameImage.rstrip("\r\n") # removes escape character so image query works properly
    
    print("\nUpdating RPC Activity:\nMap: " + mapHeader + "\nGame Ver: " + gameName + gameVer + '\n')
    RPC.update(state = chomp(mapHeader), details = chomp(gameName), large_image = chomp(gameImage), start = pkm.start)
    
    time.sleep(5) # Discord API limit