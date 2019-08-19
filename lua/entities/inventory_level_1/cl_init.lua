include('shared.lua')


function ENT:Draw() 
if SERVER then return end
	self:DrawModel() 
end

function ENT:DrawTranslucent()
if SERVER then return end
local ply = LocalPlayer()
	

     
        local Ang = self:LocalToWorldAngles(Angle(0,0,90))
        local Pos = self:LocalToWorld(Vector(0,-6.5,-5))


		 cam.Start3D2D(Pos,Ang, 0.1)
		 	draw.SimpleText( "Inventory level 1", "FonteInvEnt1", 0, -50, Color( 0, 0, 255, 255 ),1, 1 )
		 cam.End3D2D()

		 
end	