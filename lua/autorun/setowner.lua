properties.Add( "setownere", {
	MenuLabel = "#SetOwner",
	Order = 601,
	MenuIcon = "gui/silkicons/group",

	Filter = function( self, ent, ply )

		if ( !IsValid( ent ) ) then return false end
		if ( ent:IsPlayer() ) then return false end
		if ent:CPPIGetOwner() ~= ply then return end
		
		return true

	end,

	MenuOpen = function( self, option, ent, tr )


		local submenu = option:AddSubMenu()

		

		local target = IsValid( ent.AttachedEntity ) and ent.AttachedEntity or ent
        local players = player.GetAll()
		local num = table.Count(players)

		for i = 1, num do
        if players[i] == ply then continue end
		if players[i]:IsValid() == false then continue end
		
		local option = submenu:AddOption(players[i]:GetName(), function() 
      	self:SetOwner( ent, players[i] )
		
		end )

		end

	end,

	Action = function( self, ent )

		

	end,

	SetOwner = function( self, ent, id )

		self:MsgStart()
			net.WriteEntity( ent )
			net.WriteEntity( id )
		self:MsgEnd()

	end,

	Receive = function( self, length, ply )



		local ent = net.ReadEntity()
		local pla = net.ReadEntity()
       
       if ent:GetNWBool("fishingmod catch") == true then
        	ent.data.owner = pla
			ent.data.ownerid = pla:UniqueID()
			ent:CPPISetOwner(pla)	
			fishingmod.SetBaitInfo(ent, pla)
       else
       ent:CPPISetOwner(pla)	
       end

	end

} )
