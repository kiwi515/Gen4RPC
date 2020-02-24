from pypresence import Presence, Activity
import time

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
GameRegion = open("Region", "r")
gameList = GameRegion.readlines()
GameRegion.close()

# create list of game names
Name = open("GameName", "r")
nameList = Name.readlines()
Name.close()

# create list of game image names
Image = open("GameImage", "r")
imageList = Image.readlines()
Image.close()

# create list of D/P map headers
DP = open("DPheaders", "r")
DPheaderList = DP.readlines()
DP.close()

#PT = open("PTheaders", "r")
#PTheaderList = PT.readlines()
#PT.close()

#HGSS = open("HGSSheaders", "r")
#HGSSheaderList = HGSS.readlines()
#HGSS.close()

emuOutput = open("out.dat", "rb")

while True:
    emuOutput.seek(0,0) # move to beginning of file
    luaStats = emuOutput.readlines() # read all lines from file into a list
    luaStats = [int(i) for i in luaStats] # convert emulator output to integers
    
    # get game name
    if luaStats[gameNameOffset] != 4:
        gameName = "Pokémon " + nameList[ luaStats[gameNameOffset] ]
    else:
        gameName = nameList[ luaStats[gameNameOffset] ]
    
    gameVer = gameList[ luaStats[gameVerOffset] ] # get game region
    mapHeader = DPheaderList[ luaStats[mapOffset] ] # get map header
    
    gameImage = imageList[ luaStats[gameNameOffset] ] # get game image
    gameImage = gameImage.rstrip("\r\n") # removes escape character so image query works properly
    
    RPC.update(state = mapHeader, details = gameName, large_image = gameImage, start = pkm.start)
    
    time.sleep(5) # Discord API limit