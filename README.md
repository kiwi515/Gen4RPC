# gen4-RPC
Discord Rich Presence (RPC) Integration for the Generation 4 Pokémon games, used in conjunction with the [DeSmuMe](http://desmume.org/) emulator.

- (Due to the Discord API's [rate limit on activty updates](https://discordapp.com/developers/docs/game-sdk/activities), this script updates every 5 seconds to be a little bit under the limit). 

- **If your rich presence is not updating properly, try restarting your Discord client (CTRL+R)**

[![pypresence](https://img.shields.io/badge/using-pypresence-00bb88.svg?style=for-the-badge&logo=discord&logoWidth=20)](https://github.com/qwertyquerty/pypresence)

</br>

## Features
- Current Map Header
- Game Name
</br>

## Games currently supported
- Pokémon Diamond/Pearl
- Pokémon Diamond/Pearl Demo Version
- Pokémon Diamond/Pearl August '06 Debug Version
</br>

## Games planned to be supported in the future
- [ ] Pokémon Platinum
- [ ] Pokémon HeartGold/SoulSilver
</br>

## How to use
1. Run the Lua script `rpc.lua` in the [DeSmuMe](http://desmume.org/) version of your choice.
2. Run the Python script `rpc.py`.
3. Profit
</br>

### NOTE: KEEP THE LUA IN THE SAME FOLDER AS THE PYTHON SCRIPT!!
