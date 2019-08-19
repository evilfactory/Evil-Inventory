if SERVER then


CreateConVar( "inventory_max_pickup_distance", "70", { FCVAR_REPLICATED, FCVAR_ARCHIVE } )

CreateConVar( "inventory_level1_size", "3", { FCVAR_REPLICATED, FCVAR_ARCHIVE } )

CreateConVar( "inventory_level2_size", "6", { FCVAR_REPLICATED, FCVAR_ARCHIVE } )

CreateConVar( "inventory_level3_size", "10", { FCVAR_REPLICATED, FCVAR_ARCHIVE } )

local Whitelist = {}


function SaveWhitelist()
    local dato = ""
    for i=1, table.Count(Whitelist) do
       dato = dato..";"..Whitelist[i]
    end

    file.Write("inventory_whitelist.txt",dato)
end

function LoadWhitelist()
    local data = file.Read("inventory_whitelist.txt", "DATA")
    if data ~= nil then
    local bad = string.Explode(";", data)
    table.remove(bad, 1)
    Whitelist = bad
    end
end

function inventory_add_whitelist( player, command, arguments )
    if player:IsAdmin() then
    table.insert(Whitelist, arguments[1])
    SaveWhitelist()
    print("player "..player:Nick().." added new class: "..arguments[1].." to whitelist")
else
    print("this command is not permitted to non admin players")
    end
end

function inventory_view_whitelist( player, command, arguments )
    if player:IsAdmin() then
    PrintTable(Whitelist)

else
    print("this command is not permitted to non admin players")
    end
end

function inventory_remove_whitelist( player, command, arguments )
    if player:IsAdmin() then
    table.remove(Whitelist, tonumber(arguments[1]))
    SaveWhitelist()
    print("player "..player:Nick().." removed index "..arguments[1].." from whitelist")
else
    print("this command is not permitted to non admin players")
    end
end
 
 LoadWhitelist()
 
concommand.Add( "inventory_add_whitelist", inventory_add_whitelist )
concommand.Add( "inventory_view_whitelist", inventory_view_whitelist )
concommand.Add( "inventory_remove_whitelist", inventory_remove_whitelist )


util.AddNetworkString( "inventory_item" )
util.AddNetworkString( "inventory_item_back" )
util.AddNetworkString( "spawna_sa_bosta" )

--miguel seu gay eu sei q voce ta vendo meu script

function add_item(ply, ent)
    if ent:IsValid() then
    local tab = duplicator.CopyEntTable( ent) 
    local tabstr = util.TableToJSON( tab ) 
    
    ply:SetPData("inventory_item", ply:GetPData("inventory_item", "")..";3;"..tabstr)
    
    end
end     



function add_item_raw(ply, tabstr)
    ply:SetPData("inventory_item", ply:GetPData("inventory_item", "")..";3;"..tabstr)
    
end 

function get_inventory_size(ply)
    local size = tonumber(ply:GetPData("inventory_size", 0))    
    return size 
end
function set_inventory_size(ply, num)
ply:SetPData("inventory_size", num)
end

function get_itens_ent(ply)
    local item = ply:GetPData("inventory_item", 0)
 
    local tablo = string.Explode(";3;", item)
    table.remove(tablo, 1)  
    return tablo
end

function clear_itens(ply) 
    ply:SetPData( "inventory_item", "" )
    end

function item_on_whitelist(class)
    local yes = 0
    
    for i=1, table.Count(Whitelist) do 
       if Whitelist[i] == class then
        yes = 1
        end
    end
    
    if yes == 1 then
    return true 
    else
    return false
    end
end


function remove_item(ply, index)
    
    local tablo1 = get_itens_ent(ply)
    
    table.remove(tablo1,index)
    
    
    local mehSemIdeiaPraNome1 = "" -- ai voce pensa pq diabos tem 2 variaveis ali? e eu falo: isso foi uma longa historia.....
    local mehSemIdeiaPraNome2 = ""
    
    clear_itens(ply)
    
    for i=1, table.Count(tablo1) do
        add_item_raw(ply, tablo1[i])
    end
    
end




net.Receive( "inventory_item", function( len, ply )
     local entities = get_itens_ent(ply)
     
     net.Start("inventory_item_back")
     net.WriteTable(entities)
     net.WriteFloat(get_inventory_size(ply))
     net.Send(ply)
end )

net.Receive( "spawna_sa_bosta", function( len, ply )
    local ind = net.ReadFloat()
    local as = get_itens_ent(ply)
   
    local table = util.JSONToTable( as[ind] )
    
    table.Pos = ply:EyePos() + ply:GetAimVector() * 50
   
    local enta = duplicator.CreateEntityFromTable( ply,  table) 
    
    local agono = ply:EyePos() + ply:GetAimVector() * 70

    enta:SetPos(Vector(agono.x, agono.y, ply:GetPos().z+10))
        
    enta:SetAngles(ply:GetAngles()-Angle(0,-180,0))
    
    enta:GetPhysicsObject():EnableMotion(true)

    remove_item(ply, ind)
    
end )


end

if CLIENT then

local ply = LocalPlayer()

local entities = {}
local models = {}

local SpawnIconModels = true

local settigs = {25,25,25, 200}

--settigs = string.Explode(",",ply:GetPData("inventory_settings",0))
local datafile = file.Read( "inventory_settings.txt", "DATA" )

if datafile == nil then
settigs = {25,25,25, 200,0}
else
settigs = string.Explode(",",datafile)
end

local invcolor = Color(settigs[1],settigs[2],settigs[3])

local invre = settigs[5]

local invalpha = settigs[4]

local invsize = 0

function load_itens()
net.Start("inventory_item")
net.SendToServer(ply)

net.Receive( "inventory_item_back", function( len, ply )
     entities = net.ReadTable()
     invsize = net.ReadFloat()
     print("get")
     openinvframe()
end )

end


local open = false

function openinv()
    
load_itens()

end


function openinvframe()



local freime = vgui.Create( "DFrame" )
freime:SetPos( 5, 5 )
freime:SetSize( 577, 500 )
freime:SetTitle( "Evil Inventory 2.0" )
freime:SetVisible( true )
freime:Center()
freime:SetDraggable( false )
freime:ShowCloseButton( false )
freime:MakePopup()
freime:SetAlpha(invalpha)


if invre == 1 then

local key_down_timer = CurTime()+0.2
local key_down_delay = 0.2


hook.Add( "Think", "inventory_key", function()
    if ( input.IsKeyDown( 28 ) and key_down_timer <= CurTime() ) then 
      if open == true then
         freime:Close()
         open = false
         key_down_timer = CurTime() + key_down_delay
         hook.Remove( "Think", "inventory_key" )

        end
end
end)

end



open = true


freime.Paint = function( self, w, h )
    draw.RoundedBox( 5, 0, 0, w, h, Color( invcolor.r+35, invcolor.r+35, invcolor.r+35,invalpha ) ) 
    draw.RoundedBox(5,0,30,w , h,Color(invcolor.r,invcolor.g,invcolor.b,invalpha) ) 
end


local closebo = vgui.Create( "DButton", freime )
closebo:SetText( "X" )
closebo:SetTextColor( Color( 255, 255, 255 ) )
closebo:SetPos( 550, 3 )
closebo:SetSize( 25, 25 )
closebo.Paint = function( self, w, h )
    if self:IsHovered() then
    draw.RoundedBox( 10, 0, 0, w, h, Color( 255, 0, 0, 300 ) )
else
    draw.RoundedBox( 10, 0, 0, w, h, Color( 255, 0, 0, 80 ) )
    end
end
closebo.DoClick = function()
    open = false
    hook.Remove( "Think", "inventory_key")
    freime:Close()
end

local Button2 = vgui.Create("DButton", freime)
Button2:SetText( "Options" )
Button2:SetPos(457,  3)
Button2:SetSize(80, 25)
Button2.Paint = function( self, w, h )
    if self:IsHovered() then
    draw.RoundedBox( 10, 0, 0, w, h, Color( 10, 255, 0, 300 ) )
else
    draw.RoundedBox( 10, 0, 0, w, h, Color( 0, 255, 0, 80 ) )
    end
end

local open2 = false

Button2.DoClick = function()
if open2 == true then return end
open2 = true
    frame2 = vgui.Create("DFrame")
    frame2:SetPos(ScrW()/2+300,ScrH()/2-200)
    frame2:SetSize(250,350)
    frame2:ShowCloseButton(false)
    frame2:SetTitle("Options")
    frame2.Paint = function( self, w, h )
       
    draw.RoundedBox(5,0,0,w , h,Color(invcolor.r,invcolor.g,invcolor.b, 250))
end
 
local Mixer = vgui.Create( "DColorMixer", frame2 )
Mixer:SetPos(30,50)
Mixer:SetSize(200,200)     
Mixer:SetPalette( true )
Mixer:SetAlphaBar( true )      
Mixer:SetWangs( true )     
Mixer:SetColor( Color( 20,20,20,255 ) )
function Mixer:ValueChanged( col )
invcolor = Mixer:GetColor()
invalpha = invcolor.a
end

local checo = vgui.Create( "DCheckBox", frame2 )
checo:SetPos( 30, 270 )
checo:SetValue( invre )

local checolabo = vgui.Create( "DLabel", frame2 )
checolabo:SetPos( 50, 253 )
checolabo:SetSize(300,50)
checolabo:SetText( "Quando tiver aberto o inv fechar com R" )
function checo:OnChange( bVal )
    if ( bVal ) then
        invre = 1
    else
        invre = 0
    end
end

 
local apply = vgui.Create( "DButton", frame2 ) 
apply:SetText( "Apply Changes" )                
apply:SetPos( 25, 300 )             
apply:SetSize( 200, 30 )                
apply.DoClick = function()      
    file.Write( "inventory_settings.txt", invcolor.r..","..invcolor.g..","..invcolor.b..","..invalpha..","..invre ) 
   -- ply:SetPData("inventory_settings", invcolor.r..","..invcolor.g..","..invcolor.b..","..invalpha)     
end
 
local closebo = vgui.Create( "DButton", frame2 )
closebo:SetText( "X" )
closebo:SetTextColor( Color( 255, 255, 255 ) )
closebo:SetPos( 223, 3 )
closebo:SetSize( 25, 25 )
closebo.Paint = function( self, w, h )
    if self:IsHovered() then
    draw.RoundedBox( 10, 0, 0, w, h, Color( 255, 0, 0, 300 ) )
else
    draw.RoundedBox( 10, 0, 0, w, h, Color( 255, 0, 0, 80 ) )
    end
end
closebo.DoClick = function()
    open2 = false
    frame2:Close()
end
 
 
end





local grid = vgui.Create( "DGrid", freime )
grid:SetPos( 10, 40 )
grid:SetCols( 7 )
grid:SetColWide( 80 )       
grid:SetRowHeight(80)       

local grid2 = vgui.Create( "DGrid", freime )
grid2:SetPos( 10, 40 )
grid2:SetCols( 7 )
grid2:SetColWide( 80 )      
grid2:SetRowHeight(80)


for i = 1, invsize do   
    
local panel = vgui.Create( "DPanel" )
panel:SetSize( 75, 75 )

function panel:Paint( w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color( 30+invcolor.r, 30+invcolor.r, 30+invcolor.r,invalpha ) )
end

    grid:AddItem( panel )   
end


for i = 1, table.Count(entities) do

local kk    

if SpawnIconModels == false then
kk = vgui.Create( "DModelPanel", panel )
else
kk = vgui.Create( "SpawnIcon", panel )
end

local p = vgui.Create( "Panel" )
p:SetSize( 100, 15 )
p:SetVisible( false )

local TETO = vgui.Create( "DLabel", p )
TETO:SetPos( 0, 0 )
TETO:SetSize(100,15)
TETO:SetTextColor(Color(0,0,0))
if util.JSONToTable( entities[i] ).PrintName ~= nil then
TETO:SetText( "Name: "..util.JSONToTable( entities[i] ).PrintName )
else
TETO:SetText( "Name: Name not found" )
end


kk:SetModel(util.JSONToTable( entities[i] ).Model )
--kk:SetModel("models/weapons/w_pist_deagle.mdl" )
kk:SetTooltip( false )
kk:SetTooltipPanel( p )
kk:SetSize( 75, 75 )
 kk:SetPos(0,0)
 
if SpawnIconModels == true then
function kk:LayoutEntity( Entity )
    
local min,max = Entity:GetRenderBounds()

local d = min:Distance(max)
self:SetCamPos( Vector(0.55,0.55,0.7)*d )
self:SetLookAt( min+max )

Entity:SetAngles( Angle( 0, RealTime()*15, 0) )

end

end
 


 
kk.OnCursorEntered = function()

end
kk.OnCursorExited = function()
    
end

 
kk.DoClick = function()
    
    net.Start("spawna_sa_bosta")
    net.WriteFloat(i)
    net.SendToServer()
    
    table.remove(entities, i)
    table.remove(models, i)
    
    freime:Close()
    openinv()
end
 
grid2:AddItem( kk ) 
end


end
--openinv()


end