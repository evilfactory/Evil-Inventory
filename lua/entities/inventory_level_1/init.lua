AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
	if ( CLIENT ) then return end
	

    self:SetModel("models/props_c17/SuitCase001a.mdl")
    self:SetSkin(0)
	self:SetColor(Color(0,0,255))
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.timer = CurTime()
	self:GetPhysicsObject():Wake()
end



function ENT:Think()

	end

function ENT:Use(ply)
   if get_inventory_size(ply) < GetConVar( "inventory_level1_size" ):GetInt() then
ply:PrintMessage( HUD_PRINTTALK, "Agora seu inventario possui "..GetConVar( "inventory_level1_size" ):GetInt().." slots!" )

   self:EmitSound("buttons/combine_button7.wav")
   set_inventory_size(ply, GetConVar( "inventory_level1_size" ):GetInt())
   self:Remove()
   else
ply:PrintMessage( HUD_PRINTTALK, "Voce ja possui o upgrade de inventario level 1" )
   end
end