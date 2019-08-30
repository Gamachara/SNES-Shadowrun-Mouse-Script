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

]]

function ShadowrunMouse()
	inp = input.get()
	
	if(memory.readbyte(0x0001F5) == 255) then
		--keep in range and adjust for offset
		x = math.max(3,math.min(inp.xmouse - 5,255))
		y = math.max(3,math.min(inp.ymouse - 4,223))
		memory.writebyte(0x0001F1,x)
		memory.writebyte(0x0001F3,y)
	end
	
	if(inp.leftclick) 		then joypad.set(1, {B=true}) --Select
	elseif(inp.rightclick) 	then joypad.set(1, {A=true}) --Weapon
	elseif(inp.middleclick) then joypad.set(1, {X=true}) --Spell
	end

end
gui.register(ShadowrunMouse)