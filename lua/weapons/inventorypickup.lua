
AddCSLuaFile()

SWEP.PrintName = "Inventory pickup"
SWEP.Author = "Evil Factory"
SWEP.Purpose = "Press primary attack to pickup item and press R to open inventory"

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.Category = "Evil_Inventory"

SWEP.Spawnable = true

SWEP.ViewModelFOV = 54
SWEP.ViewModel = ""
SWEP.WorldModel	= ""

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false



function SWEP:Initialize()

	

end

function SWEP:SetupDataTables()


end

function SWEP:UpdateNextIdle()

end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.50 )

    if SERVER then

	local AimEnt = self.Owner:GetEyeTrace().Entity

	if item_on_whitelist(AimEnt:GetClass()) == true && self.Owner:GetPos():Distance(AimEnt:GetPos()) < GetConVar( "inventory_max_pickup_distance" ):GetInt() then
	if get_inventory_size(self.Owner) > table.Count(get_itens_ent(self.Owner)) then
    if AimEnt:IsValid() then
   
   self.Owner:EmitSound("buttons/button22.wav")

    add_item(self.Owner,AimEnt)
    AimEnt:Remove()
end
else
ply:PrintMessage( HUD_PRINTTALK, "O seu inventario esta cheio!" )
self.Owner:EmitSound("buttons/button2.wav")
end
end
end
end

function SWEP:SecondaryAttack()



end



function SWEP:OnDrop()

	self:Remove() 

end


SWEP.reloadDelay = 0.1

function SWEP:Reload()
    if self.reloadDelay < CurTime() then
    
    if CLIENT then  
     openinv()
     
     end
     self.reloadDelay = CurTime() + 1
    end
end

function SWEP:Think()



end
