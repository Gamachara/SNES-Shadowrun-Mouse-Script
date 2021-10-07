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

]]


-- US Rom --

--mouseOn = 0x0001F5
--mouseX = 0x0001F1
--mouseY = 0x0001F3

-- DE Rom --

mouseOn = 0x0001D9
mouseX = 0x0001D5
mouseY = 0x0001D7

function ShadowrunMouse()
	inp = input.get()
	
	if(memory.readbyte(mouseOn) == 255) then
		--keep in range and adjust for offset. (This version of LUA does not feature clamp)
		x = math.max(3,math.min(inp.xmouse - 5,255))
		y = math.max(3,math.min(inp.ymouse - 4,223))
		memory.writebyte(mouseX,x)
		memory.writebyte(mouseY,y)
	end
	
	if(inp.leftclick) 		then joypad.set(1, {B=true}) --Select
	elseif(inp.rightclick) 	then joypad.set(1, {A=true}) --Weapon
	elseif(inp.middleclick) then joypad.set(1, {X=true}) --Spell
	end

end
gui.register(ShadowrunMouse)