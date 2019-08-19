--[[
Nome da funo:ItemDoShop(entity)
Argumentos:Entity
Return:False/True
Descrio:Verifica se a entity faz parte dos items do shop
--]]

local TabI=
{
	"moeda_prata",
	"moeda_ouro",
	"gb5_m_clustermine_fraper_ad",
	"witcher_gateway",
	"gb5_base_advanced",
	"gb5_base_advanced_nuke",
	"gb5_base_clbomb",
	"gb5_base_dumb",
	"gb5_base_radiation_draw_ent",
	"gb5_base_radiation_draw_ent_fl",
	"gb5_base_radiation_ent",
	"gb5_base_rocket_",
	"gb5_blackhole_pull",
	"gb5_chemical_chlorinegas_b",
	"gb5_chemical_napalm",
	"gb5_chemical_napalm_b",
	"gb5_chemical_poisongas",
	"gb5_chemical_poisongas_b",
	"gb5_chemical_tvirus",
	"gb5_chemical_tvirus_cure",
	"gb5_chemical_tvirus_entity",
	"gb5_chemical_tvirus_entity_npc",
	"gb5_chemical_tvirus_entity_z",
	"gb5_chemical_tvirus_field",
	"gb5_chemical_vx_gas_dmg",
	"gb5_chemical_xg_gas",
	"gb5_cp_annie",
	"gb5_cp_anniebase",
	"gb5_cp_davy_propel",
	"gb5_cp_howitzer_can",
	"gb5_cp_howitzer_p",
	"gb5_dragonforce",
	"gb5_emitlight_nuke",
	"gb5_emp",
	"gb5_emp_entity",
	"gb5_emp_v_dead",
	"gb5_emp_v_dead",
	"gb5_fridge",
	"gb5_heavy_b_1000lb",
	"gb5_heavy_b_jdam",
	"gb5_heavy_b_liqtiberium",
	"gb5_heavy_b_t12",
	"gb5_heavy_b_thermobaric",
	"gb5_heavy_cbu",
	"gb5_heavy_cbu_bomblet",
	"gb5_light_b_50lb",
	"gb5_light_b_100lb",
	"gb5_light_b_c2",
	"gb5_light_b_c4",
	"gb5_light_b_nitro",
	"gb5_light_b_pressurecooker",
	"gb5_light_peldumb",
	"gb5_light_schrapnel_bomb",
	"gb5_m_clustermine",
	"gb5_m_clustermine_2",
	"gb5_m_clustermine_blet_ad",
	"gb5_m_clustermine_bomblet",
	"gb5_m_clustermine_fieldraper",
	"gb5_m_clustermine_fraper_ad",
	"gb5_m_schrapnel_mine",
	"gb5_medium_b_500lb",
	"gb5_medium_b_mk82",
	"gb5_medium_m_thermobaric",
	"gb5_misc_propane_can",
	"gb5_misc_tower_01",
	"gb5_misc_tower_02",
	"gb5_misc_wildfire_barrel",
	"gb5_misc_wildfire_vial",
	"gb5_nuclear_antimatter",
	"gb5_nuclear_c_b1",
	"gb5_nuclear_c_h1",
	"gb5_nuclear_c_plutonium",
	"gb5_nuclear_c_tritium",
	"gb5_nuclear_c_uranium",
	"gb5_nuclear_c_uranium238",
	"gb5_nuclear_clusternuke",
	"gb5_nuclear_davy_launcher",
	"gb5_nuclear_davy_tripod",
	"gb5_nuclear_davycrockett",
	"gb5_nuclear_fatman",
	"gb5_nuclear_fission_rad_base",
	"gb5_nuclear_fizzion_rad",
	"gb5_nuclear_grable",
	"gb5_nuclear_initiator",
	"gb5_nuclear_ivymike",
	"gb5_nuclear_littleboy",
	"gb5_nuclear_propellant",
	"gb5_nuclear_trinity",
	"gb5_nuclear_tsarbomba",
	"gb5_proj_howitzer_shell_cl",
	"gb5_proj_howitzer_shell_frag",
	"gb5_proj_howitzer_shell_he",
	"gb5_proj_howitzer_shell_in",
	"gb5_proj_icbm",
	"gb5_proj_icbm_big",
	"gb5_proj_icbm_small",
	"gb5_proj_icbm_wh",
	"gb5_proj_pho-torp",
	"gb5_proj_tankshell",
	"gb5_proj_tankshell_170",
	"gb5_proj_tankshell_240",
	"gb5_proj_tomahawk",
	"gb5_proj_v2_small",
	"gb5_propellant_antimatter",
	"gb5_propellant_hydrogen",
	"gb5_propellant_oxykerosine",
	"gb5_propellant_petrolium",
	"gb5_propellant_trilithium",
	"gb5_radbarrel",
	"gb5_redmatter_pull",
	"gb5_shadow_cloak",
	"gb5_shadowdragonforce",
	"gb5_shadowdrive",
	"gb5_shadoweruption",
	"gb5_shadowroar",
	"gb5_shadowvortex",
	"gb5_shockwave_cold",
	"gb5_shockwave_ent",
	"gb5_shockwave_ent_dir_vec",
	"gb5_shockwave_ent_gravity",
	"gb5_shockwave_ent_instant",
	"gb5_shockwave_ent_nondmg",
	"gb5_shockwave_fire",
	"gb5_shockwave_fire_dmg",
	"gb5_shockwave_roar",
	"gb5_shockwave_rumbling",
	"gb5_shockwave_sin",
	"gb5_shockwave_sound_burst",
	"gb5_shockwave_sound_instant",
	"gb5_shockwave_sound_lowsh",
	"gb5_sp_antigravity",
	"gb5_sp_attraction_bomb",
	"gb5_sp_blackhole_bomb",
	"gb5_sp_endothermic",
	"gb5_sp_exothermic",
	"gb5_sp_flashbang",
	"gb5_sp_fusionbomb",
	"gb5_sp_hypersonic",
	"gb5_sp_redmatter_bomb",
	"gb5_sp_repulsion_bomb",
	"gb5_sp_singularitybomb",
	"gb5_sp_spacenuke",
	"gb5_sp_supersonic",
	"gb5_tiberium_crystal",
	"gb5_unholyshadowroar",
	"gb5_whiteshadow_roar",
	"gb5_wshadowmode",
	"sent_jetpack",
	"base_predictedent",
	"sent_soccerball",
	"sent_goalpost",
	"alchemy_table_cheat",
	"prop_engine_take",
	"propellerengine",
	"pill_ent_phys",
	"tela1",
	"tela2",
	"sent_grapplehook_bpack",
	"sent_grapplehook_hookhelper",
	"algogenerico5",
	"algogenerico4",
	"algogenerico3",
	"algogenerico2",
	"algogenerico1",
	"fun_foguetinho",
	"fun_tintainvisivel",
	"mining_smelting_basic",
	"mining_centrifuge",
	"mining_coal_purer",
	"mining_refinary_effiecient",
	"mining_smelting_hot",
	"mining_refinary_modern",
	"mining_smelting_normal",
	"mining_refinary_old",
	"mining_refinary_quick",
	"mining_smelting_quick",
	"mining_selling_machine",
	"mining_nukekit",
	"mining_nuke"

}


local function UmaFuncaoDeReturn(Ent)
	local IsTrue=false
	for x,i in pairs(TabI) do
		if Ent:GetClass()==i	then IsTrue=true end	
		end
	return IsTrue
	end



local meta={}	

function meta.__call( self, var )
	self.myvar = var	
	return var -- + self:ItemDoShop()
end

local metaIndex=FindMetaTable( "Entity" )

function metaIndex.ItemDoShop( self )
	return UmaFuncaoDeReturn(self)
end

meta.__index = metaIndex

local myObject = {}

setmetatable( myObject, meta )



myObject.myvar = true
--print( Entity(2):ItemDoShop() )
