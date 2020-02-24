--[[
Pokemon Gen 4 RPC Lua Companion
-------------------------------

Credit to Ganix for making VET's automatic game detection script.
]]

-- init log
print("Initializing out.dat")
init = io.open("out.dat", "w+b")
io.output(init)
io.close(init)

ver = memory.readdword(0x023FFE0C)
if ver == 0 then
	ver = memory.readdword(0x027FFE0C)
end
id = bit.band(ver, 0xFF)
lang = bit.band(bit.rshift(ver, 24), 0xFF)

if id == 0x59 then 									   -- Pokemon D/P Demo
	gameName = 0
	if     lang == 0x45 then base_addr = 0x02106BAC
		gameVer = 0									   -- US / EU
	end
end

if id == 0x41 then  								   -- Pokemon D/P

	gameName = 1

	if     lang == 0x44 then base_addr = 0x02107100
		gameVer = 0									   -- DE
	elseif lang == 0x45 then base_addr = 0x02106FC0
		gameVer = 1									   -- US / EU
	elseif lang == 0x46 then base_addr = 0x02107140    
		gameVer = 2									   -- FR
	elseif lang == 0x49 then base_addr = 0x021070A0    
		gameVer = 3									   -- IT
	elseif lang == 0x4A then base_addr = 0x02108818    
		gameVer = 4									   -- JP
	elseif lang == 0x4B then base_addr = 0x021045C0    
		gameVer = 5									   -- KS
	elseif lang == 0x53 then base_addr = 0x02107160    
		gameVer = 6									   -- ES
	end

elseif id == 0x43 then                                 -- Pokemon Pt
	gameName = 2

	if     lang == 0x44 then base_addr = 0x02101EE0    -- DE
	elseif lang == 0x45 then base_addr = 0x02101D40    -- US / EU
	elseif lang == 0x46 then base_addr = 0x02101F20    -- FR
	elseif lang == 0x49 then base_addr = 0x02101EA0    -- IT
	elseif lang == 0x4A then base_addr = 0x02101140    -- JP
	elseif lang == 0x4B then base_addr = 0x02102C40    -- KS
	elseif lang == 0x53 then base_addr = 0x02101F40    -- ES
	end

elseif id == 0x49 then                                 -- Pokemon HG/SS
	gameName = 3

	if     lang == 0x44 then base_addr = 0x02111860    -- DE
	elseif lang == 0x45 then base_addr = 0x02111880    -- US / EU
	elseif lang == 0x46 then base_addr = 0x021118A0    -- FR
	elseif lang == 0x49 then base_addr = 0x02111820    -- IT
	elseif lang == 0x4A then base_addr = 0x02110DC0    -- JP
	elseif lang == 0x4B then base_addr = 0x02112280    -- KS
	elseif lang == 0x53 then base_addr = 0x021118C0    -- ES
	end
end

if memory.readbyte(0x021163E4) == 46 then           -- August 2006 Debug ROM
	gameName = 4

	base_addr = 0x0211F988  						-- JP
end

--
-- Global variable setup
--
function setup()
	-- Game-dependent value fixup
	if game == "Pt" then
		base       = memory.readdword(base_addr)  -- Base address
		map_ptr    = base + 0x1294
	elseif game == "debug" then
		base       = memory.readdword(base_addr)  -- Base address
		map_ptr    = base + 0x144C
	else
		base       = memory.readdword(base_addr)  -- Base address
		map_ptr    = base + 0x144C

	end
	map = memory.readword(map_ptr)     -- Map ID
end

id = bit.band(memory.readdword(0x23ffe0c), 0xFF)
if id == 0x41 then
	game = "DP"
elseif id == 0x49 then
	game = "HGSS"
elseif id == 0x43 then
	game = "Pt"
end

function outputLog()
	print("Outputting game information to out.dat")
			map = memory.readword(map_ptr)
			debugInfo = io.open("out.dat", "w+b")
			io.output(debugInfo)
			
			io.write(gameName)
			io.write("\n")
			io.write(gameVer)
			io.write("\n")
			io.write(map)
			io.write("\n")

		io.close(debugInfo)
end

function main()
	setup()
end

gui.register(main)

function updateVars()
	local temp = map
	if temp ~= memory.readword(map_ptr) then
		emu.frameadvance()
		print("NEW MAP ", map)
		outputLog()
		
	end
end

emu.frameadvance() -- prevents race condition
emu.registerafter(updateVars)

