# Gen4RPC
  Discord Rich Presence (RPC) Integration for the Generation 4 Pokémon games, used in conjunction with the [DeSmuMe](http://desmume.org/) emulator.

- (Due to the Discord API's [rate limit on activty updates](https://discordapp.com/developers/docs/game-sdk/activities), this script updates every 5 seconds to be a little bit under the limit). 

- **If your rich presence is not updating properly, try restarting your Discord client (CTRL+R)**
</br>

[![pypresence](https://img.shields.io/badge/using-pypresence-00bb88.svg?style=for-the-badge&logo=discord&logoWidth=20)](https://github.com/qwertyquerty/pypresence)

</br>

## How to use
1. Run the Lua script `export.lua` in the [DeSmuMe](http://desmume.org/) version of your choice.
2. Run the Python script `rpc.py`.

### Features
- Current Map Header
- Game Name
- Time Played

### Games currently supported
- [X] Pokémon Diamond/Pearl
- [X] Pokémon Diamond/Pearl Demo Version
- [ ] Pokémon Platinum
- [ ] Pokémon HeartGold/SoulSilver

### To-do
- [X] Revise map headers for D/P (sort-of done)
- [ ] Support Platinum, combine Pt headers with D/P if possible
- [ ] Support HG/SS, check if both games use the same map headers
- [ ] Differentiate between games, (Ex: Diamond OR Pearl, HeartGold OR SoulSilver)
- [ ] If possible, read from DeSmuMe RAM rather than relying on a lua to output information
