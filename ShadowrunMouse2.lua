--[[SHADOWRUN SNES MOUSE SCRIPT FOR SNES9X-RR

Download SNES9X-RR from https://github.com/gocha/snes9x-rr/releases

Load Shadowrun ROM

Open FILE->Lua Scripting->New Lua Script Window

Click Browse and open this file

If the console says "script returned but is still running registered functions" don't worry, that is normal.

Enjoy Shadowrun with mouse!


Left click will select, right click will attack, middle will cast spells.

It is suggested you set movement (Input->Input Configuration) to WASD.

I set start to E and Select to left CTRL.

Shadowrun has a large following in Germany and it was brought to my attention that the German version of the rom was incompatible with the original script. This will now work on either the US or German version with the alternate memory locations set below.

Curent features:
	- Mouse and keyboard style control
	- Jake moves from dpad input even while the mouse is active
	
Future goals:
	- Automatic detection of rom region
	- Mouse wheel or other hotkey to change selected spell
]]

rom_region = U

if (rom_region == U) then
	mouse_mode	= 0x0001F5 -- Is 255 when mouse active --501
	mouse_x		= 0x0001F1
	mouse_y		= 0x0001F3

	dpad_state	= 0x7E01E7

	move1 = 0x7E0D92
	move2 = 0x7E0D93
	move3 = 0x7E0DEA
	move4 = 0x7E0DEB
	
	--jake_animation = 0x7E10AA
	
elseif (rom_region == DE) then
	mouse_mode 	= 0x0001D9
	mouse_x 	= 0x0001D5 
	mouse_y 	= 0x0001D7

	dpad_state = 0x7E01CB

	move1 = 0x7E0D62
	move2 = 0x7E0D63
	move3 = 0x7E0DBA
	move4 = 0x7E0DBB
end

function ShadowrunMouse()

	inp = input.get()
	
	if(inp.leftclick) 		then joypad.set(1, {B=true}) --Select
	elseif(inp.rightclick) 	then joypad.set(1, {A=true}) --Weapon
	elseif(inp.middleclick) then joypad.set(1, {X=true}) --Spell
	end
	
	if(memory.readbyte(mouse_mode) == 255) then
	
		-- Keep in range and adjust for a abuilt-in offset
		-- This version of LUA does not feature clamp
		
		x = math.max(3,math.min(inp.xmouse - 5,255))
		y = math.max(3,math.min(inp.ymouse - 4,223))
		
		memory.writebyte(mouse_x,x)
		memory.writebyte(mouse_y,y)
		
		-- Allow DPAD movement while in mouse mode
		movedir = memory.readbyte(dpad_state)
		
		-- Jake is standing still
		if (movedir == 0) then
			memory.writebyte(move1,0)
			memory.writebyte(move2,0)
			memory.writebyte(move3,0)
			memory.writebyte(move4,0)
			
		-- Jake is moving right
		elseif (movedir == 1) then
			memory.writebyte(move1,-3)
			memory.writebyte(move2,-1)
			memory.writebyte(move3,3)
			memory.writebyte(move4,0)
			
		-- Jake is moving left
		elseif (movedir == 2) then
			memory.writebyte(move1, 3)
			memory.writebyte(move2, 0)
			memory.writebyte(move3,-3)
			memory.writebyte(move4,-1)
			
		-- Jake is moving down
		elseif (movedir == 4) then
			memory.writebyte(move1,-3)
			memory.writebyte(move2,-1)
			memory.writebyte(move3,-3)
			memory.writebyte(move4,-1)

		-- Jake is moving down-right
		elseif (movedir == 5) then
			memory.writebyte(move1,-4)
			memory.writebyte(move2,-1)
			memory.writebyte(move3, 0)
			memory.writebyte(move4, 0)
			
		-- Jake is moving down-left
		elseif (movedir == 6) then
			memory.writebyte(move1, 0)
			memory.writebyte(move2, 0)
			memory.writebyte(move3,-4)
			memory.writebyte(move4,-1)

		-- Jake is moving up
		elseif (movedir == 8) then
			memory.writebyte(move1, 3)
			memory.writebyte(move2, 0)
			memory.writebyte(move3, 3)
			memory.writebyte(move4, 0)
			
		-- Jake is moving up-right
		elseif (movedir == 9) then
			memory.writebyte(move1, 0)
			memory.writebyte(move2, 0)
			memory.writebyte(move3, 4)
			memory.writebyte(move4, 0)
			
		-- Jake is moving up-left
		elseif (movedir == 10) then
			memory.writebyte(move1, 4)
			memory.writebyte(move2, 0)
			memory.writebyte(move3, 0)
			memory.writebyte(move4, 0)

		end
	end
end
gui.register(ShadowrunMouse)


