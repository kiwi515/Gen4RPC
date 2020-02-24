# gen4-RPC
  Discord Rich Presence (RPC) Integration for the Generation 4 Pokémon games, used in conjunction with the [DeSmuMe](http://desmume.org/) emulator.

- (Due to the Discord API's [rate limit on activty updates](https://discordapp.com/developers/docs/game-sdk/activities), this script updates every 5 seconds to be a little bit under the limit). 

- **If your rich presence is not updating properly, try restarting your Discord client (CTRL+R)**
</br>

[![pypresence](https://img.shields.io/badge/using-pypresence-00bb88.svg?style=for-the-badge&logo=discord&logoWidth=20)](https://github.com/qwertyquerty/pypresence)

</br>

## How to use
1. Run the Lua script `rpc.lua` in the [DeSmuMe](http://desmume.org/) version of your choice.
2. Run the Python script `rpc.py`.
3. Profit

### Features
- Current Map Header
- Game Name

### Games currently supported
- [X] Pokémon Diamond/Pearl
- [X] Pokémon Diamond/Pearl Demo Version
- [X] Pokémon Diamond/Pearl August '06 Debug Version
- [ ] Pokémon Platinum
- [ ] Pokémon HeartGold/SoulSilver

### To-do
- [ ] Revise map headers for D/P
- [ ] Support Platinum, combine Pt headers with D/P if possible
- [ ] Support HG/SS, check if both games use the same map headers
- [ ] If possible, read from DeSmuMe RAM rather than relying on a lua to output information.
</br>

### NOTE: Keep all files inside the .zip in the same folder so the script will run properly.
