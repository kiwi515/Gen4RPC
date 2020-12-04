--[[
Pokemon Gen 4 RPC Lua Companion

Credit to Ganix for making VET's automatic game detection script.
]]

-- Globals
G_CURRENT_MAP = 0
G_LAST_MAP = 0
G_TIMER = 0

-- Constants
ID_DP_DEMO = 0x59
ID_DP_PRODUCT = 0x41
ID_PT_PRODUCT = 0x43
ID_HGSS_PRODUCT = 0x49

LANG_DE = 0x44
LANG_EN = 0x45
LANG_FR = 0x46
LANG_IT = 0x49
LANG_JP = 0x4A
LANG_KS = 0x4B
LANG_ES = 0x53

GMNAME_DP_DEMO = 0
GMNAME_DP_PRODUCT = 1
GMNAME_PT_PRODUCT = 2
GMNAME_HGSS_PRODUCT = 3

function outputLog()
	map = memory.readword(map_ptr)
	debugInfo = io.open("out.dat", "w+b")
	io.output(debugInfo)
	io.write(gameName..'\n'..gameVer..'\n'..map..'\n')
	io.close(debugInfo)
end

-- Determine game version, then language/locale
ver = memory.readdword(0x023FFE0C)
if ver == 0 then ver = memory.readdword(0x027FFE0C) end
id = bit.band(ver, 0xFF)
lang = bit.band(bit.rshift(ver, 24), 0xFF)

-- Pokemon D/P
if id == ID_DP_PRODUCT then
	gameName = GMNAME_DP_PRODUCT

	if     lang == 0x44 then base_addr = 0x02107100 gameVer = 0	-- DE
	elseif lang == 0x45 then base_addr = 0x02106FC0 gameVer = 1	-- US / EU
	elseif lang == 0x46 then base_addr = 0x02107140 gameVer = 2	-- FR
	elseif lang == 0x49 then base_addr = 0x021070A0 gameVer = 3	-- IT
	elseif lang == 0x4A then base_addr = 0x02108818 gameVer = 4 -- JP
	elseif lang == 0x4B then base_addr = 0x021045C0 gameVer = 5	-- KS
	elseif lang == 0x53 then base_addr = 0x02107160 gameVer = 6 -- ES
	end

-- Pokemon Pt
elseif id == ID_PT_PRODUCT then
	gameName = GMNAME_PT_PRODUCT

	if     lang == 0x44 then base_addr = 0x02101EE0 -- DE
	elseif lang == 0x45 then base_addr = 0x02101D40 -- US / EU
	elseif lang == 0x46 then base_addr = 0x02101F20 -- FR
	elseif lang == 0x49 then base_addr = 0x02101EA0 -- IT
	elseif lang == 0x4A then base_addr = 0x02101140 -- JP
	elseif lang == 0x4B then base_addr = 0x02102C40 -- KS
	elseif lang == 0x53 then base_addr = 0x02101F40 -- ES
	end

-- Pokemon HG/SS
elseif id == ID_HGSS_PRODUCT then
	gameName = GMNAME_HGSS_PRODUCT

	if     lang == 0x44 then base_addr = 0x02111860 -- DE
	elseif lang == 0x45 then base_addr = 0x02111880 -- US / EU
	elseif lang == 0x46 then base_addr = 0x021118A0 -- FR
	elseif lang == 0x49 then base_addr = 0x02111820 -- IT
	elseif lang == 0x4A then base_addr = 0x02110DC0 -- JP
	elseif lang == 0x4B then base_addr = 0x02112280 -- KS
	elseif lang == 0x53 then base_addr = 0x021118C0 -- ES
	end
end

-- Determine map ID offset
if gameName == GMNAME_PT_PRODUCT then
	base       = memory.readdword(base_addr) -- Base address
	map_ptr    = base + 0x1294
else
	base       = memory.readdword(base_addr)
	map_ptr    = base + 0x144C
end

-- Initial setup.
-- Otherwise, the first write to G_LAST_MAP would result in the script thinking
-- the player just entered map 0, as (G_LAST_MAP ~= G_CURRENT_MAP) would evaluate to True because
-- G_CURRENT_MAP doesn't get a value until next frame
G_LAST_MAP = memory.readword(map_ptr)
G_CURRENT_MAP = memory.readword(map_ptr)

-- Initial output
outputLog()

while true do
	-- Compare if the map ID has changed since last frame.
	-- Note that these values are for comparison only.
	-- For an accurate reading, we just read from the map pointer once we know the map has changed.
	if G_LAST_MAP ~= G_CURRENT_MAP then
		print("NEW MAP", memory.readword(map_ptr))
		outputLog() 
	end

	if G_TIMER % 2 == 0 then
		G_LAST_MAP = memory.readword(map_ptr)
	else
		G_CURRENT_MAP = memory.readword(map_ptr)
	end

	G_TIMER = G_TIMER + 1
	emu.frameadvance()
end