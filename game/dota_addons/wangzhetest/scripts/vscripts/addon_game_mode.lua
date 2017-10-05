--注册游戏的类
if CbtfGameMode == nil then
	CbtfGameMode = class({})
end

--[[BbtfStart=0
--************************************攻防相克表***********************
--********************************************************************
]]


require('require_everything')
require('UNITS/king')

_G.Vesion = "v1.11"
wushuang = require('md5')

-------------------------------------------------------------------------------------------------------------------
local function PrecacheSound(sound, context )
	PrecacheResource( "soundfile", sound, context)
end
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
local function PrecacheParticle(particle, context )
	PrecacheResource( "particle",  particle, context)
end
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
local function PrecacheModel(model, context )
	PrecacheResource( "model", model, context )
end
--------------------------------------------------------------------- ----------------------------------------------

-------------------------------------------------------------------------------------------------------------------

--预载入--------

function PrecacheEveryThingFromKV( context )
	local kv_files = {"scripts/npc/npc_units_custom.txt","scripts/npc/npc_abilities_custom.txt","scripts/npc/npc_heroes_custom.txt","scripts/npc/npc_abilities_override.txt"}
	for _, kv in pairs(kv_files) do
		local kvs = LoadKeyValues(kv)
		if kvs then
			-- print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
			PrecacheEverythingFromTable( context, kvs)
		end
	end
	local zr={
		--dummy

		{"model", "models/items/pedestals/pedestal_2/pedestal_2.vmdl"},
		{"model", "models/courier/frull/frull_courier_flying.vmdl"},
		{"model", "models/items/courier/gnomepig/gnomepig_flying.vmdl"},


		--left king
		{"model", "models/heroes/chen/chen.vmdl"},
		{"model", "models/items/chen/squareskystaff_weapon/squareskystaff_weapon.vmdl"},
		{"model", "models/items/chen/weapon_navi/weapon_navi.vmdl"},
		{"model", "models/items/chen/armor_navi/armor_navi.vmdl"},
		{"model", "models/items/chen/arms_navi/arms_navi.vmdl"},
		{"model", "models/items/chen/head_navi/head_navi.vmdl"},
		{"model", "models/items/chen/mount_navi_new/mount_navi_new.vmdl"},
		{"model", "models/items/chen/shoulder_navi/shoulder_navi.vmdl"},
		{"model", "models/items/chen/neck_desert/neck_desert.vmdl"},
		{"model", "models/items/chen/desert_gale_shoulder_plate/desert_gale_shoulder_plate.vmdl"},

		--right king
		{"model", "models/heroes/abaddon/abaddon.vmdl"},
		{"model", "models/items/abaddon/netherax_nightmare_of_the_mist/netherax_nightmare_of_the_mist.vmdl"},
		{"model", "models/items/abaddon/alliance_abba_back/alliance_abba_back.vmdl"},
		{"model", "models/items/abaddon/alliance_abba_head/alliance_abba_head.vmdl"},
		{"model", "models/items/abaddon/mistblade/mistblade.vmdl"},
		{"model", "models/items/abaddon/alliance_abba_shoulder/alliance_abba_shoulder.vmdl"},


		--Q1 00
		{"model", "models/heroes/sven/sven_belt.vmdl"},
		{"model", "models/heroes/sven/sven_gauntlet.vmdl"},
		{"model", "models/heroes/sven/sven_mask.vmdl"},
		{"model", "models/heroes/sven/sven_shoulder.vmdl"},
		{"model", "models/heroes/sven/sven_sword.vmdl"},

		--Q1 10
		{"model", "models/items/sven/mono_militis_head.vmdl"},
		{"model", "models/items/sven/mono_militis_shoulder.vmdl"},
		{"model", "models/items/sven/mono_militis_weapon.vmdl"},
		{"particle", "particles/base_attacks/ranged_badguy_explosion.vpcf"},

		--Q1 20
		{"model", "models/items/sven/ceremonialtassetsofthemyrmidon/ceremonialtassetsofthemyrmidon.vmdl"},
		{"model", "models/items/sven/sven_ceremonialarmbladesofthemyrmidon/sven_ceremonialarmbladesofthemyrmidon.vmdl"},
		{"model", "models/items/sven/sven_ceremonialgreathelmofthemyrmidon/sven_ceremonialgreathelmofthemyrmidon.vmdl"},
		{"model", "models/items/sven/sven_ceremonialshieldbladeofthemyrmidon/sven_ceremonialshieldbladeofthemyrmidon.vmdl"},
		{"model", "models/items/sven/sven_ceremonialshoulderbladesofthemyrmidon/sven_ceremonialshoulderbladesofthemyrmidon.vmdl"},
		{"particle", "particles/zjz_units/q1_20_skill02.vpcf"},
		{"particle", "particles/units/heroes/hero_sven/sven_gods_strength_hero_effect.vpcf"},


		--Q1 21

		{"model", "models/items/sven/belt_of_tielong/belt_of_tielong.vmdl"},
		{"model", "models/items/sven/breath_of_tielong/breath_of_tielong.vmdl"},
		{"model", "models/items/sven/gauntlet_of_tielong/gauntlet_of_tielong.vmdl"},
		{"model", "models/items/sven/helmet_of_tielong/helmet_of_tielong.vmdl"},
		{"model", "models/items/sven/pauldron_of_tielong/pauldron_of_tielong.vmdl"},

		--Q2 00
		--"models/heroes/lycan/lycan.vmdl"},,
		{"model", "models/heroes/lycan/lycan_blades.vmdl"},--206
		{"model", "models/heroes/lycan/lycan_head.vmdl"},	--207
		{"model", "models/heroes/lycan/lycan_armor.vmdl"}, --208
		{"model", "models/heroes/lycan/lycan_fur.vmdl"},--209
		{"model", "models/heroes/lycan/lycan_belt.vmdl"}, --210

		--Q2 10
		{"model", "models/items/lycan/armor_royal/armor_royal.vmdl"},--4974
		{"model", "models/items/lycan/belt_alpha/belt_alpha.vmdl"},--4975
		{"model", "models/items/lycan/clawsy_greatg/clawsy_greatg.vmdl"},--4976
		{"model", "models/items/lycan/shoulder_alpha/shoulder_alpha.vmdl"},--4977
		{"model", "models/items/lycan/head_alpha/head_alpha.vmdl"},--4978

		--Q2 20
		{"model", "models/items/lycan/sanguinemoon_armor/sanguinemoon_armor.vmdl"}, --4859
		{"model", "models/items/lycan/sanguinemoon_shoulder/sanguinemoon_shoulder.vmdl"},--4860
		{"model", "models/items/lycan/sanguinemoon_weapon/sanguinemoon_weapon.vmdl"}, --4861
		{"model", "models/items/lycan/sanguinemoon_belt/sanguinemoon_belt.vmdl"},--4862
		{"model", "models/items/lycan/sanguinemoon_head/sanguinemoon_head.vmdl"}, --4863

		--Q2 21
		--"models/items/lycan/ultimate/thegreatcalamityti4/thegreatcalamityti4.vmdl"},,
		--Q2 1a 幼狼
		--"models/items/lycan/wolves/alpha_summon_01/alpha_summon_01.vmdl"},,
		--Q2 2a 野狼
		--"models/heroes/lycan/summon_wolves.vmdl"},,

		--Q3 00
		--"models/heroes/life_stealer/life_stealer.vmdl"},,
		--Q3 10
		{"model", "models/items/lifestealer/ravenous_head/ravenous_head.vmdl"},--6260
		{"model", "models/items/lifestealer/ravenous_arms/ravenous_arms.vmdl"},--6261
		{"model", "models/items/lifestealer/ravenous_belt/ravenous_belt.vmdl"},--6262
		{"model", "models/items/lifestealer/ravenous_back/ravenous_back.vmdl"},--6263
		--Q3 20
		{"model", "models/items/lifestealer/redrage_head/redrage_head.vmdl"},--6318
		{"model", "models/items/lifestealer/redrage_belt/redrage_belt.vmdl"},--6319
		{"model", "models/items/lifestealer/redrage_battlewings/redrage_battlewings.vmdl"},--6320
		{"model", "models/items/lifestealer/redrage_bracers/redrage_bracers.vmdl"},--6321

		--Q4 00
		--"models/heroes/faceless_void/faceless_void.vmdl"},,
		{"model", "models/heroes/faceless_void/faceless_void_weapon.vmdl"},--15
		{"model", "models/heroes/faceless_void/faceless_void_head.vmdl"},--90
		{"model", "models/heroes/faceless_void/faceless_void_shoulder.vmdl"},--91
		{"model", "models/heroes/faceless_void/faceless_void_bracer.vmdl"},--92
		{"model", "models/heroes/faceless_void/faceless_void_belt.vmdl"},--93

		--Q4 10
		{"model", "models/items/faceless_void/acolyte_belt/acolyte_belt.vmdl"},--5059
		{"model", "models/items/faceless_void/acolyte_cowl/acolyte_cowl.vmdl"},--5060
		{"model", "models/items/faceless_void/acolyte_gauntlet/acolyte_gauntlet.vmdl"},--5061
		{"model", "models/items/faceless_void/acolyte_mace/acolyte_mace.vmdl"},--5062
		{"model", "models/items/faceless_void/acolyte_hood/acolyte_hood.vmdl"},--5063

		--Q4 20
		{"model", "models/items/faceless_void/timelord_bracers/timelord_bracers.vmdl"},--5861
		{"model", "models/items/faceless_void/timelord_head/timelord_head.vmdl"},--5868
		{"model", "models/items/faceless_void/timelord_shoulders/timelord_shoulders.vmdl"},--5896
		{"model", "models/items/faceless_void/timelord_skirt/timelord_skirt.vmdl"},--5897
		{"model", "models/items/faceless_void/timelord_weapon/timelord_weapon.vmdl"},--5898

		--Q5 00
		{"model", "models/items/slark/deep_warden_scimitar/deep_warden_scimitar.vmdl"},--5261
		{"model", "models/items/slark/deep_warden_pauldron/deep_warden_pauldron.vmdl"},--5262
		{"model", "models/items/slark/deep_warden_bracer/deep_warden_bracer.vmdl"},--5263
		{"model", "models/items/slark/deep_warden_cape/deep_warden_cape.vmdl"},--5264
		{"model", "models/items/slark/deep_warden_hood/deep_warden_hood.vmdl"},--5265

		--Q5 10
		{"model", "models/items/slark/deepscoundrel_arms/deepscoundrel_arms.vmdl"},--6417
		{"model", "models/items/slark/deepscoundrel_back/deepscoundrel_back.vmdl"},--6418
		{"model", "models/items/slark/deepscoundrel_weapon/deepscoundrel_weapon.vmdl"},--6419
		{"model", "models/items/slark/deepscoundrel_shoulder/deepscoundrel_shoulder.vmdl"},--6420
		{"model", "models/items/slark/deepscoundrel_head/deepscoundrel_head.vmdl"},--6421

		--Q5 20
		{"model", "models/items/slark/dark_reef_arms/dark_reef_arms.vmdl"},--7710
		{"model", "models/items/slark/dark_reef_back/dark_reef_back.vmdl"},--7711
		{"model", "models/items/slark/dark_reef_head/dark_reef_head.vmdl"},--7712
		{"model", "models/items/slark/dark_reef_shoulders/dark_reef_shoulders.vmdl"},--7713
		{"model", "models/items/slark/dark_reef_weapon/dark_reef_weapon.vmdl"},--7714

		--Q5 21
		{"model", "models/items/slark/oceanconquerer_back/oceanconquerer_back.vmdl"},--6383
		{"model", "models/items/slark/oceanconquerer_shoulder/oceanconquerer_shoulder.vmdl"},--6392
		{"model", "models/items/slark/oceanconquerer_head/oceanconquerer_head.vmdl"},--6405
		{"model", "models/items/slark/oceanconquerer_arms/oceanconquerer_arms.vmdl"},--6406
		{"model", "models/items/slark/oceanconquerer_weapon/oceanconquerer_weapon.vmdl"},--6407

		--W1 00
		--{"model", "models/heroes/sniper/sniper.vmdl"},
		{"model", "models/heroes/sniper/bracer.vmdl"},
		{"model", "models/heroes/sniper/cape.vmdl"},
		{"model", "models/heroes/sniper/headitem.vmdl"},
		{"model", "models/heroes/sniper/shoulder.vmdl"},
		{"model", "models/heroes/sniper/weapon.vmdl"},
		--W1 10
		{"model", "models/items/sniper/sharpshooter_stache/sharpshooter_stache.vmdl"},
		{"model", "models/items/sniper/killstealer/killstealer.vmdl"},
		{"model", "models/items/sniper/sharpshooter_shoulder/sharpshooter_shoulder.vmdl"},
		{"model", "models/items/sniper/sharpshooter_cloak/sharpshooter_cloak.vmdl"},
		{"model", "models/items/sniper/sharpshooter_arms/sharpshooter_arms.vmdl"},
		--W1 11
		--{"model", "models/heroes/techies/techies.vmdl"},
		{"model", "models/heroes/techies/techies_barrel.vmdl"},
		{"model", "models/heroes/techies/techies_spleen_weapon.vmdl"},
		{"model", "models/heroes/techies/techies_cart.vmdl"},
		{"model", "models/heroes/techies/techies_spleen_costume.vmdl"},
		{"model", "models/heroes/techies/techies_squee_costume.vmdl"},
		--W1 20
		{"model", "models/items/sniper/wildwest_weapon/wildwest_weapon.vmdl"},
		{"model", "models/items/sniper/wildwest_head/wildwest_head.vmdl"},
		{"model", "models/items/sniper/wildwest_back/wildwest_back.vmdl"},
		{"model", "models/items/sniper/wildwest_shoulders/wildwest_shoulders.vmdl"},
		{"model", "models/items/sniper/wildwest_arms/wildwest_arms.vmdl"},
		--W1 21
		{"model", "models/items/techies/bigshot/bigshot.vmdl"},
		{"model", "models/items/techies/bigshot/bigshot_spleen_costume.vmdl"},
		{"model", "models/items/techies/bigshot/bigshot_squee_costume.vmdl"},
		{"model", "models/items/techies/bigshot/bigshot_barrel.vmdl"},
		{"model", "models/items/techies/bigshot/bigshot.vmdl"},

		--W2 00  models/heroes/huskar/huskar.vmdl
		{"model", "models/heroes/huskar/huskar_spear.vmdl"},--268
		{"model", "models/heroes/huskar/huskar_dagger.vmdl"},--269
		{"model", "models/heroes/huskar/huskar_helmet.vmdl"},--270
		{"model", "models/heroes/huskar/huskar_shoulder.vmdl"},--271
		{"model", "models/heroes/huskar/huskar_bracer.vmdl"},--272

		--W2 10
		{"model", "models/items/huskar/sacred_bones_offhand_weapon/sacred_bones_offhand_weapon.vmdl"}, --4906
		{"model", "models/items/huskar/sacred_bones_shoulder/sacred_bones_shoulder.vmdl"}, --4907
		{"model", "models/items/huskar/sacred_bones_arms/sacred_bones_arms.vmdl"}, --4908
		{"model", "models/items/huskar/sacred_bones_helmet/sacred_bones_helmet.vmdl"},--4909
		{"model", "models/items/huskar/sacred_bones_spear/sacred_bones_spear.vmdl"}, --4910

		--W2 20
		{"model", "models/items/huskar/obsidian_claw_of_the_jaguar_arms/obsidian_claw_of_the_jaguar_arms.vmdl"}, --4299
		{"model", "models/items/huskar/obsidian_claw_of_the_jaguar_helmet/obsidian_claw_of_the_jaguar_helmet.vmdl"},--4300
		{"model", "models/items/huskar/obsidian_claw_of_the_jaguar_shoulder/obsidian_claw_of_the_jaguar_shoulder.vmdl"},--4301
		{"model", "models/items/huskar/obsidian_blade_spear/obsidian_blade_spear.vmdl"},--4748
		{"model", "models/items/huskar/obsidian_claw_of_the_jaguar_dagger/obsidian_claw_of_the_jaguar_dagger.vmdl"},--4749

		--W3 00 models/heroes/clinkz/clinkz.vmdl
		{"model", "models/heroes/clinkz/clinkz_head.vmdl"}, --56 通用
		{"model", "models/heroes/clinkz/clinkz_bow.vmdl"},  --57
		{"model", "models/heroes/clinkz/clinkz_pads.vmdl"},  --58
		{"model", "models/heroes/clinkz/clinkz_back.vmdl"},  --59
		{"model", "models/heroes/clinkz/clinkz_horns.vmdl"}, --60
		{"model", "models/heroes/clinkz/clinkz_gloves.vmdl"}, --61

		--W3 10
		{"model", "models/items/clinkz/clinkz_weapon_goc/clinkz_weapon_goc.vmdl"},--4741
		{"model", "models/items/clinkz/clinkz_shoulders_goc/clinkz_shoulders_goc.vmdl"},--4742
		{"model", "models/items/clinkz/clinkz_helmet01_goc/clinkz_helmet01_goc.vmdl"},--4971
		{"model", "models/items/clinkz/clinkz_hands_goc/clinkz_hands_goc.vmdl"},--4972
		{"model", "models/items/clinkz/clinkz_back_goc/clinkz_back_goc.vmdl"},--4973

		--W3 20
		{"model", "models/items/clinkz/lost_viking_back/lost_viking_back.vmdl"},--5151
		{"model", "models/items/clinkz/lost_viking_bow/lost_viking_bow.vmdl"},--5152
		{"model", "models/items/clinkz/lost_viking_gauntlet/lost_viking_gauntlet.vmdl"},--5153
		{"model", "models/items/clinkz/lost_viking_helmet/lost_viking_helmet.vmdl"},--5154
		{"model", "models/items/clinkz/lost_viking_shoulder/lost_viking_shoulder.vmdl"},--5155

		--W4 00 models/heroes/lanaya/lanaya.vmdl
		{"model", "models/heroes/lanaya/lanaya_hair.vmdl"},--173
		{"model", "models/heroes/lanaya/lanaya_cowl_shoulder.vmdl"},--174
		{"model", "models/heroes/lanaya/lanaya_bracers_skirt.vmdl"},--175

		--W4 10
		{"model", "models/items/lanaya/thiefscholar_girdle/thiefscholar_girdle.vmdl"}, --4695
		{"model", "models/items/lanaya/thiefscholar_coiffure/thiefscholar_coiffure.vmdl"},--4696
		{"model", "models/items/lanaya/thiefscholar_shoulder/thiefscholar_shoulder.vmdl"},--4697

		--W4 20
		{"model", "models/items/lanaya/ta_ns_shoulder/ta_ns_shoulder.vmdl"},--4668
		{"model", "models/items/lanaya/ta_ns_armor/ta_ns_armor.vmdl"},--4669
		{"model", "models/items/lanaya/ta_ns_head/ta_ns_head.vmdl"},--4670

		--W5 00 models/heroes/shadowshaman/shadowshaman.vmdl
		{"model", "models/heroes/shadowshaman/head.vmdl"},--251  通用
		{"model", "models/items/shadowshaman/shades_weapon/shades_weapon.vmdl"},--6197
		{"model", "models/items/shadowshaman/shades_offhand/shades_offhand.vmdl"},--6198
		{"model", "models/items/shadowshaman/shades_belt/shades_belt.vmdl"},--6206
		{"model", "models/items/shadowshaman/shades_arms/shades_arms.vmdl"},--6309
		{"model", "models/items/shadowshaman/shades_head/shades_head.vmdl"}, --6310

		--W5 10
		{"model", "models/items/shadowshaman/vagabond_pack/vagabond_pack.vmdl"}, --4412
		{"model", "models/items/shadowshaman/vagabond_wand/vagabond_wand.vmdl"},--4416
		{"model", "models/items/shadowshaman/vagabond_hat/vagabond_hat.vmdl"},--4417
		{"model", "models/items/shadowshaman/vagabond_drink/vagabond_drink.vmdl"},--4419

		--W5 20
		{"model", "models/items/shadowshaman/tangki_offhand/tangki_offhand.vmdl"},--6814
		{"model", "models/items/shadowshaman/tangki_weapon/tangki_weapon.vmdl"},--6816
		{"model", "models/items/shadowshaman/tangki_arms/tangki_arms.vmdl"},--6817
		{"model", "models/items/shadowshaman/tangki_belt/tangki_belt.vmdl"},--6818
		{"model", "models/items/shadowshaman/tangki_head/tangki_head.vmdl"},--6819

		--W5 21
		{"model", "models/items/shadowshaman/eki_bukaw_bracers/eki_bukaw_bracers.vmdl"},--5501
		{"model", "models/items/shadowshaman/records_of_the_eki_bukaw/records_of_the_eki_bukaw.vmdl"},--5500
		{"model", "models/items/shadowshaman/eki_bukaw_wand__offhand/eki_bukaw_wand__offhand.vmdl"},--5503
		{"model", "models/items/shadowshaman/eki_bukaw_wand/eki_bukaw_wand.vmdl"},--5504
		{"model", "models/items/shadowshaman/visage_of_eki_bukaw/visage_of_eki_bukaw.vmdl"},--5548

		--E1 00 models/heroes/tiny_02/tiny_02.vmdl
		{"model", "models/heroes/tiny_01/tiny_01_body.vmdl"},--494
		{"model", "models/heroes/tiny_01/tiny_01_head.vmdl"},--493
		{"model", "models/heroes/tiny_01/tiny_01_left_arm.vmdl"},--495
		{"model", "models/heroes/tiny_01/tiny_01_right_arm.vmdl"},--496

		--E1 10
		{"model", "models/items/tiny/scarletquarry_arms/scarletquarry_arms.vmdl"},--6886
		{"model", "models/items/tiny/scarletquarry_offhand/scarletquarry_offhand.vmdl"},--6998
		{"model", "models/items/tiny/scarletquarry_head/scarletquarry_head.vmdl"},--6999
		{"model", "models/items/tiny/scarletquarry_armor/scarletquarry_armor.vmdl"},--7000


		--E2 00 models/heroes/undying/undying.vmdl
		{"model", "models/heroes/undying/undying_helmet.vmdl"}, --392
		{"model", "models/heroes/undying/undying_armor.vmdl"}, --393

		--E2 10 models/heroes/undying/undying_flesh_golem.vmdl

		--E2 1a models/heroes/undying/undying_minion.vmdl

		--E3 00 models/heroes/wraith_king/wraith_king.vmdl
		{"model", "models/heroes/wraith_king/wraith_king_chest.vmdl"}, --500 通用
		{"model", "models/items/wraith_king/eternal_arms/eternal_arms.vmdl"},--6171
		{"model", "models/items/wraith_king/eternal_back/eternal_back.vmdl"}, --6172
		{"model", "models/items/wraith_king/eternal_blade/eternal_blade.vmdl"}, --6173
		{"model", "models/items/wraith_king/eternal_head/eternal_head.vmdl"},--6174
		{"model", "models/items/wraith_king/eternal_shoulder/eternal_shoulder.vmdl"},--6175

		--E3 10
		{"model", "models/items/wraith_king/regalia_of_the_wraith_lord_back/regalia_of_the_wraith_lord_back.vmdl"},--5052
		{"model", "models/items/wraith_king/regalia_of_the_wraith_lord_sword/regalia_of_the_wraith_lord_sword.vmdl"},--5053
		{"model", "models/items/wraith_king/regalia_of_the_wraith_lord_bracers/regalia_of_the_wraith_lord_bracers.vmdl"},--5054
		{"model", "models/items/wraith_king/regalia_of_the_wraith_lord_helmet/regalia_of_the_wraith_lord_helmet.vmdl"},--5055
		{"model", "models/items/wraith_king/regalia_of_the_wraith_lord_shoulder/regalia_of_the_wraith_lord_shoulder.vmdl"},--5056

		--E4 00 models/heroes/shredder/shredder.vmdl
		{"model", "models/heroes/shredder/shredder_driver_hat.vmdl"},--386
		{"model", "models/heroes/shredder/shredder_chainsaw.vmdl"},--388(注意不连贯)
		{"model", "models/heroes/shredder/shredder_shoulders.vmdl"},--389
		{"model", "models/heroes/shredder/shredder_body.vmdl"},--390
		{"model", "models/heroes/shredder/shredder_armor.vmdl"},--401
		{"model", "models/heroes/shredder/shredder_hook.vmdl"},--402

		--E4 10
		{"model", "models/items/shredder/timberthaw_armor/timberthaw_armor.vmdl"},--6519
		{"model", "models/items/shredder/timberthaw_weapon/timberthaw_weapon.vmdl"},--6520
		{"model", "models/items/shredder/timberthaw_head/timberthaw_head.vmdl"},--6521
		{"model", "models/items/shredder/timberthaw_offhand/timberthaw_offhand.vmdl"},--6522
		{"model", "models/items/shredder/timberthaw_shoulder/timberthaw_shoulder.vmdl"},--6523
		{"model", "models/items/shredder/timberthaw_back/timberthaw_back.vmdl"},--6524

		--E5 00 models/heroes/chaos_knight/chaos_knight.vmdl
		{"model", "models/items/chaos_knight/chaos_legion_mount/chaos_legion_mount.vmdl"},--5980
		{"model", "models/items/chaos_knight/chaos_legion_drapes/chaos_legion_drapes.vmdl"},--5981
		{"model", "models/items/chaos_knight/chaos_legion_helm/chaos_legion_helm.vmdl"},--5982
		{"model", "models/items/chaos_knight/chaos_legion_shield/chaos_legion_shield.vmdl"},--5983
		{"model", "models/items/chaos_knight/chaos_legion_weapon/chaos_legion_weapon.vmdl"},--5984

		--E5 10
		{"model", "models/items/chaos_knight/ck_esp_blade/ck_esp_blade.vmdl"},--5518
		{"model", "models/items/chaos_knight/ck_esp_helm/ck_esp_helm.vmdl"},--5519
		{"model", "models/items/chaos_knight/ck_esp_mount/ck_esp_mount.vmdl"},--5520
		{"model", "models/items/chaos_knight/ck_esp_shield/ck_esp_shield.vmdl"},--5521
		{"model", "models/items/chaos_knight/ck_esp_shoulder/ck_esp_shoulder.vmdl"},--5522

		--E5 11
		{"model", "models/items/chaos_knight/rising_chaos_blade/rising_chaos_blade.vmdl"},--5921
		{"model", "models/items/chaos_knight/rising_chaos_helm/rising_chaos_helm.vmdl"},--5922
		{"model", "models/items/chaos_knight/rising_chaos_spaulders/rising_chaos_spaulders.vmdl"},--5923
		{"model", "models/items/chaos_knight/rising_chaos_steed/rising_chaos_steed.vmdl"},--5924
		{"model", "models/items/chaos_knight/rising_chaos_shield/rising_chaos_shield.vmdl"},--5925

		--E6 00 models/heroes/nerubian_assassin/nerubian_assassin.vmdl
		{"model", "models/items/nerubian_assassin/nyx_dusky_back/nyx_dusky_back.vmdl"},--5567
		{"model", "models/items/nerubian_assassin/nyx_dusky_head/nyx_dusky_head.vmdl"},--5568
		{"model", "models/items/nerubian_assassin/nyx_dusky_misc/nyx_dusky_misc.vmdl"},--5569
		{"model", "models/items/nerubian_assassin/nyx_dusky_weapon/nyx_dusky_weapon.vmdl"},--5570

		--E6 10
		{"model", "models/items/nerubian_assassin/spines_of_the_predator/spines_of_the_predator.vmdl"},--5201
		{"model", "models/items/nerubian_assassin/mind_piercer_of_the_predator/mind_piercer_of_the_predator.vmdl"},--5202
		{"model", "models/items/nerubian_assassin/preyfinders_of_the_predator/preyfinders_of_the_predator.vmdl"},--5203
		{"model", "models/items/nerubian_assassin/blades_of_the_predator/blades_of_the_predator.vmdl"},--5204

		--E6 11 models/heroes/broodmother/broodmother.vmdl (和E6 10模型不一样)
		{"model", "models/items/broodmother/abdomen_of_perception/abdomen_of_perception.vmdl"},--5854
		{"model", "models/items/broodmother/crown_of_perception/crown_of_perception.vmdl"}, --5891
		{"model", "models/items/broodmother/legs_of_perception/legs_of_perception.vmdl"}, --5892

		--E6 1a  models/heroes/broodmother/spiderling.vmdl

		--D1 00 models/heroes/storm_spirit/storm_spirit.vmdl
		{"model", "models/items/storm_spirit/festive_dress_of_good_fortune/festive_dress_of_good_fortune.vmdl"}, --6019
		{"model", "models/items/storm_spirit/ornate_hat_of_good_fortune/ornate_hat_of_good_fortune.vmdl"},--6022
		{"model", "models/items/storm_spirit/scale_pauldrons_of_good_fortune/scale_pauldrons_of_good_fortune.vmdl"},--6023

		--D1 10
		{"model", "models/items/storm_spirit/heavenlygeneral_armor/heavenlygeneral_armor.vmdl"},--6168
		{"model", "models/items/storm_spirit/heavenlygeneral_hat/heavenlygeneral_hat.vmdl"},--6169
		{"model","models/items/storm_spirit/heavenlygeneral_shoulders/heavenlygeneral_shoulders.vmdl"},--6170

		--D2 00 models/heroes/earth_spirit/earth_spirit.vmdl
		{"model","models/heroes/earth_spirit/earth_spirit_head.vmdl"},--482 通用
		{"model","models/items/earth_spirit/demon_stone_bracers/demon_stone_bracers.vmdl"},--6002
		{"model","models/items/earth_spirit/demon_stone_belt/demon_stone_belt.vmdl"},--6003
		{"model","models/items/earth_spirit/demon_stone_hair/demon_stone_hair.vmdl"}, --6004
		{"model","models/items/earth_spirit/demon_stone_necklace/demon_stone_necklace.vmdl"}, --6005
		{"model","models/items/earth_spirit/demon_stone_weapon/demon_stone_weapon.vmdl"}, --6006

		--D2 10
		{"model","models/items/earth_spirit/vanquishing_demons_arms/vanquishing_demons_arms.vmdl"},--6432
		{"model","models/items/earth_spirit/vanquishing_demons_belt/vanquishing_demons_belt.vmdl"},--6433
		{"model","models/items/earth_spirit/vanquishing_demons_helmet/vanquishing_demons_helmet.vmdl"},--6434
		{"model","models/items/earth_spirit/vanquishing_demons_neck/vanquishing_demons_neck.vmdl"},--6435
		{"model","models/items/earth_spirit/vanquishing_demons_weapon/vanquishing_demons_weapon.vmdl"},--6436

		--D3 00 D3 10 models/heroes/zuus/zuus.vmdl
		{"model","models/items/zeus/lightning_weapon/zuus_lightning_weapon.vmdl"}, --5412
		--D4 00  models/heroes/nevermore/nevermore.vmdl

		--D4 10  models/heroes/shadow_fiend/shadow_fiend.vmdl
		{"model","models/heroes/shadow_fiend/shadow_fiend_head.vmdl"},--387
		{"model","models/heroes/shadow_fiend/shadow_fiend_shoulders.vmdl"},--486
		{"model","models/heroes/shadow_fiend/shadow_fiend_arms.vmdl"},--488

		--D5 00 models/heroes/medusa/medusa.vmdl
		{"model","models/heroes/medusa/medusa_bow.vmdl"},--381
		{"model","models/heroes/medusa/medusa_veil.vmdl"},--382
		{"model","models/heroes/medusa/medusa_torso.vmdl"},--383
		{"model","models/heroes/medusa/medusa_arms.vmdl"},--384
			{"model","models/heroes/medusa/medusa_tail.vmdl"},--385

		--D5 10
		{"model","models/items/medusa/forsaken_beauty_arms/forsaken_beauty_arms.vmdl"},--5004
		{"model","models/items/medusa/forsaken_beauty_bow/forsaken_beauty_bow.vmdl"},--5005
		{"model","models/items/medusa/forsaken_beauty_chest/forsaken_beauty_chest.vmdl"},--5006
		{"model","models/items/medusa/forsaken_beauty_head/forsaken_beauty_head.vmdl"},--5007
		{"model","models/items/medusa/forsaken_beauty_tail/forsaken_beauty_tail.vmdl"},--5008

		--D6 00 models/heroes/drow/drow.vmdl
		{"model","models/items/drow/gauntlets_of_the_boreal_watch/gauntlets_of_the_boreal_watch.vmdl"},--5194
		{"model","models/items/drow/legplates_of_the_boreal_watch/legplates_of_the_boreal_watch.vmdl"},--5195
		{"model","models/items/drow/longbow_of_the_boreal_watch/longbow_of_the_boreal_watch.vmdl"},--5196
		{"model","models/items/drow/cowl_of_the_boreal_watch/cowl_of_the_boreal_watch.vmdl"},--5197
		{"model","models/items/drow/pauldrons_of_the_boreal_watch/pauldrons_of_the_boreal_watch.vmdl"},--5198
		{"model","models/items/drow/quiver_of_the_boreal_watch/quiver_of_the_boreal_watch.vmdl"},--5199
		{"model","models/items/drow/cloak_of_the_boreal_watch/cloak_of_the_boreal_watch.vmdl"},--5120

		--D6 10
		{"model","models/items/drow/drow_sentinel_bow/drow_sentinel_bow.vmdl"},--5883
		{"model","models/items/drow/drow_sentinel_helm/drow_sentinel_helm.vmdl"},--5974
		{"model","models/items/drow/drow_sentintel_legs/drow_sentintel_legs.vmdl"},--5975
		{"model","models/items/drow/drow_sentinel_quiver/drow_sentinel_quiver.vmdl"},--5979
		{"model","models/items/drow/drow_sentinel_shoulders/drow_sentinel_shoulders.vmdl"},--5985
		{"model","models/items/drow/drow_sentinel_gloves/drow_sentinel_gloves.vmdl"},--5986
		{"model","models/items/drow/drow_sentinel_cloak/drow_sentinel_cloak.vmdl"},--5989

		--D6 20
		{"model","models/items/drow/black_wind_head/black_wind_head.vmdl"},--6552
		{"model","models/items/drow/black_wind_arms/black_wind_arms.vmdl"},--6553
		{"model","models/items/drow/black_wind_shoulders/black_wind_shoulders.vmdl"},--6554
		{"model","models/items/drow/black_wind_legs/black_wind_legs.vmdl"},--6555
		{"model","models/items/drow/black_wind_weapon/black_wind_weapon.vmdl"},--6556
		{"model","models/items/drow/black_wind_quiver/black_wind_quiver.vmdl"},--6557
		{"model","models/items/drow/black_wind_back/black_wind_back.vmdl"},--6558

		--F1 00
		{"model","models/items/keeper_of_the_light/northlight_stag_mount/northlight_stag_mount.vmdl"},--5773
		{"model","models/items/keeper_of_the_light/northlight_staff/northlight_staff.vmdl"},--5772
		{"model","models/items/keeper_of_the_light/northlight_head/northlight_head.vmdl"},--5771
		{"model","models/items/keeper_of_the_light/northlight_belt/northlight_belt.vmdl"},--5770
		{"model","models/items/keeper_of_the_light/northlight_armor/northlight_armor.vmdl"},--5769

		--F1 10
		{"model","models/items/keeper_of_the_light/horse_roehringods/horse_roehringods.vmdl"},--4867
		{"model","models/items/keeper_of_the_light/weapon_staffgods/weapon_staffgods.vmdl"},--4865
		{"model","models/items/keeper_of_the_light/head_hoodgodsv3/head_hoodgodsv3.vmdl"},--4868
		{"model","models/items/keeper_of_the_light/belt_skirtgodsv2/belt_skirtgodsv2.vmdl"},--4866
		{"model","models/items/keeper_of_the_light/armor_armorgodsv3/armor_armorgodsv3.vmdl"},--4864

		--F1 20
		{"model","models/items/keeper_of_the_light/cradle_of_lights_mount/cradle_of_lights_mount.vmdl"},--7676
		{"model","models/items/keeper_of_the_light/cradle_of_lights_weapon/cradle_of_lights_weapon.vmdl"},--7677
		{"model","models/items/keeper_of_the_light/cradle_of_lights_head/cradle_of_lights_head.vmdl"},--7679
		{"model","models/items/keeper_of_the_light/cradle_of_lights_belt/cradle_of_lights_belt.vmdl"},--7678
		{"model","models/items/keeper_of_the_light/cradle_of_lights_armor/cradle_of_lights_armor.vmdl"},--7675

		--F2  00
		{"model","models/items/lich/imperialists_mana_chamber/imperialists_mana_chamber.vmdl"},--7065
		{"model","models/items/lich/imperialists_guardian_lions/imperialists_guardian_lions.vmdl"},--7064
		{"model","models/items/lich/imperialists_runed_bracers/imperialists_runed_bracers.vmdl"},--7066
		{"model","models/items/lich/imperialists_cape_of_the_twin_dragons/imperialists_cape_of_the_twin_dragons.vmdl"},--6949
		{"model","models/items/lich/imperialists_frost_biter/imperialists_frost_biter.vmdl"},--7063

		--F2  10
		{"model","models/items/lich/the_deadwinter_sash/the_deadwinter_sash.vmdl"},--4853
		{"model","models/items/lich/the_deadwinter_head/the_deadwinter_head.vmdl"},--4851
		{"model","models/items/lich/the_deadwinter_arms/the_deadwinter_arms.vmdl"},--4854
		{"model","models/items/lich/the_deadwinter_back/the_deadwinter_back.vmdl"},--4852

		--F3 00
		{"model","models/items/witchdoctor/tale_tellers_hairhat.vmdl"},--4254
		{"model","models/items/witchdoctor/tale_tellers_poncho.vmdl"},--4253
		{"model","models/items/witchdoctor/tale_tellers_dress.vmdl"},--4251
		{"model","models/items/witchdoctor/witchstaff_weapon/witchstaff_weapon.vmdl"}, --6577
		{"model","models/items/witchdoctor/tale_tellers_drum.vmdl"},--4252

		--F3 10
		{"model","models/items/witchdoctor/purplenightmare_head/purplenightmare_head.vmdl"},--6954
		{"model","models/items/witchdoctor/purplenightmare_shoulder/purplenightmare_shoulder.vmdl"},--6951
		{"model","models/items/witchdoctor/purplenightmare_belt/purplenightmare_belt.vmdl"},--6955
		{"model","models/items/witchdoctor/purplenightmare_weapon/purplenightmare_weapon.vmdl"},--6956
		{"model","models/items/witchdoctor/purplenightmare_back/purplenightmare_back.vmdl"},--6953

		--F3 11
		{"model","models/items/witchdoctor/voodoo_skullmask.vmdl"},--4222
		{"model","models/heroes/witchdoctor/witchdoctor_bag.vmdl"},--95
		{"model","models/items/witchdoctor/voodoo_belt.vmdl"},--4096
		{"model","models/items/witchdoctor/voodo_staff.vmdl"},--4221
		{"model","models/items/witchdoctor/voodoo_backpack.vmdl"},--4220

		--F4 00
		{"model","models/items/necrolyte/heretic_weapon/heretic_weapon.vmdl"}, --6379
		{"model","models/items/necrolyte/heretic_head/heretic_head.vmdl"},--6377
		{"model","models/items/necrolyte/heretic_hood/heretic_hood.vmdl"},--6378
		{"model","models/items/necrolyte/heretic_shoulder/heretic_shoulder.vmdl"},--6380

		--F4 10
		{"model","models/items/necrolyte/necronub_scythe/necronub_scythe.vmdl"},--7132
		{"model","models/items/necrolyte/necronub_head/necronub_head.vmdl"},--6291
		{"model","models/items/necrolyte/necronub_top/necronub_top.vmdl"},--7083
		{"model","models/items/necrolyte/necronub_wings/necronub_wings.vmdl"},--7124

		--F4 11
		{"model","models/items/necrolyte/immemorial_emperor_weapon/immemorial_emperor_weapon.vmdl"},--6054
		{"model","models/items/necrolyte/immemorial_emperor_beard/immemorial_emperor_beard.vmdl"},--6051
		{"model","models/items/necrolyte/immemorial_emperor_head/immemorial_emperor_head.vmdl"},--6052
		{"model","models/items/necrolyte/immemorial_emperor_shoulder/immemorial_emperor_shoulder.vmdl"},--6053

		--F5 00
		{"model","models/items/vengefulspirit/banished_princess_head/banished_princess_head.vmdl"},--6516
		{"model","models/items/vengefulspirit/banished_princess_weapon/banished_princess_weapon.vmdl"},--6518
		{"model","models/items/vengefulspirit/banished_princess_cape/banished_princess_cape.vmdl"},--6515
		{"model","models/items/vengefulspirit/banished_princess_legs/banished_princess_legs.vmdl"},--6517

		-- --F5 10
		-- {"model","models/items/vengefulspirit/fallenprincess_head/fallenprincess_head.vmdl"},--6256
		-- {"model","models/items/vengefulspirit/fallenprincess_weapon/fallenprincess_weapon.vmdl"},--6258
		-- {"model","models/items/vengefulspirit/fallenprincess_shoulders/fallenprincess_shoulders.vmdl"},--6257
		-- {"model","models/items/vengefulspirit/fallenprincess_legs/fallenprincess_legs.vmdl"},--6259
		--F5 10
		{"model","models/items/vengefulspirit/huangs_umbra_head/huangs_umbra_head.vmdl"}, --7797
		{"model","models/items/vengefulspirit/huangs_umbra_weapon/huangs_umbra_weapon.vmdl"},--7798
		{"model","models/items/vengefulspirit/huangs_umbra_shoulders/huangs_umbra_shoulders.vmdl"}, --7799
		{"model","models/items/vengefulspirit/huangs_umbra_skirt/huangs_umbra_skirt.vmdl"},--7796
		--R1 00
		{"model","models/items/puck/mischievous_back/mischievous_back.vmdl"}, --6166
		{"model","models/items/puck/mischievous_tail/mischievous_tail.vmdl"},--6165
		{"model","models/items/puck/mischievous_head/mischievous_head.vmdl"},--6167

		--R1 10
		{"model","models/items/puck/reminiscence_wings/reminiscence_wings.vmdl"}, --6711
		{"model","models/items/puck/reminiscence_tail/reminiscence_tail.vmdl"},--6710
		{"model","models/items/puck/reminiscence_head/reminiscence_head.vmdl"}, --6709

		--R1 11
		{"model","models/items/puck/mysticcoils_wings/mysticcoils_wings.vmdl"}, --6177
		{"model","models/items/puck/mysticcoils_tail/mysticcoils_tail.vmdl"},--6176
		{"model","models/items/puck/mysticcoils_antennae/mysticcoils_antennae.vmdl"},--6178

		--R3 00
		{"model","models/heroes/winterwyvern/winterwyvern_backitem.vmdl"}, --552
		{"model","models/heroes/winterwyvern/winterwyvern_crown.vmdl"},--551

		--R5 00
		{"model","models/items/obsidian_destroyer/head_arcanef/head_arcanef.vmdl"}, --4641
		{"model","models/items/obsidian_destroyer/armor_bacon/armor_bacon.vmdl"},--4586
		{"model","models/items/obsidian_destroyer/weapon_arcane_obliva/weapon_arcane_obliva.vmdl"},--4642
		{"model","models/items/obsidian_destroyer/back_baconator_d/back_baconator_d.vmdl"},--4587
		{"model","models/heroes/obsidian_destroyer/obsidian_destroyer_head.vmdl"},--226

		--R5 10
		{"model","models/items/obsidian_destroyer/dragon_forged_staff/dragon_forged_staff.vmdl"}, --5210
		{"model","models/items/obsidian_destroyer/dragon_forged_wings/dragon_forged_wings.vmdl"},--5211
		{"model","models/heroes/obsidian_destroyer/obsidian_destroyer_head.vmdl"},--226
		{"model","models/items/obsidian_destroyer/dragon_forged_stare/dragon_forged_stare.vmdl"},--5209
		{"model","models/items/obsidian_destroyer/dragon_forged_armor/dragon_forged_armor.vmdl"},--5208


		--hire 12
		{"model","models/items/doom/eleven_curses__belt/eleven_curses__belt.vmdl"}, --4634
		{"model","models/items/doom/eleven_curses__bracer/eleven_curses__bracer.vmdl"}, --4627
		{"model","models/items/doom/eleven_curses__head/eleven_curses__head.vmdl"},  --4624
		{"model","models/items/doom/eleven_curses__shoulder/eleven_curses__shoulder.vmdl"},  --4639
		{"model","models/items/doom/eleven_curses__tail/eleven_curses__tail.vmdl"},  --4620
		{"model","models/items/doom/eleven_curses__wings/eleven_curses__wings.vmdl"},  --4631
		{"model","models/items/doom/eleven_curses__sword/eleven_curses__sword.vmdl"},  --4623

		--D7 00
		{"model","models/heroes/tuskarr/tusk_weapon.vmdl"},--417
		{"model","models/heroes/tuskarr/tusk_hat.vmdl"},--415
		{"model","models/heroes/tuskarr/tusk_fish_basket.vmdl"},--418
		{"model","models/heroes/tuskarr/tusk_horns.vmdl"},--416
		{"model","models/heroes/tuskarr/tusk_cowl.vmdl"},--414
		{"model","models/heroes/tuskarr/tusk_armor_glove.vmdl"},--413


		--D7 10
		{"model","models/items/tuskarr/onizaphk_ahunter_armsv2/onizaphk_ahunter_armsv2.vmdl"}, --4499
		{"model","models/items/tuskarr/onizaphk_ahunter_back/onizaphk_ahunter_back.vmdl"},--4498
		{"model","models/items/tuskarr/onizaphk_ahunter_head/onizaphk_ahunter_head.vmdl"},--4460
		{"model","models/items/tuskarr/onizaphk_ahunter_neck/onizaphk_ahunter_neck.vmdl"},--4441
		{"model","models/items/tuskarr/onizaphk_ahunter_shoulder/onizaphk_ahunter_shoulder.vmdl"},--4123
		{"model","models/items/tuskarr/onizaphk_ahunter_weapon/onizaphk_ahunter_weapon.vmdl"},--4097

		--D7 11
		{"model","models/items/tuskarr/glaciomarine_arm/glaciomarine_arm.vmdl"},--9010
		{"model","models/items/tuskarr/glaciomarine_back/glaciomarine_back.vmdl"},--9011
		{"model","models/items/tuskarr/glaciomarine_head/glaciomarine_head.vmdl"},--9007
		{"model","models/items/tuskarr/glaciomarine_neck/glaciomarine_neck.vmdl"},--9008
		{"model","models/items/tuskarr/glaciomarine_shoulder/glaciomarine_shoulder.vmdl"},--9012
		{"model","models/items/tuskarr/glaciomarine_weapon/glaciomarine_weapon.vmdl"},--9009

		--Q6 00
		{"model","models/heroes/luna/luna_head.vmdl"},--453
		{"model","models/heroes/luna/luna_mount.vmdl"},--452
		{"model","models/heroes/luna/luna_shoulder.vmdl"},--451
		{"model","models/heroes/luna/luna_shield.vmdl"},--449
		{"model","models/heroes/luna/luna_helmet.vmdl"},--450
		{"model","models/heroes/luna/luna_weapon.vmdl"},--448

		--Q6 10
		{"model","models/items/luna/selemenes_eclipse_helm/selemenes_eclipse_helm.vmdl"},--7701
		{"model","models/items/luna/selemenes_eclipse_mount/selemenes_eclipse_mount.vmdl"},--7703
		{"model","models/items/luna/selemenes_eclipse_shield/selemenes_eclipse_shield.vmdl"},--7700
		{"model","models/items/luna/selemenes_eclipse_shoulders/selemenes_eclipse_shoulders.vmdl"},--7702
		{"model","models/items/luna/selemenes_eclipse_weapon/selemenes_eclipse_weapon.vmdl"},--7699

		--Q6 20
		{"model","models/items/luna/lucent_epaulets/lucent_epaulets.vmdl"},--5944
		{"model","models/items/luna/lucent_glaive/lucent_glaive.vmdl"},--5945
		{"model","models/items/luna/lucent_guard/lucent_guard.vmdl"},--5946
		{"model","models/items/luna/lucent_head/lucent_head.vmdl"},--5948
		{"model","models/items/luna/lucent_mount/lucent_mount.vmdl"},--5947

		--Q6 21
		{"model","models/items/mirana/crescent_bow/crescent_bow.vmdl"},--6658
		{"model","models/items/mirana/crescent_back/crescent_back.vmdl"},--6657
		{"model","models/items/mirana/crescent_bracers/crescent_bracers.vmdl"},--6659
		{"model","models/items/mirana/crescent_hair/crescent_hair.vmdl"},--6660
		{"model","models/items/mirana/crescent_mount/crescent_mount.vmdl"},--6661
		{"model","models/items/mirana/crescent_quiver/crescent_quiver.vmdl"},--6662
		{"model","models/items/mirana/crescent_shoulder/crescent_shoulder.vmdl"},--6663

		--General 1
		{"model","models/items/legion_commander/battlefield_weapon/battlefield_weapon.vmdl"},--6827
		{"model","models/items/legion_commander/battlefield_head/battlefield_head.vmdl"},--6861
		{"model","models/items/legion_commander/battlefield_back/battlefield_back.vmdl"},--6829
		{"model","models/items/legion_commander/battlefield_shoulder/battlefield_shoulder.vmdl"},--6828
		{"model","models/items/legion_commander/battlefield_arms/battlefield_arms.vmdl"},--6834

		--General 2
		{"model","models/items/legion_commander/immortalspride_weapon/immortalspride_weapon.vmdl"},--6995
		{"model","models/items/legion_commander/immortalspride_head/immortalspride_head.vmdl"},--6994
		{"model","models/items/legion_commander/immortalspride_back/immortalspride_back.vmdl"},--6909
		{"model","models/items/legion_commander/immortalspride_shoulder/immortalspride_shoulder.vmdl"},--7008
		{"model","models/items/legion_commander/immortalspride_arms/immortalspride_arms.vmdl"},--6910

		--General 3
		{"model","models/items/legion_commander/spear_of_the_dragon_guard/spear_of_the_dragon_guard.vmdl"},--6035
		{"model","models/items/legion_commander/plume_of_the_dragon_guard/plume_of_the_dragon_guard.vmdl"},--6031
		{"model","models/items/legion_commander/twin_dragon_banner/twin_dragon_banner.vmdl"},--6034
		{"model","models/items/legion_commander/scales_of_the_dragon_guard/scales_of_the_dragon_guard.vmdl"},--6032
		{"model","models/items/legion_commander/armlet_of_the_dragon_guard/armlet_of_the_dragon_guard.vmdl"},--6033

		--General 4
		{"model","models/items/legion_commander/valkyrie_weapon/valkyrie_weapon.vmdl"},--6244
		{"model","models/items/legion_commander/valkyrie_head/valkyrie_head.vmdl"},--6243
		{"model","models/items/legion_commander/valkyrie_back/valkyrie_back.vmdl"},--6242
		{"model","models/items/legion_commander/valkyrie_shoulder/valkyrie_shoulder.vmdl"},--6240
		{"model","models/items/legion_commander/valkyrie_arms/valkyrie_arms.vmdl"},--6241

		--General 5
		{"model","models/items/legion_commander/errant_spear/errant_spear.vmdl"},--7224
		{"model","models/items/legion_commander/errant_cowl/errant_cowl.vmdl"},--7222
		{"model","models/items/legion_commander/errant_standards/errant_standards.vmdl"},--7221
		{"model","models/items/legion_commander/errant_pauldrons/errant_pauldrons.vmdl"},--7223
		{"model","models/items/legion_commander/errant_bracers/errant_bracers.vmdl"},--7220

		--General 6
		{"model","models/items/legion_commander/stonehall_weapon/stonehall_weapon.vmdl"},--5890
		{"model","models/items/legion_commander/stonehall_head/stonehall_head.vmdl"},--5887
		{"model","models/items/legion_commander/stonehall_back/stonehall_back.vmdl"},--5886
		{"model","models/items/legion_commander/stonehall_shoulder/stonehall_shoulder.vmdl"},--5889
		{"model","models/items/legion_commander/stonehall_arms/stonehall_arms.vmdl"},--5885

		--F6 00
		{"model","models/items/crystal_maiden/warden_icewrack_arms/warden_icewrack_arms.vmdl"},--9324
		{"model","models/items/crystal_maiden/warden_icewrack_back/warden_icewrack_back.vmdl"},--9325
		{"model","models/items/crystal_maiden/warden_icewrack_head/warden_icewrack_head.vmdl"},--9327
		{"model","models/items/crystal_maiden/warden_icewrack_shoulder/warden_icewrack_shoulder.vmdl"},--9326
		{"model","models/items/crystal_maiden/warden_icewrack_staff/warden_icewrack_staff.vmdl"},--9328
		--F6 10
		{"model","models/items/crystal_maiden/crystalline_comet_weapon/crystalline_comet_weapon.vmdl"},--6769
		{"model","models/items/crystal_maiden/belle_arms_bracers/belle_arms_bracers.vmdl"},--4420
		{"model","models/items/crystal_maiden/belle_head_hair/belle_head_hair.vmdl"},--4540
		{"model","models/items/crystal_maiden/belle_shoulders/belle_shoulders.vmdl"},--4389
		{"model","models/items/crystal_maiden/polarisbelle_cape/polarisbelle_cape.vmdl"},--4386
		--F6 11
		{"model","models/heroes/crystal_maiden/crystal_maiden_arcana_back.vmdl"},--7385
		{"model","models/items/crystal_maiden/frostbringer_hair/frostbringer_hair.vmdl"},--8456
		{"model","models/items/crystal_maiden/frostbringer_shoulders/frostbringer_shoulders.vmdl"},--8450
		{"model","models/items/crystal_maiden/frostbringer_sleeves/frostbringer_sleeves.vmdl"},--8448
		{"model","models/items/crystal_maiden/frostbringer_staff/frostbringer_staff.vmdl"},--8449
		--E7 00
		{"model","models/items/slardar/royal_guard_armplates/royal_guard_armplates.vmdl"},--5071
		{"model","models/items/slardar/royal_guard_skullguard/royal_guard_skullguard.vmdl"},--5073
		{"model","models/items/slardar/royal_guard_spine/royal_guard_spine.vmdl"},--5072
		{"model","models/items/slardar/royal_guard_trident/royal_guard_trident.vmdl"},--5074
		--E7 10
		{"model","models/items/slardar/sea_devil_back/sea_devil_back.vmdl"},--8133
		{"model","models/items/slardar/sea_devil_bracers/sea_devil_bracers.vmdl"},--7857
		{"model","models/items/slardar/sea_devil_head/sea_devil_head.vmdl"},--7858
		{"model","models/items/slardar/sea_devil_weapon/sea_devil_weapon.vmdl"},--7859
		--E7 11
		{"model","models/items/slardar/sea_dragon_arm/sea_dragon_arm.vmdl"},--4923
		{"model","models/items/slardar/sea_dragon_back/sea_dragon_back.vmdl"},--4924
		{"model","models/items/slardar/sea_dragon_helmet/sea_dragon_helmet.vmdl"},--4922
		{"model","models/items/slardar/sea_dragon_weapon/sea_dragon_weapon.vmdl"},--4921

		--G5 00
		{"model","models/items/centaur/warstomp_weapon/warstomp_weapon.vmdl"},--6311
		{"model","models/items/centaur/warstomp_head/warstomp_head.vmdl"},--6210
		{"model","models/items/centaur/warstomp_armor/warstomp_armor.vmdl"},--6312
		{"model","models/items/centaur/warstomp_belt/warstomp_belt.vmdl"},--6211
		{"model","models/items/centaur/warstomp_arms/warstomp_arms.vmdl"},--6207
		{"model","models/items/centaur/warstomp_back/warstomp_back.vmdl"},--6209
		{"model","models/items/centaur/warstomp_tail/warstomp_tail.vmdl"},--6208

		--G5 10
		{"model","models/items/centaur/dc_weaponbsk/dc_weaponbsk.vmdl"},--6500
		{"model","models/items/centaur/dc_headitembsrk/dc_headitembsrk.vmdl"},--6497
		{"model","models/items/centaur/dc_shoulderbsrk/dc_shoulderbsrk.vmdl"},--6494
		{"model","models/items/centaur/dc_beltbsrk/dc_beltbsrk.vmdl"},--6495
		{"model","models/items/centaur/dc_armsbsrk/dc_armsbsrk.vmdl"},--6496
		{"model","models/items/centaur/dc_shieldbsrk/dc_shieldbsrk.vmdl"},--6889
		{"model","models/items/centaur/dc_tailbsrk/dc_tailbsrk.vmdl"},--6498

		--G5 11
		{"model","models/items/centaur/warlordofhell_weapon/warlordofhell_weapon.vmdl"},--6962
		{"model","models/items/centaur/warlordofhell_head/warlordofhell_head.vmdl"},--6958
		{"model","models/items/centaur/warlordofhell_shoulder/warlordofhell_shoulder.vmdl"},--6961
		{"model","models/items/centaur/warlordofhell_belt/warlordofhell_belt.vmdl"},--6960
		{"model","models/items/centaur/warlordofhell_arms/warlordofhell_arms.vmdl"},--6959
		{"model","models/items/centaur/warlordofhell_back/warlordofhell_back.vmdl"},--6964
		{"model","models/items/centaur/warlordofhell_tail/warlordofhell_tail.vmdl"},--6963

		--Q7 00
		{"model","models/heroes/meepo/meepo_weapon.vmdl"},--104
		{"model","models/heroes/meepo/hood.vmdl"},--296
		{"model","models/heroes/meepo/shoulders.vmdl"},--298
		{"model","models/heroes/meepo/pack.vmdl"},--297
		{"model","models/heroes/meepo/bracers.vmdl"},--299
		{"model","models/heroes/meepo/tail.vmdl"},--300

		--Q7 10
		{"model","models/items/meepo/riftshadow_roamer_pan/riftshadow_roamer_pan.vmdl"},--4423
		{"model","models/items/meepo/riftshadow_roamer_hat/riftshadow_roamer_hat.vmdl"},--4427
		{"model","models/items/meepo/riftshadow_roamer_vest/riftshadow_roamer_vest.vmdl"},--4421
		{"model","models/items/meepo/riftshadow_roamer_pack/riftshadow_roamer_pack.vmdl"},--4344
		{"model","models/items/meepo/riftshadow_roamer_gloves/riftshadow_roamer_gloves.vmdl"},--4434
		--300

		--Q7 20
		{"model","models/items/meepo/dosa_weapon/dosa_weapon.vmdl"},--6230
		{"model","models/items/meepo/dosa_hat/dosa_hat.vmdl"},--6238
		{"model","models/items/meepo/dosa_shoulder/dosa_shoulder.vmdl"},--6228
		{"model","models/items/meepo/dosa_back/dosa_back.vmdl"},--6237
		{"model","models/items/dark_seer/gombangdae_arms/gombangdae_arms.vmdl"},--6231
		{"model","models/items/meepo/dosa_tail/dosa_tail.vmdl"},--6229

		--Q7 21
		{"model","models/items/meepo/meepo_skeletonkey_sword/meepo_skeletonkey_sword.vmdl"},--4912
		{"model","models/items/meepo/meepo_skeletonkey_bandana/meepo_skeletonkey_bandana.vmdl"},--4911
		{"model","models/items/meepo/meeposksh/meeposksh.vmdl"},--4914
		{"model","models/items/meepo/meeposkback/meeposkback.vmdl"},--4913
		--299
		--300
		--W6 00
		{"model","models/items/phantom_assassin/carreau_weapon/carreau_weapon.vmdl"},--7113
		{"model","models/items/phantom_assassin/carreau_head/carreau_head.vmdl"},--7117
		{"model","models/items/phantom_assassin/carreau_shoulder/carreau_shoulder.vmdl"},--7116
		{"model","models/items/phantom_assassin/carreau_back/carreau_back.vmdl"},--7114
		{"model","models/items/phantom_assassin/carreau_belt/carreau_belt.vmdl"},--7115

		--W6 10
		{"model","models/items/phantom_assassin/dark_wraith_weapon/dark_wraith_weapon.vmdl"},--5354
		{"model","models/items/phantom_assassin/dark_wraith_helmet/dark_wraith_helmet.vmdl"},--5352
		{"model","models/items/phantom_assassin/dark_wraith_shoulder/dark_wraith_shoulder.vmdl"},--5353
		{"model","models/items/phantom_assassin/dark_wraith_back/dark_wraith_back.vmdl"},--5350
		{"model","models/items/phantom_assassin/dark_wraith_belt/dark_wraith_belt.vmdl"},--5351

		--W6 20
		{"model","models/items/phantom_assassin/kiss_of_crows_weapon/kiss_of_crows_weapon.vmdl"},--8138
		{"model","models/items/phantom_assassin/kiss_of_crows_head/kiss_of_crows_head.vmdl"},--8139
		{"model","models/items/phantom_assassin/kiss_of_crows_shoulders/kiss_of_crows_shoulders.vmdl"},--8140
		{"model","models/items/phantom_assassin/kiss_of_crows_back/kiss_of_crows_back.vmdl"},--8137
		{"model","models/items/phantom_assassin/kiss_of_crows_belt/kiss_of_crows_belt.vmdl"},--8136

		--W6 21
		{"model","models/items/phantom_assassin/raiment_of_the_sacred_blossom_head/raiment_of_the_sacred_blossom_head.vmdl"},--8015
		{"model","models/items/phantom_assassin/raiment_of_the_sacred_blossom_shoulder/raiment_of_the_sacred_blossom_shoulder.vmdl"},--8012
		{"model","models/items/phantom_assassin/raiment_of_the_sacred_blossom_back/raiment_of_the_sacred_blossom_back.vmdl"},--8014
		{"model","models/items/phantom_assassin/raiment_of_the_sacred_blossom_belt/raiment_of_the_sacred_blossom_belt.vmdl"},--8013
		{"model","models/heroes/phantom_assassin/pa_arcana_weapons.vmdl"},--7247

		--W7 00
		{"model","models/heroes/enchantress/enchantress_weapon.vmdl"},--290
		{"model","models/heroes/enchantress/enchantress_dress.vmdl"},--288
		{"model","models/heroes/enchantress/enchantress_bracers.vmdl"},--289
		{"model","models/heroes/enchantress/enchantress_hair.vmdl"},--287
		{"model","models/heroes/enchantress/enchantress_weapon.vmdl"},--290

		--W7 10
		{"model","models/items/enchantress/anuxi_wldkin_weapon2/anuxi_wldkin_weapon2.vmdl"},--4785
		{"model","models/items/enchantress/anuxi_wldkin_hair2/anuxi_wldkin_hair2.vmdl"},--4786
		{"model","models/items/enchantress/anuxi_wldkin_dress2/anuxi_wldkin_dress2.vmdl"},--4787
		{"model","models/items/enchantress/anuxi_wildkin_neck/anuxi_wildkin_neck.vmdl"},--4678
		{"model","models/items/enchantress/anuxi_wildkin_arm/anuxi_wildkin_arm.vmdl"},--4676

		--W7 20
		{"model","models/items/enchantress/anuxi_summer_spear/anuxi_summer_spear.vmdl"},--5021
		{"model","models/items/enchantress/anuxi_summer_head/anuxi_summer_head.vmdl"},--5024
		{"model","models/items/enchantress/anuxi_summer_skirt/anuxi_summer_skirt.vmdl"},--5022
		{"model","models/items/enchantress/anuxi_summer_shoulder/anuxi_summer_shoulder.vmdl"},--5023
		{"model","models/items/enchantress/anuxi_summer_arms/anuxi_summer_arms.vmdl"},--5025

		--E3 00
		{"model","models/items/ursa/wraps_of_the_radiant_protector/wraps_of_the_radiant_protector.vmdl"},--5893
		{"model","models/items/ursa/belt_of_radiant_protector/belt_of_radiant_protector.vmdl"},--5888
		{"model","models/items/ursa/mark_of_the_radiant_protector/mark_of_the_radiant_protector.vmdl"},--5894
		{"model","models/items/ursa/braids_of_the_radiant_protector/braids_of_the_radiant_protector.vmdl"},--5893

		--E3 10
		{"model","models/items/ursa/ursa_cryo_arms/ursa_cryo_arms.vmdl"},--5805
		{"model","models/items/ursa/ursa_cryo_belt/ursa_cryo_belt.vmdl"},--5808
		{"model","models/items/ursa/ursa_cryo_back/ursa_cryo_back.vmdl"},--5807
		{"model","models/items/ursa/ursa_cryo_head/ursa_cryo_head.vmdl"},--5550

		--E3 11
		{"model","models/items/ursa/fierce_heart_weapon/fierce_heart_weapon.vmdl"},--7654
		{"model","models/items/ursa/fierce_heart_arms/fierce_heart_arms.vmdl"},--7651
		{"model","models/items/ursa/fierce_heart_belt/fierce_heart_belt.vmdl"},--7650
		{"model","models/items/ursa/fierce_heart_back/fierce_heart_back.vmdl"},--7652
		{"model","models/items/ursa/fierce_heart_head/fierce_heart_head.vmdl"},--7653

		--E6 00
		{"model","models/items/brewmaster/wep_brewmaster_cleaver_01/wep_brewmaster_cleaver_01.vmdl"},--4894
		{"model","models/items/brewmaster/gear_brewmaster_sake_01/gear_brewmaster_sake_01.vmdl"},--4890
		{"model","models/items/brewmaster/gear_brewmaster_gloves_01/gear_brewmaster_gloves_01.vmdl"},--4891
		{"model","models/items/brewmaster/gear_brewmaster_back_01/gear_brewmaster_back_01.vmdl"},--4893
		{"model","models/items/brewmaster/gear_brewmaster_shoulder_01/gear_brewmaster_shoulder_01.vmdl"},--4892

		--E6 10
		{"model","models/items/brewmaster/reddragon_weapon/reddragon_weapon.vmdl"},--6969
		{"model","models/items/brewmaster/reddragon_offhand/reddragon_offhand.vmdl"},--6968
		{"model","models/items/brewmaster/reddragon_arms/reddragon_arms.vmdl"},--6967
		{"model","models/items/brewmaster/reddragon_back/reddragon_back.vmdl"},--6966
		{"model","models/items/brewmaster/reddragon_shoulder/reddragon_shoulder.vmdl"},--5641

		--D8 00
		{"model","models/items/windrunner/wingsweapon2/wingsweapon2.vmdl"},--4552
		{"model","models/items/windrunner/falconhelm1/falconhelm1.vmdl"},--4559
		{"model","models/items/windrunner/falconcloak/falconcloak.vmdl"},--4554
		{"model","models/items/windrunner/wingsshoulders2/wingsshoulders2.vmdl"},--4562
		{"model","models/items/windrunner/featherquiver21/featherquiver21.vmdl"},--4553

		--D8 10
		{"model","models/items/windrunner/tranquility_weapon/tranquility_weapon.vmdl"},--6835
		{"model","models/items/windrunner/tranquility_head/tranquility_head.vmdl"},--6831
		{"model","models/items/windrunner/tranquility_back/tranquility_back.vmdl"},--6836
		{"model","models/items/windrunner/tranquility_shoulder/tranquility_shoulder.vmdl"},--6838
		{"model","models/items/windrunner/tranquility_quiver/tranquility_quiver.vmdl"},--6837

		--R6 00
		{"model","models/heroes/gyro/gyro_head.vmdl"},--131
		{"model","models/heroes/gyro/gyro_guns.vmdl"},--177
		{"model","models/heroes/gyro/gyro_goggles.vmdl"},--176
		{"model","models/heroes/gyro/gyro_bottles.vmdl"},--126
		{"model","models/heroes/gyro/gyro_propeller.vmdl"},--178
		{"model","models/heroes/gyro/gyro_missile.vmdl"},--179

		--R6 10
		{"model","models/items/gyrocopter/rainmaker_weapon/rainmaker_weapon.vmdl"},--6899
		{"model","models/items/gyrocopter/rainmaker_head/rainmaker_head.vmdl"},--7121
		{"model","models/items/gyrocopter/rainmaker_back/rainmaker_back.vmdl"},--6903
		{"model","models/items/gyrocopter/rainmaker_misc/rainmaker_misc.vmdl"},--6898
		{"model","models/items/gyrocopter/rainmaker_offhand/rainmaker_offhand.vmdl"},--6897


		--R6 11
		{"model","models/items/gyrocopter/skyhigh_head/skyhigh_head.vmdl"},--7825
		{"model","models/items/gyrocopter/skyhigh_back/skyhigh_back.vmdl"},--7823
		{"model","models/items/gyrocopter/skyhigh_propeller/skyhigh_propeller.vmdl"},--7828
		{"model","models/items/gyrocopter/skyhigh_bomb_missle/skyhigh_bomb.vmdl"},--7822
		--131
		{"model","models/items/gyrocopter/immortal_guns/immortal_guns_gold.vmdl"},--9428
		--Q8 00

		{"model","models/items/rattletrap/artisan_of_havoc_hook/artisan_of_havoc_hook.vmdl"},--6810
		{"model","models/items/rattletrap/ironclock_head/ironclock_head.vmdl"},--7018
		{"model","models/items/rattletrap/artisan_of_havoc_armor/artisan_of_havoc_armor.vmdl"},--6809
		{"model","models/items/rattletrap/artisan_of_havoc_rocket/artisan_of_havoc_rocket.vmdl"},--6811

		--Q8 10
		{"model","models/items/rattletrap/forge_warrior_claw/forge_warrior_claw.vmdl"},--6481
		{"model","models/items/rattletrap/forge_warrior_helm/forge_warrior_helm.vmdl"},--6482
		{"model","models/items/rattletrap/forge_warrior_steam_exoskeleton/forge_warrior_steam_exoskeleton.vmdl"},--6485
		{"model","models/items/rattletrap/forge_warrior_rocket_cannon/forge_warrior_rocket_cannon.vmdl"},--6484

		--Q8 20
		{"model","models/items/rattletrap/steelcrow_weapon/steelcrow_weapon.vmdl"},--9015
		{"model","models/items/rattletrap/steelcrow_head/steelcrow_head.vmdl"},--9014
		{"model","models/items/rattletrap/steelcrow_armor/steelcrow_armor.vmdl"},--9013
		{"model","models/items/rattletrap/steelcrow_misc/steelcrow_misc.vmdl"},--9016

		--F7 00
		{"model","models/heroes/alchemist/alchemist_scabbard.vmdl"},--118
		{"model","models/heroes/alchemist/alchemist_shoulderbottles.vmdl"},--125
		{"model","models/heroes/alchemist/alchemist_ogre_head.vmdl"},--124
		{"model","models/heroes/alchemist/alchemist_goblin_body.vmdl"},--117
		{"model","models/heroes/alchemist/alchemist_gauntlets.vmdl"},--120
		{"model","models/heroes/alchemist/alchemist_goblinhat.vmdl"},--121
		{"model","models/heroes/alchemist/alchemist_saddlehat.vmdl"},--119
		{"model","models/heroes/alchemist/alchemist_goblin_head.vmdl"},--123

		--F7 10
		{"model","models/items/alchemist/toxic_siege_blades/toxic_siege_blades.vmdl"},--6123
		{"model","models/items/alchemist/toxic_siege_pauldrons/toxic_siege_pauldrons.vmdl"},--6122
		--124
		{"model","models/items/alchemist/toxic_siege_garb/toxic_siege_garb.vmdl"},--6118
		{"model","models/items/alchemist/toxic_siege_bracers/toxic_siege_bracers.vmdl"},--6117
		{"model","models/items/alchemist/toxic_siege_safety_goggles/toxic_siege_safety_goggles.vmdl"},--6119
		{"model","models/items/alchemist/toxic_siege_armored_saddle/toxic_siege_armored_saddle.vmdl"},--6121
		{"model","models/items/alchemist/toxic_siege_corrosive_flasks/toxic_siege_corrosive_flasks.vmdl"},--6120
		--123

		--F8 00
		{"model","models/items/dazzle/staff_of_the_yuwipi/staff_of_the_yuwipi.vmdl"},--5882
		{"model","models/items/dazzle/band_of_summoning/band_of_summoning.vmdl"},--5879
		{"model","models/items/dazzle/headdress_of_the_yuwipi/headdress_of_the_yuwipi.vmdl"},--5880
		{"model","models/items/dazzle/bonedress_of_the_yuwipi/bonedress_of_the_yuwipi.vmdl"},--5881
		{"model","models/heroes/dazzle/dazzle_shoulder.vmdl"},--468
		--F8 10
		{"model","models/items/dazzle/dazzleset_weapon/dazzleset_weapon.vmdl"},--4685
		{"model","models/items/dazzle/dazzleset_arm/dazzleset_arm.vmdl"},--4683
		{"model","models/items/dazzle/dazzleset_back/dazzleset_back.vmdl"},--4682
		{"model","models/items/dazzle/dazzleset_legs/dazzleset_legs.vmdl"},--4684
		{"model","models/items/dazzle/dazzleset_misc/dazzleset_misc.vmdl"},--4681
		--banner badguys
		{"model","models/props_teams/banner_dire_small.vmdl"},
		--F9 00
		{"model","models/heroes/ogre_magi/ogre_magi_weapon.vmdl"},--105
		{"model","models/heroes/ogre_magi/ogre_magi_cape.vmdl"},--133
		{"model","models/heroes/ogre_magi/ogre_magi_hats.vmdl"},--135
		{"model","models/heroes/ogre_magi/ogre_magi_belt.vmdl"},--136
		{"model","models/heroes/ogre_magi/ogre_magi_bracers.vmdl"},--134

		--F9 10
		{"model","models/items/ogre_magi/antipodean_weapon/antipodean_weapon.vmdl"},--7848
		{"model","models/items/ogre_magi/antipodean_back/antipodean_back.vmdl"},--7845
		{"model","models/items/ogre_magi/antipodean_head/antipodean_head.vmdl"},--7847
		{"model","models/items/ogre_magi/antipodean_belt/antipodean_belt.vmdl"},--7846
		{"model","models/items/ogre_magi/antipodean_arms/antipodean_arms.vmdl"},--7839

		--F9 11
		{"model","models/items/ogre_magi/ogre_ancestral_weapon/ogre_ancestral_weapon.vmdl"},--5241
		{"model","models/items/ogre_magi/ogre_ancestral_back/ogre_ancestral_back.vmdl"},--5243
		{"model","models/items/ogre_magi/ogre_ancestral_head/ogre_ancestral_head.vmdl"},--5245
		{"model","models/items/ogre_magi/ogre_ancestral_belt/ogre_ancestral_belt.vmdl"},--5244
		{"model","models/items/ogre_magi/ogre_ancestral_arms/ogre_ancestral_arms.vmdl"},--5242

		--G7 00
		{"model","models/items/antimage/wh_weapon/wh_weapon.vmdl"}, --4781
		{"model","models/items/antimage/wh_offhand_weapon/wh_offhand_weapon.vmdl"},--4779
		{"model","models/items/antimage/wh_mask/wh_mask.vmdl"},--4769
		{"model","models/items/antimage/wh_armor/wh_armor.vmdl"},--4778
		{"model","models/items/antimage/wh_arms/wh_arms.vmdl"},--4784
		{"model","models/items/antimage/wh_belt/wh_belt.vmdl"},--4782
		{"model","models/items/antimage/wh_shoulder/wh_shoulder.vmdl"},--4770

		--G7 10
		{"model","models/items/antimage/reprieve_of_the_clergy_ascetic/reprieve_of_the_clergy_ascetic.vmdl"},--5531
		{"model","models/items/antimage/reprieve_of_the_clergy_ascetic__offhand/reprieve_of_the_clergy_ascetic__offhand.vmdl"},--5529
		{"model","models/items/antimage/hood_of_the_clergy_ascetic/hood_of_the_clergy_ascetic.vmdl"},--5538
		{"model","models/items/antimage/adornment_of_the_clergy_ascetic/adornment_of_the_clergy_ascetic.vmdl"},--5530
		{"model","models/items/antimage/bracers_of_the_clergy_ascetic/bracers_of_the_clergy_ascetic.vmdl"},--5549
		{"model","models/items/antimage/cloth_of_the_clergy_ascetic/cloth_of_the_clergy_ascetic.vmdl"},--5528
		{"model","models/items/antimage/guard_of_the_clergy_ascetic/guard_of_the_clergy_ascetic.vmdl"},--5532

		--G7 11
		{"model","models/items/antimage/tarrasque_scale_weapon/tarrasque_scale_weapon.vmdl"},--8611
		{"model","models/items/antimage/tarrasque_scale_offhand/tarrasque_scale_offhand.vmdl"},--8678
		{"model","models/items/antimage/tarrasque_scale_head/tarrasque_scale_head.vmdl"},--8596
		{"model","models/items/antimage/tarrasque_scale_armor/tarrasque_scale_armor.vmdl"},--8595
		{"model","models/items/antimage/tarrasque_scale_arms/tarrasque_scale_arms.vmdl"},--8610
		{"model","models/items/antimage/tarrasque_scale_belt/tarrasque_scale_belt.vmdl"},--8609
		{"model","models/items/antimage/tarrasque_scale_shoulder/tarrasque_scale_shoulder.vmdl"},--8620

		--G8 00
		{"model","models/heroes/phantom_lancer/phantom_lancer_head.vmdl"},--127
		{"model","models/items/phantom_lancer/weapon_kinship/weapon_kinship.vmdl"},--4439
		{"model","models/items/phantom_lancer/shoulder_kinship/shoulder_kinship.vmdl"},--4451
		{"model","models/items/phantom_lancer/arms_kinship/arms_kinship.vmdl"},--4402
		{"model","models/items/phantom_lancer/belt_kinship/belt_kinship.vmdl"},--4409

		--G8 10
		{"model","models/items/phantom_lancer/infinite_waves_serpent_weapon/infinite_waves_serpent_weapon.vmdl"},--6317
		{"model","models/items/phantom_lancer/infinite_waves_shoulder/infinite_waves_shoulder.vmdl"},--6755
		{"model","models/items/phantom_lancer/infinite_waves_arms/infinite_waves_arms.vmdl"},--6752
		{"model","models/items/phantom_lancer/infinite_waves_belt/infinite_waves_belt.vmdl"},--6753
		--127

		--G8 11
		{"model","models/items/phantom_lancer/sunwarrior_weapon/sunwarrior_weapon.vmdl"},--6620
		{"model","models/items/phantom_lancer/sunwarrior_head/sunwarrior_head.vmdl"},--6621
		{"model","models/items/phantom_lancer/sunwarrior_arms/sunwarrior_arms.vmdl"},--6619
		{"model","models/items/phantom_lancer/sunwarrior_belt/sunwarrior_belt.vmdl"},--6617


	}



	-- print("loading shiping")
	local t=#zr;
	for i=1,t do
		PrecacheResource( zr[i][1], zr[i][2], context)
	end

	-- print("done loading shiping")


end

function PrecacheEverythingFromTable( context, kvtable)
	for key, value in pairs(kvtable) do
		if type(value) == "table" then
			PrecacheEverythingFromTable( context, value )
		else
			if string.find(value, "vpcf") then
				PrecacheResource( "particle",  value, context)
				-- print("PRECACHE PARTICLE RESOURCE", value)
			end
			if string.find(value, "vmdl") then
				PrecacheResource( "model",  value, context)
				-- print("PRECACHE MODEL RESOURCE", value)
			end
			if string.find(value, "vsndevts") then
				PrecacheResource( "soundfile",  value, context)
				-- print("PRECACHE SOUND RESOURCE", value)
			end
		end
	end
end

--技能特效预载表
ParticleTable={
	"particles/generic_gameplay/generic_stunned.vpcf",
	"particles/farmer/farmer.vpcf",
	"particles/econ/courier/courier_golden_roshan/golden_roshan_ambient.vpcf",
	"particles/units/heroes/hero_sven/sven_gods_strength_hero_effect.vpcf",
	"particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf",
	"particles/units/heroes/hero_bloodseeker/bloodseeker_rupture_nuke.vpcf",
	"particles/base_attacks/ranged_badguy_explosion.vpcf",
	"particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_aftershock_egset.vpcf",
	"particles/status_fx/status_effect_gods_strength.vpcf",
	"particles/items_fx/battlefury_cleave.vpcf",
	"particles/status_fx/status_effect_life_stealer_rage.vpcf",
	"particles/units/heroes/hero_life_stealer/life_stealer_rage.vpcf",
	"particles/status_fx/status_effect_bloodrage.vpcf",
	"particles/units/heroes/hero_slark/slark_shadow_dance.vpcf",
	"particles/units/heroes/hero_slardar/slardar_crush.vpcf",
	"particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf",
	"particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf",
	"particles/units/heroes/hero_huskar/huskar_inner_vitality.vpcf",
	"particles/units/heroes/hero_clinkz/clinkz_searing_arrow.vpcf",
	"particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf",
	"particles/units/heroes/hero_shadowshaman/shadowshaman_shackle.vpcf",
	"particles/status_fx/status_effect_shaman_shackle.vpcf",
	"particles/units/heroes/hero_tiny/tiny_craggy_hit.vpcf",
	"particles/econ/items/faceless_void/faceless_void_weapon_bfury/faceless_void_weapon_bfury_cleave.vpcf",
	"particles/units/heroes/hero_undying/undying_decay.vpcf",
	"particles/msg_fx/msg_xp.vpcf",
	"particles/units/heroes/hero_skeletonking/skeleton_king_weapon_blur_critical.vpcf",
	"particles/units/heroes/hero_shredder/shredder_armor_lyr.vpcf",
	"particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf",
	"particles/items_fx/armlet.vpcf",
	"particles/items2_fx/rod_of_atos.vpcf",
	"particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace_hit.vpcf",
	"particles/units/heroes/hero_centaur/centaur_return.vpcf",
	"particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf",
	"particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf",
	"particles/units/heroes/hero_earth_spirit/espirit_stone_explosion_bolt.vpcf",
	"particles/status_fx/status_effect_earth_spirit_petrify.vpcf",
	"particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf",
	"particles/units/heroes/hero_warlock/warlock_upheaval_debuff.vpcf",
	"particles/units/heroes/hero_nevermore/nevermore_trail.vpcf",
	"particles/units/heroes/hero_medusa/medusa_base_attack.vpcf",
	"particles/generic_gameplay/generic_slowed_cold.vpcf",
	"particles/status_fx/status_effect_frost_lich.vpcf",
	"particles/units/heroes/hero_drow/drow_frost_arrow.vpcf",
	"particles/econ/items/drow/drow_bow_howling_wind/drow_weapon_frost_howling_wind.vpcf",
	"particles/status_fx/status_effect_frost.vpcf",
	"particles/units/heroes/hero_drow/drow_silence_wave.vpcf",
	"particles/units/heroes/hero_windrunner/windrunner_windrun.vpcf",
	"particles/items2_fx/orb_of_venom.vpcf",
	"particles/status_fx/status_effect_poison_venomancer.vpcf",
	"particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration.vpcf",
	"particles/base_attacks/ranged_siege_bad.vpcf",
	"particles/units/heroes/hero_templar_assassin/templar_assassin_meld_armor.vpcf",
	"particles/items2_fx/radiance_owner.vpcf",
	"particles/items2_fx/radiance.vpcf",
	"particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf",
	"particles/status_fx/status_effect_doom.vpcf",
	"particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn_debuff_creep.vpcf",
	"particles/units/heroes/hero_lich/lich_frost_nova.vpcf",
	"particles/units/heroes/hero_witchdoctor/witchdoctor_ward_skull.vpcf",
	"particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf",
	"particles/units/heroes/hero_slark/slark_essence_shift.vpcf",
	"particles/units/heroes/hero_lycan/lycan_summon_wolves_cast.vpcf",
	"particles/units/heroes/hero_undying/undying_zombie_spawn.vpcf",
	"particles/keeper_recall_spiral.vpcf",
	"particles/items2_fx/urn_of_shadows_heal.vpcf",
	"particles/items2_fx/urn_of_shadows_damage.vpcf",
	"particles/items_fx/aura_vlads.vpcf",
	"particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf",
	"particles/econ/items/leshrac/leshrac_tormented_staff/leshrac_split_tormented.vpcf",
	"particles/units/heroes/hero_medusa/medusa_mana_shield_spiral03.vpcf",
	"particles/items_fx/healing_flask.vpcf",
	"particles/units/heroes/hero_lone_druid/lone_druid_rabid_buff_speed_ring.vpcf",
	"particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf",
	"particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf",
	"particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_debuff.vpcf",
	"particles/units/heroes/hero_disruptor/disruptor_static_storm.vpcf",
	"particles/units/heroes/hero_leshrac/leshrac_lightning_slow.vpcf",
	"particles/units/heroes/hero_razor_reduced_flash/razor_rain_storm_reduced_flash.vpcf",
	"particles/units/heroes/hero_razor_reduced_flash/razor_unstable_current_reduced_flash.vpcf",
	"particles/items2_fx/butterfly_active.vpcf",
	"particles/items_fx/ghost.vpcf",
	"particles/items2_fx/mask_of_madness.vpcf",
	"particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_orig.vpcf",
	"particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf",
	"particles/units/heroes/hero_abaddon/abaddon_frost_slow.vpcf",
	"particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_physical.vpcf",
	"particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_impact_physical.vpcf",
	"particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf",
	"particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_impact_magical.vpcf",
	"particles/units/heroes/hero_invoker/invoker_deafening_blast_debuff_echo.vpcf",
	"particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf",
	"particles/units/heroes/hero_ursa/ursa_enrage_hero_effect.vpcf",
	"particles/generic_gameplay/generic_lifesteal.vpcf",
	"particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf",
	"particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf",
	"particles/econ/items/puck/puck_alliance_set/puck_dreamcoil_aproset.vpcf",
	"particles/econ/items/puck/puck_alliance_set/puck_dreamcoil_tether_aproset.vpcf",
	"particles/units/heroes/hero_puck/puck_dreamcoil.vpcf",
	"particles/units/heroes/hero_visage/visage_soul_assumption_bolt6.vpcf",
	"particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf",
	"particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf",
	"particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_sanity_eclipse_area.vpcf",
	"particles/units/heroes/hero_jakiro/jakiro_liquid_fire_ready.vpcf",
	"particles/units/heroes/hero_legion_commander/legion_commander_odds.vpcf",
	"particles/units/heroes/hero_chen/chen_holy_persuasion.vpcf",
	"particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf",
	"particles/units/heroes/hero_tusk/tusk_frozen_sigil.vpcf",
	"particles/units/heroes/hero_tusk/tusk_walruspunch_start.vpcf",
	"particles/units/heroes/hero_tusk/tusk_walruspunch_txt_ult.vpcf",
	"particles/generic_hero_status/status_invisibility_start.vpcf",
	"particles/units/heroes/hero_mirana/mirana_moonlight_recipient.vpcf",
	"particles/units/heroes/hero_phoenix/phoenix_icarus_dive_burn_debuff.vpcf",
	"particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast_debuff.vpcf",
	"particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_slow_debuff.vpcf",
	"particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_arcana_body_ambient.vpcf",
	"particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf",
	"particles/units/heroes/hero_winter_wyvern/wyvern_winters_curse_drop.vpcf",
	"particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_debuff.vpcf",
	"particles/status_fx/status_effect_terrorblade_reflection.vpcf",
	"particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_ambient_eyes_arcana_horns.vpcf",
	"particles/units/heroes/hero_lone_druid/lone_druid_battle_cry_overhead.vpcf",
	"particles/units/heroes/hero_treant/treant_livingarmor.vpcf",
	"particles/units/heroes/hero_centaur/centaur_stampede_overhead.vpcf",
	"particles/units/heroes/hero_centaur/centaur_warstomp.vpcf",
	"particles/econ/items/brewmaster/brewmaster_offhand_elixir/brewmaster_thunder_clap_elixir.vpcf",
	"particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf",
	"particles/units/heroes/hero_viper/viper_viper_strike_debuff.vpcf",
	"particles/units/heroes/hero_ember_spirit/ember_spirit_flameguard.vpcf",
	"particles/units/heroes/hero_ember_spirit/emberspirit_flame_shield_aoe_impact.vpcf",
	"particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf",
	"particles/units/heroes/hero_furion/furion_wrath_of_nature_old.vpcf",
	"particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf",
	"particles/econ/items/juggernaut/bladekeeper_healing_ward/juggernaut_healing_ward_dc.vpcf",
	"particles/econ/items/necrolyte/necronub_death_pulse/necrolyte_pulse_ka_friend_heal_sparks.vpcf",
	"particles/units/heroes/hero_medusa/medusa_mana_shield_shell_add.vpcf",
	"particles/items_fx/abyssal_blade.vpcf",
	"particles/units/heroes/hero_oracle/oracle_purifyingflames_heal.vpcf",
	"particles/wyvern_winters_curse_buff.vpcf",
	"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf",
	"particles/items_fx/drum_of_endurance_buff.vpcf",
	"particles/items2_fx/mekanism.vpcf",
	"particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf",
	"particles/units/heroes/hero_chaos_knight/chaos_knight_reality_rift_buff.vpcf",
	"particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_arcana.vpcf",
	"particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf",
	"particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_a.vpcf",
	"particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_b.vpcf",
	"particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf",
	"particles/units/heroes/hero_ursa/ursa_fury_sweep_cross.vpcf",
	"particles/units/heroes/hero_ursa/ursa_fury_swipes_debuff.vpcf",
	"particles/units/heroes/hero_windrunner/windrunner_windrun.vpcf",
	"particles/units/heroes/hero_gyrocopter/gyro_ambient.vpcf",
	"particles/econ/items/gyrocopter/hero_gyrocopter_atomic_gold/gyro_atomic_ray_ambient_gold.vpcf",
	"particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_guided_missile_target.vpcf",
	"particles/gyro_calldown_first.vpcf",
	"particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf",
	"particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_tgt.vpcf",
	"particles/units/heroes/hero_oracle/oracle_fortune_purge.vpcf",
	"particles/units/heroes/hero_alchemist/alchemist_lasthit_msg_gold.vpcf",
	"particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf",
	"particles/units/heroes/hero_dazzle/dazzle_armor_enemy.vpcf",
	"particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf",
	"particles/base_attacks/generic_projectile.vpcf",
	"particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf",
	"particles/banner_circle.vpcf",
	"particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_debuff.vpcf",
	"particles/items2_fx/hand_of_midas.vpcf",
	"particles/items2_fx/refresher.vpcf",
	"particles/units/heroes/hero_ember_spirit/ember_spirit_sleightoffist_trail.vpcf",
	"particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf",
	"particles/units/heroes/hero_ogre_magi/ogre_magi_ignite.vpcf",
	"particles/units/heroes/hero_ogre_magi/ogre_magi_ignite_debuff.vpcf",
	"particles/units/heroes/hero_viper/viper_poison_attack.vpcf",
	"particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf",
	"particles/units/heroes/hero_furion/furion_force_of_nature_cast.vpcf",
	"particles/units/heroes/hero_brewmaster/brewmaster_drunken_haze.vpcf",
	"particles/generic_gameplay/generic_manaburn.vpcf",
}
--音效预载入
SoundTabel={
	"soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts",
	"soundevents/game_sounds_ui.vsndevts",
	"soundevents/voscripts/game_sounds_vo_chen.vsndevts",
	"soundevents/game_sounds.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_keeper_of_the_light.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_doombringer.vsndevts",
	"soundevents/game_sounds_creeps.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_earthshaker.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_templar_assassin.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_undying.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_axe.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_leshrac.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_razor.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_lina.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts",
	"soundevents/voscripts/game_sounds_vo_abaddon.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_enchantress.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_juggernaut.vsndevts",
	"soundevents/voscripts/game_sounds_vo_announcer_killing_spree.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_dragon_knight.vsndevts",
	"soundevents/game_sounds_items.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_furion.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_kunkka.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_brewmaster.vsndevts",
	"soundevents/game_sounds_heroes/game_sounds_doombringer.vsndevts",
}

function Precache( context )
	-- print("BEGIN TO PRECACHE RESOURCE")
	local time = GameRules:GetGameTime()

	PrecacheEveryThingFromKV( context )

	for i=1,#ParticleTable do
		PrecacheParticle(ParticleTable[i],context)
	end
	local unitKv = LoadKeyValues("scripts/npc/npc_units_custom.txt")
	for k,v in pairs(unitKv) do
		PrecacheUnitByNameSync(k, context)
	end
	for i=1,#SoundTabel do
		PrecacheSound(SoundTabel[i],context)
	end

	time = time - GameRules:GetGameTime()
	-- print("DONE PRECACHEING IN:"..tostring(time).."Seconds")
end


_G.HeroNameTable={
	"npc_dota_hero_legion_commander",
	"npc_dota_hero_kunkka",
	"npc_dota_hero_furion",
}
_G.IsCommander = function(hUnit)
	if hUnit == nil then
		return false
	end
	for i,v in pairs(HeroNameTable) do
		if v == hUnit:GetUnitName() then
			return true
		end
	end
	return false
end
_G.GetRandomCommanderName = function()
	return HeroNameTable[RandomInt(1, #HeroNameTable)]
end

--游戏载入和事件监听
function Activate()
	GameRules.btf = CbtfGameMode()
	GameRules.btf:InitGameMode()
end


function CbtfGameMode:InitGameMode()
	-- print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetContextThink("UpadateScoreBoard",
		function()
			if GameRules:State_Get() >= DOTA_GAMERULES_STATE_PRE_GAME and GameRules:State_Get() < DOTA_GAMERULES_STATE_POST_GAME then
				self.UpdateScoreboard()
			end
			return 0.1
		end
	, 0.1)
	if GetMapName() == "3v3" then
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 3 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 3 )
	elseif GetMapName() == "2v2" then
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 2 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 2 )
	else
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 1 )
	end
	--GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("RoundThinker"), "RoundThinker", 0.1)
	GameRules:SetUseUniversalShopMode(true)
	SendToServerConsole("dota_max_physical_items_purchase_limit 9999")
	--隐藏原有面板
	GameRules:GetGameModeEntity():SetHUDVisible(12, false) --推荐物品栏
	Convars:SetInt("dota_render_crop_height", 0)
	Convars:SetInt("dota_render_y_inset", 0)
	-- Convars:GetBool("sv_cheats")

	Game:TestMode(false)
	Game:RankMode(true)
	Game:SetMatchID(GameRules:GetMatchID())

	--设置游戏准备时间
	if Game:IsTestMode() then
		GameRules:SetStartingGold(999999)
		GameRules:SetPreGameTime(5)
	else
		GameRules:SetPreGameTime(30)
		GameRules:SetStartingGold(700)
	end
	GameRules:SetCustomGameEndDelay(1)
	--重复选择英雄
	GameRules:SetSameHeroSelectionEnabled(true)

	--取消自动增加金钱
	GameRules:SetGoldPerTick(0)
	GameRules:SetGoldTickTime(999999)
	--设置选择英雄的时间
	GameRules:SetHeroSelectionTime(30)
	GameRules:SetShowcaseTime(0)
	GameRules:SetStrategyTime(0)

	--监听游戏
	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(CbtfGameMode,"OnGameRulesStateChange"), self) --规则改变
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(CbtfGameMode, "OnNPCSpawned"), self) --单位重生和创建
	ListenToGameEvent("entity_killed", Dynamic_Wrap(CbtfGameMode, "OnEntityKilled"), self) 	--单位被杀死
	ListenToGameEvent("dota_unit_event", Dynamic_Wrap(CbtfGameMode, "OnEvent"), self) 	--???
	ListenToGameEvent('player_disconnect', Dynamic_Wrap(CbtfGameMode, 'OnPlayerDisconnect'), self)
	ListenToGameEvent("player_reconnected", Dynamic_Wrap(CbtfGameMode, "OnPlayerReconnected" ), self ) --玩家重连事件
	ListenToGameEvent("player_connect_full", Dynamic_Wrap(CbtfGameMode, "OnPlayerConnectFull"), self)
	-- ListenToGameEvent("entity_hurt", Dynamic_Wrap(CbtfGameMode, "OnEntityHurt"), self) --伤害事件
--添加伤害事件

	CustomGameEventManager:RegisterListener("item_purchased", ItemPurchased)
	CustomGameEventManager:RegisterListener("boss_levelup", BossLevelup)
	CustomGameEventManager:RegisterListener("set_boss_controllable", SetBossControllableEvent)
	CustomGameEventManager:RegisterListener("reroll", Reroll)
	CustomGameEventManager:RegisterListener("update_player_settings", UpdatePlayerSettings)

	GameRules:GetGameModeEntity():SetExecuteOrderFilter( Dynamic_Wrap( CbtfGameMode, "ExecuteOrderFilter" ), self )
	GameRules:GetGameModeEntity():SetDamageFilter( Dynamic_Wrap( CbtfGameMode, "DamageFilter" ),self)
	GameRules:GetGameModeEntity():SetModifyGoldFilter( Dynamic_Wrap( CbtfGameMode, "ModifyGoldFilter" ),self)
	GameRules:GetGameModeEntity():SetItemAddedToInventoryFilter(Dynamic_Wrap(CbtfGameMode, "ItemAddedToInventoryFilter"), self)
end

function CbtfGameMode:OnPlayerConnectFull(keys)
	local playerID = keys.PlayerID
	if PlayerData:GetPlayerData(playerID) == nil then
		PlayerData(playerID)
	end
end

function CbtfGameMode:OnPlayerDisconnect( keys )
	GameRules:GetGameModeEntity():SetContextThink("abandon",
		function()
			PlayerData:Look(
				function(playerID, playerData)
					if not playerData:IsAbandon() and PlayerResource:GetConnectionState(playerID) == DOTA_CONNECTION_STATE_ABANDONED then
						playerData:Abandon()
					end
				end
			)
			return 1
		end
	,1)
end
function CbtfGameMode:ModifyGoldFilter( filterTable )
	-- print("ModifyGoldFilter begin")
	-- for k, v in pairs( filterTable ) do
	-- 	print(k .. " " .. tostring(v))
	-- end
	-- print("ModifyGoldFilter end")
	-- reason_const
	-- reliable
	-- player_id_const
	-- gold
	local playerData = PlayerData:GetPlayerData(filterTable.player_id_const)
	if playerData ~= nil then
		playerData:ModifyGoldByFilter(filterTable.gold, filterTable.reason_const)
	end

	return true
end

function UpdatePlayerSettings(index,keys)
	local playerID = keys.PlayerID
	local playerData = PlayerData:GetPlayerData(playerID)

	if keys.show_damage_message then
		playerData:ShowDamageMessage((keys.show_damage_message == 1))
	end
end

function Reroll(index,keys)
	local pid = keys.PlayerID
	local playerData = PlayerData:GetPlayerData(pid)
	--重选全部技能
	local BUILD_Q = playerData:GetBuildingTypeName("Q") --获取Q旧编号
	local BUILD_W = playerData:GetBuildingTypeName("W") --获取W旧编号
	local BUILD_E = playerData:GetBuildingTypeName("E") --获取E旧编号
	local BUILD_D = playerData:GetBuildingTypeName("D") --获取D旧编号
	local BUILD_F = playerData:GetBuildingTypeName("F") --获取F旧编号
	local BUILD_G = playerData:GetBuildingTypeName("G") --获取G旧编号
	local BUILD_R = playerData:GetBuildingTypeName("R") --获取R旧编号
	local BUILD_X = playerData:GetBuildingTypeName("X") --获取R旧编号

	if keys.Q == 1 then
		playerData:SetBuildingTypeName("Q", GetRandomBuildingTypeName("Q", BUILD_Q))
	end
	if keys.W == 1 then
		playerData:SetBuildingTypeName("W", GetRandomBuildingTypeName("W", BUILD_W))
	end
	if keys.E == 1 then
		playerData:SetBuildingTypeName("E", GetRandomBuildingTypeName("E", BUILD_E))
	end
	if keys.D == 1 then
		playerData:SetBuildingTypeName("D", GetRandomBuildingTypeName("D", BUILD_D))
	end
	if keys.F == 1 then
		playerData:SetBuildingTypeName("F", GetRandomBuildingTypeName("F", BUILD_F))
	end
	if keys.G == 1 then
		playerData:SetBuildingTypeName("G", GetRandomBuildingTypeName("G", BUILD_G))
	end
	if keys.R == 1 then
		playerData:SetBuildingTypeName("R", GetRandomBuildingTypeName("R", BUILD_Q))
	end
	if keys.X == 1 then
		playerData:SetBuildingTypeName("X", GetRandomBuildingTypeName("X", BUILD_Q))
	end
	--替换函数
	playerData:UpdateBuildingsBuildAbility()
end
--游戏结束传递信息到UI
function ComputeAndSendPlayerStates()
	if Game:GetRound() < 10 then
		Game:RankMode(false)
	end
	if Game:IsTestMode() then
		Game:RankMode(true)
	end

	local count = Game:GetPlayerCount()
	local damagetoking_rank = {}
	local killcount_rank = {}
	local breakgold_rank = {}
	local score_rank = {}
	local income_rank = {}
	local armaments_rank = {}
	local MVP = {}
	local MVP_rank = {}
	local MVP_PlayerPosition = 0
	local damagetoking_team1 = 0
	local damagetoking_team2 = 0
	local team1_level = 0
	local team2_level = 0
	local rank_add_score = {}
	local rank_level_seed = 0.02
	local rank_extra_score_seed = 2
	local rank_basic_score = 20
	local lastmvp = 0

	PlayerData:Look(
		function(playerID, playerData)
			local playerPosition = playerData:GetPlayerPosition()

			damagetoking_rank[playerPosition] = 1
			damagetoking_rank[playerPosition] = 1
			killcount_rank[playerPosition] = 1
			breakgold_rank[playerPosition] = 1
			score_rank[playerPosition] = 1
			income_rank[playerPosition] = 1
			armaments_rank[playerPosition] = 1
			PlayerData:Look(
				function(_playerID, _playerData)
					local _playerPosition = _playerData:GetPlayerPosition()
					if _playerData:GetDamageToKing() > playerData:GetDamageToKing() then
						damagetoking_rank[playerPosition] = damagetoking_rank[playerPosition] + 1
					end
					if _playerData:GetKills() > playerData:GetKills() then
						killcount_rank[playerPosition] = killcount_rank[playerPosition] + 1
					end
					if _playerData:GetBreakGold() > playerData:GetBreakGold() then
						breakgold_rank[playerPosition] = breakgold_rank[playerPosition] + 1
					end
					if _playerData:GetScore() > playerData:GetScore() then
						score_rank[playerPosition] = score_rank[playerPosition] + 1
					end
					if _playerData:GetAllIncome() > playerData:GetAllIncome() then
						income_rank[playerPosition] = income_rank[playerPosition] + 1
					end
					if _playerData:GetArmsValue() > playerData:GetArmsValue() then
						armaments_rank[playerPosition] = armaments_rank[playerPosition] + 1
					end
				end
			)
			MVP[playerPosition] = (count-damagetoking_rank[playerPosition])*11 + (count-killcount_rank[playerPosition])*8 + (count-breakgold_rank[playerPosition])*5 + (count-score_rank[playerPosition])*7 + (count-income_rank[playerPosition])*4 + (count-armaments_rank[playerPosition])*4
			if playerPosition <= 4 then
				damagetoking_team1 = damagetoking_team1 + playerData:GetDamageToKing()
				team1_level = team1_level + playerData:GetRankingLevel()
			end
			if playerPosition > 4 then
				damagetoking_team2 = damagetoking_team2 + playerData:GetDamageToKing()
				team2_level = team2_level + playerData:GetRankingLevel()
			end
		end
	)
	team1_level = team1_level/(count/2)
	team2_level = team2_level/(count/2)
	PlayerData:Look(
		function(playerID, playerData)
			local playerPosition = playerData:GetPlayerPosition()

			MVP_rank[playerPosition] = 1

			PlayerData:Look(
				function(_playerID, _playerData)
					local _playerPosition = _playerData:GetPlayerPosition()
					if MVP[_playerPosition] > MVP[playerPosition] then
						MVP_rank[playerPosition] = MVP_rank[playerPosition] + 1
					end
				end
			)
			if PlayerResource:GetTeam(playerID) == Game:GetWinnerTeam() then
				if lastmvp <= MVP[playerPosition] then
					lastmvp = MVP[playerPosition]
					MVP_PlayerPosition = playerPosition
				end
			end
			if Game:IsRankMode() then
				local rank_basic_score_s
				if PlayerResource:GetTeam(playerID) == Game:GetWinnerTeam() then
					rank_basic_score_s = rank_basic_score + 6
				else
					rank_basic_score_s = -rank_basic_score
				end
				if playerData:IsAbandon() and Game:GetRound() - playerData:GetAbandonRound() > 1 then
					rank_basic_score_s = rank_basic_score_s - 20
				end
				local rank_extra_score = (count/2 - MVP_rank[playerPosition]) * rank_extra_score_seed
				local rank_level_coefficient
				if playerPosition <= 4 then
					rank_level_coefficient = (team2_level-playerData:GetRankingLevel())*rank_level_seed
				else
					rank_level_coefficient = (team1_level-playerData:GetRankingLevel())*rank_level_seed
				end
				rank_add_score[playerPosition] = rank_basic_score_s + rank_extra_score + math.abs(rank_extra_score)*rank_level_coefficient
				if playerData:GetSteamID() then
					local match_id = tostring(Game:GetMatchID())
					-- print("match_id: "..match_id)
					local url= "http://www.dota2rpg.com/game_wz1/wz_set_ladderpoints.php?"
					url = url .. "playerid=" .. tostring(playerData:GetSteamID())
					url = url .. "&points=" .. rank_add_score[playerPosition]
					url = url .. "&match_id=" .. Game:GetMatchID()
					url = url .. "&wu_shuang=" .. wushuang.sumhexa(match_id)
					url = url .. "&hehe=" .. RandomInt(1000, 9999)
					local req = CreateHTTPRequestScriptVM("GET", url)
					req:Send(
						function (result)
						end
					)
					print(url)
				end
			end
		end
	)

	--传递数据
	local playeridtable = {}
	local mvptable = {}
	local rankingaddscoretable = {}
	PlayerData:Look(
		function(playerID, playerData)
			local playerPosition = playerData:GetPlayerPosition()

			playeridtable[playerPosition] = playerID
			mvptable[playerID] = MVP[playerPosition]
			rankingaddscoretable[playerID] = Round(rank_add_score[playerPosition], 1)
		end
	)
	CustomGameEventManager:Send_ServerToAllClients("end_screen_player_states", 
		{
			mvp = mvptable,
			rankingaddscore = rankingaddscoretable,
			mvpplayerposition = MVP_PlayerPosition,
			damagetoking1 = damagetoking_team1,
			damagetoking2 = damagetoking_team2,
			rank_mode = Game:IsRankMode(),
		}
	)
end
--DamageFilter
function CbtfGameMode:DamageFilter( filterTable )
	--print("DamageFilter begin")
	--for k, v in pairs( filterTable ) do
		--print("EO: " .. k .. " " .. tostring(v) )
	--end
	--print("DamageFilter end")
	--damagetype_const
	--damage
	--entindex_attacker_const
	--entindex_victim_const
	if filterTable.entindex_victim_const and filterTable.entindex_attacker_const then
		local damaged_unit = EntIndexToHScript(filterTable.entindex_victim_const)
		local source_unit = EntIndexToHScript(filterTable.entindex_attacker_const)
		if damaged_unit and source_unit then
			local damage = filterTable.damage
			if GetAandDSystem(damaged_unit) and GetAandDSystem(source_unit) and filterTable.damagetype_const==DAMAGE_TYPE_PHYSICAL then
				local damaged_unit_AandD = GetAandDSystem(damaged_unit)
				local source_unit_AandD = GetAandDSystem(source_unit)
				local resistance = damaged_unit_AandD:GetAttacktypeResistance(source_unit_AandD:GetAttackType())
				if damaged_unit:HasModifier("modifier_jn_X5_00c_buff") and source_unit_AandD:GetAttackType() == "magic" then
					if damaged_unit:GetContext("jn_X5_00c_absorb") > 0 then
						local absorb = damaged_unit:GetContext("jn_X5_00c_absorb")
						absorb = absorb - damage
						damaged_unit:SetContextNum("jn_X5_00c_absorb", absorb, 0)
						damage = math.max(0,-absorb)
						if absorb <= 0 then
							damaged_unit:RemoveModifierByName("modifier_jn_X5_00c_buff")
						end
					end
				end
				if damaged_unit:HasModifier("modifier_jn_X5_10c_buff") and source_unit_AandD:GetAttackType() == "magic" then
					if damaged_unit:GetContext("jn_X5_10c_absorb") > 0 then
						local absorb = damaged_unit:GetContext("jn_X5_10c_absorb")
						absorb = absorb - damage
						damaged_unit:SetContextNum("jn_X5_10c_absorb", absorb, 0)
						damage = math.max(0,-absorb)
						if absorb <= 0 then
							damaged_unit:RemoveModifierByName("modifier_jn_X5_10c_buff")
						end
					end
				end
				filterTable.damage = damage*(1-resistance)
				local pure_damage = filterTable.damage
				local damaged_hero
				local source_hero
				if damaged_unit:GetPlayerOwnerID() ~= -1 then
					damaged_hero = PlayerData:GetPlayerData(damaged_unit:GetPlayerOwnerID()):GetHero()
				end
				if source_unit:GetPlayerOwnerID() ~= -1 then
					source_hero = PlayerData:GetPlayerData(source_unit:GetPlayerOwnerID()):GetHero()
				end
				--吸血技能
				local lifesteal = 0--总
				if source_unit:HasModifier("modifier_jn_king_50_buff") then
					lifesteal = 0.15+lifesteal
				end

				local lifesteal1 = 0--分支1
				if source_unit:HasAbility("jn_Q3_10") then
					local ab = source_unit:FindAbilityByName("jn_Q3_10")
					lifesteal1 = math.max(ab:GetSpecialValueFor("lifesteal")*0.01,lifesteal1)
				end
				if source_unit:HasAbility("jn_Q3_20a") then
					local ab = source_unit:FindAbilityByName("jn_Q3_20a")
					lifesteal1 = math.max(ab:GetSpecialValueFor("lifesteal")*0.01,lifesteal1)
				end
				if source_unit:HasModifier("modifier_jn_E5_10b_buff") then
					lifesteal1 = math.max(0.32,lifesteal1)
				end
				if source_unit:HasModifier("modifier_jn_hire_10b_buff") then
					lifesteal1 = math.max(0.20,lifesteal1)
				end

				local lifesteal2 = 0--分支2
				if source_hero then
					if source_unit:HasModifier("modifier_armament_24_buff") and source_hero:HasItemInInventory("item_armament_24") then
						lifesteal2 = math.max(0.10,lifesteal2)
					end
					if source_unit:HasModifier("modifier_armament_24_buff") and source_hero:HasItemInInventory("item_armament_24_level2") then
						lifesteal2 = math.max(0.20,lifesteal2)
					end
					if source_unit:HasModifier("modifier_armament_24_buff") and source_hero:HasItemInInventory("item_armament_24_level3") then
						lifesteal2 = math.max(0.30,lifesteal2)
					end
				end
				if source_unit:HasModifier("modifier_jn_G1_10a_buff") then
					lifesteal2 = math.max(0.30,lifesteal2)
				end
				if source_unit:HasModifier("modifier_jn_G1_00_buff") then
					lifesteal2 = math.max(0.15,lifesteal2)
				end
				if source_unit:HasModifier("modifier_jn_general_3_buff") then
					lifesteal2 = math.max(0.15,lifesteal2)
				end

				lifesteal = lifesteal + lifesteal1 + lifesteal2
				if lifesteal > 0 then
					lifesteal = pure_damage*lifesteal
					if source_unit:GetHealthPercent() ~= 100 then
						local particleId = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_CUSTOMORIGIN, source_unit)
						ParticleManager:SetParticleControlEnt(particleId, 0, source_unit, PATTACH_POINT_FOLLOW, nil, source_unit:GetOrigin(), true)
						ParticleManager:ReleaseParticleIndex(particleId)
					end
					source_unit:Heal(lifesteal, source_unit)
				end
				--
				if damaged_unit:HasModifier("modifier_jn_G2_10a_buff") and not source_unit:IsRangedAttacker() then
					local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, damaged_unit)
					ParticleManager:SetParticleControlEnt(particleId, 1, source_unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", source_unit:GetOrigin(), true)
					ParticleManager:SetParticleControl(particleId, 2, Vector(0.2,0,0))
					ParticleManager:ReleaseParticleIndex(particleId)
					DamageManager:SpellDamage( damaged_unit, source_unit, pure_damage*0.15)
				elseif damaged_unit:HasModifier("modifier_jn_G2_00_buff") and not source_unit:IsRangedAttacker() then
					local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, damaged_unit)
					ParticleManager:SetParticleControlEnt(particleId, 1, source_unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", source_unit:GetOrigin(), true)
					ParticleManager:SetParticleControl(particleId, 2, Vector(0.2,0,0))
					ParticleManager:ReleaseParticleIndex(particleId)
					DamageManager:SpellDamage( damaged_unit, source_unit, pure_damage*0.10)
				end
			end
			if damaged_unit == Game:GetLeftKing() or damaged_unit == Game:GetRightKing() then
				if source_unit:GetPlayerOwnerID() ~= -1 then
					PlayerData:GetPlayerData(source_unit:GetPlayerOwnerID()):IncrementDamageToKing(filterTable.damage)
				end
			end
		end
		if PlayerResource:IsValidPlayer(source_unit:GetPlayerOwnerID()) then
			PlayerData:Look(
				function(playerID, playerData)
					if PlayerResource:IsValidPlayer(playerID) and playerData:IsShowDamageMessage() == true then
						SendOverheadEventMessage(PlayerResource:GetPlayer(playerID), OVERHEAD_ALERT_DAMAGE, damaged_unit, filterTable.damage, nil)
					end
				end
			)
		end
	end
	return true
end
--ExecuteOrderFilter
	levelupitemtable = {
		[3009]="item_armament_2",
		[3010]="item_armament_2",
		[3011]="item_armament_2_level2",
		[3012]="item_armament_2_level2",
		[3014]="item_armament_3",
		[3015]="item_armament_3",
		[3016]="item_armament_3_level2",
		[3017]="item_armament_3_level2",
		[3019]="item_armament_4",
		[3020]="item_armament_4",
		[3021]="item_armament_4_level2",
		[3022]="item_armament_4_level2",
		[3024]="item_armament_5",
		[3025]="item_armament_5",
		[3026]="item_armament_5_level2",
		[3027]="item_armament_5_level2",
		[3030]="item_armament_7",
		[3031]="item_armament_7",
		[3033]="item_armament_8",
		[3034]="item_armament_8",
		[3040]="item_armament_13",
		[3041]="item_armament_13",
		[3042]="item_armament_13_level2",
		[3043]="item_armament_13_level2",
		[3047]="item_armament_16",
		[3048]="item_armament_16",
		[3049]="item_armament_16_level2",
		[3050]="item_armament_16_level2",
		[3052]="item_armament_17",
		[3053]="item_armament_17",
		[3055]="item_armament_18",
		[3056]="item_armament_18",
		[3058]="item_armament_19",
		[3059]="item_armament_19",
		[3060]="item_armament_19_level2",
		[3061]="item_armament_19_level2",
		[3062]="item_armament_14",
		[3063]="item_armament_14",
		[3064]="item_armament_14_level2",
		[3065]="item_armament_14_level2",
		[3070]="item_armament_23",
		[3071]="item_armament_23",
		[3072]="item_armament_23_level2",
		[3073]="item_armament_23_level2",
		[3075]="item_armament_24",
		[3076]="item_armament_24",
		[3077]="item_armament_24_level2",
		[3078]="item_armament_24_level2",
		[3081]="item_armament_26",
		[3082]="item_armament_26",
		[3083]="item_armament_26_level2",
		[3084]="item_armament_26_level2",
		[3086]="item_armament_27",
		[3087]="item_armament_27",
		[3088]="item_armament_27_level2",
		[3089]="item_armament_27_level2",
		[3091]="item_armament_28",
		[3092]="item_armament_28",
		[3094]="item_armament_29",
		[3095]="item_armament_29",
		[3096]="item_armament_29_level2",
		[3097]="item_armament_29_level2",
		[3099]="item_armament_30",
		[3100]="item_armament_30",
		[3101]="item_armament_30_level2",
		[3102]="item_armament_30_level2",
		[3104]="item_armament_31",
		[3105]="item_armament_31",
		[3107]="item_armament_32",
		[3108]="item_armament_32",
		[3110]="item_armament_33",
		[3111]="item_armament_33",
		[3112]="item_armament_33_level2",
		[3113]="item_armament_33_level2",
	}
	ItemName = {
		[3007]="item_armament_1",
		[3008]="item_armament_2",
		[3009]="item_armament_2",
		[3010]="item_armament_2",
		[3011]="item_armament_2",
		[3012]="item_armament_2",
		[3013]="item_armament_3",
		[3014]="item_armament_3",
		[3015]="item_armament_3",
		[3016]="item_armament_3",
		[3017]="item_armament_3",
		[3018]="item_armament_4",
		[3019]="item_armament_4",
		[3020]="item_armament_4",
		[3021]="item_armament_4",
		[3022]="item_armament_4",
		[3023]="item_armament_5",
		[3024]="item_armament_5",
		[3025]="item_armament_5",
		[3026]="item_armament_5",
		[3027]="item_armament_5",
		[3028]="item_armament_6",
		[3029]="item_armament_7",
		[3030]="item_armament_7",
		[3031]="item_armament_7",
		[3032]="item_armament_8",
		[3033]="item_armament_8",
		[3034]="item_armament_8",
		[3035]="item_armament_9",
		[3036]="item_armament_10",
		[3037]="item_armament_11",
		[3038]="item_armament_12",
		[3039]="item_armament_13",
		[3040]="item_armament_13",
		[3041]="item_armament_13",
		[3042]="item_armament_13",
		[3043]="item_armament_13",
		[3044]="item_armament_14",
		[3045]="item_armament_15",
		[3046]="item_armament_16",
		[3047]="item_armament_16",
		[3048]="item_armament_16",
		[3049]="item_armament_16",
		[3050]="item_armament_16",
		[3051]="item_armament_17",
		[3052]="item_armament_17",
		[3053]="item_armament_17",
		[3054]="item_armament_18",
		[3055]="item_armament_18",
		[3056]="item_armament_18",
		[3057]="item_armament_19",
		[3058]="item_armament_18",
		[3059]="item_armament_19",
		[3060]="item_armament_19",
		[3061]="item_armament_19",
		[3062]="item_armament_14",
		[3063]="item_armament_14",
		[3064]="item_armament_14",
		[3065]="item_armament_14",
		[3066]="item_armament_20",
		[3067]="item_armament_21",
		[3068]="item_armament_22",
		[3069]="item_armament_23",
		[3070]="item_armament_23",
		[3071]="item_armament_23",
		[3072]="item_armament_23",
		[3073]="item_armament_23",
		[3074]="item_armament_24",
		[3075]="item_armament_24",
		[3076]="item_armament_24",
		[3077]="item_armament_24",
		[3078]="item_armament_24",
		[3079]="item_armament_25",
		[3080]="item_armament_26",
		[3081]="item_armament_26",
		[3082]="item_armament_26",
		[3083]="item_armament_26",
		[3084]="item_armament_26",
		[3085]="item_armament_27",
		[3086]="item_armament_27",
		[3087]="item_armament_27",
		[3088]="item_armament_27",
		[3089]="item_armament_27",
		[3090]="item_armament_28",
		[3091]="item_armament_28",
		[3092]="item_armament_28",
		[3093]="item_armament_29",
		[3094]="item_armament_29",
		[3095]="item_armament_29",
		[3096]="item_armament_29",
		[3097]="item_armament_29",
		[3098]="item_armament_30",
		[3099]="item_armament_30",
		[3100]="item_armament_30",
		[3101]="item_armament_30",
		[3102]="item_armament_30",
		[3103]="item_armament_31",
		[3104]="item_armament_31",
		[3105]="item_armament_31",
		[3106]="item_armament_32",
		[3107]="item_armament_32",
		[3108]="item_armament_32",
		[3109]="item_armament_33",
		[3110]="item_armament_33",
		[3111]="item_armament_33",
		[3112]="item_armament_33",
		[3113]="item_armament_33",
		[3114]="item_armament_34",
		[3115]="item_armament_35",
		[3116]="item_armament_36",
		[3117]="item_armament_37",
		[3118]="item_armament_38",
	}
	LevelItemName = {
		["item_armament_1"]					="item_armament_1",
		["item_armament_2"]					="item_armament_2",
		["item_recipe_armament_2_level2"]	="item_armament_2",
		["item_armament_2_level2"]			="item_armament_2",
		["item_recipe_armament_2_level3"]	="item_armament_2",
		["item_armament_2_level3"]			="item_armament_2",
		["item_armament_3"]					="item_armament_3",
		["item_recipe_armament_3_level2"]	="item_armament_3",
		["item_armament_3_level2"]			="item_armament_3",
		["item_recipe_armament_3_level3"]	="item_armament_3",
		["item_armament_3_level3"]			="item_armament_3",
		["item_armament_4"]					="item_armament_4",
		["item_recipe_armament_4_level2"]	="item_armament_4",
		["item_armament_4_level2"]			="item_armament_4",
		["item_recipe_armament_4_level3"]	="item_armament_4",
		["item_armament_4_level3"]			="item_armament_4",
		["item_armament_5"]					="item_armament_5",
		["item_recipe_armament_5_level2"]	="item_armament_5",
		["item_armament_5_level2"]			="item_armament_5",
		["item_recipe_armament_5_level3"]	="item_armament_5",
		["item_armament_5_level3"]			="item_armament_5",
		["item_armament_6"]					="item_armament_6",
		["item_armament_7"]					="item_armament_7",
		["item_recipe_armament_7_level2"]	="item_armament_7",
		["item_armament_7_level2"]			="item_armament_7",
		["item_armament_8"]					="item_armament_8",
		["item_recipe_armament_8_level2"]	="item_armament_8",
		["item_armament_8_level2"]			="item_armament_8",
		["item_armament_9"]					="item_armament_9",
		["item_armament_10"]				="item_armament_10",
		["item_armament_11"]				="item_armament_11",
		["item_armament_12"]				="item_armament_12",
		["item_armament_13"]				="item_armament_13",
		["item_recipe_armament_13_level2"]	="item_armament_13",
		["item_armament_13_level2"]			="item_armament_13",
		["item_recipe_armament_13_level3"]	="item_armament_13",
		["item_armament_13_level3"]			="item_armament_13",
		["item_armament_14"]				="item_armament_14",
		["item_recipe_armament_14_level2"]	="item_armament_14",
		["item_armament_14_level2"]			="item_armament_14",
		["item_recipe_armament_14_level3"]	="item_armament_14",
		["item_armament_14_level3"]			="item_armament_14",
		["item_armament_15"]				="item_armament_15",
		["item_armament_16"]				="item_armament_16",
		["item_recipe_armament_16_level2"]	="item_armament_16",
		["item_armament_16_level2"]			="item_armament_16",
		["item_recipe_armament_16_level3"]	="item_armament_16",
		["item_armament_16_level3"]			="item_armament_16",
		["item_armament_17"]				="item_armament_17",
		["item_recipe_armament_17_level2"]	="item_armament_17",
		["item_armament_17_level2"]			="item_armament_17",
		["item_armament_18"]				="item_armament_18",
		["item_recipe_armament_18_level2"]	="item_armament_18",
		["item_armament_18_level2"]			="item_armament_18",
		["item_armament_19"]				="item_armament_19",
		["item_recipe_armament_19_level2"]	="item_armament_19",
		["item_armament_19_level2"]			="item_armament_19",
		["item_recipe_armament_19_level3"]	="item_armament_19",
		["item_armament_19_level3"]			="item_armament_19",
		["item_armament_20"]				="item_armament_20",
		["item_armament_21"]				="item_armament_21",
		["item_armament_22"]				="item_armament_22",
		["item_armament_23"]				="item_armament_23",
		["item_recipe_armament_23_level2"]	="item_armament_23",
		["item_armament_23_level2"]			="item_armament_23",
		["item_recipe_armament_23_level3"]	="item_armament_23",
		["item_armament_23_level3"]			="item_armament_23",
		["item_armament_24"]				="item_armament_24",
		["item_recipe_armament_24_level2"]	="item_armament_24",
		["item_armament_24_level2"]			="item_armament_24",
		["item_recipe_armament_24_level3"]	="item_armament_24",
		["item_armament_24_level3"]			="item_armament_24",
		["item_armament_25"]				="item_armament_25",
		["item_armament_26"]				="item_armament_26",
		["item_recipe_armament_26_level2"]	="item_armament_26",
		["item_armament_26_level2"]			="item_armament_26",
		["item_recipe_armament_26_level3"]	="item_armament_26",
		["item_armament_26_level3"]			="item_armament_26",
		["item_armament_27"]				="item_armament_27",
		["item_recipe_armament_27_level2"]	="item_armament_27",
		["item_armament_27_level2"]			="item_armament_27",
		["item_recipe_armament_27_level3"]	="item_armament_27",
		["item_armament_27_level3"]			="item_armament_27",
		["item_armament_28"]				="item_armament_28",
		["item_recipe_armament_28_level2"]	="item_armament_28",
		["item_armament_28_level2"]			="item_armament_28",
		["item_armament_29"]				="item_armament_29",
		["item_recipe_armament_29_level2"]	="item_armament_29",
		["item_armament_29_level2"]			="item_armament_29",
		["item_recipe_armament_29_level3"]	="item_armament_29",
		["item_armament_29_level3"]			="item_armament_29",
		["item_armament_30"]				="item_armament_30",
		["item_recipe_armament_30_level2"]	="item_armament_30",
		["item_armament_30_level2"]			="item_armament_30",
		["item_recipe_armament_30_level3"]	="item_armament_30",
		["item_armament_30_level3"]			="item_armament_30",
		["item_armament_31"]				="item_armament_31",
		["item_recipe_armament_31_level2"]	="item_armament_31",
		["item_armament_31_level2"]			="item_armament_31",
		["item_armament_32"]				="item_armament_32",
		["item_recipe_armament_32_level2"]	="item_armament_32",
		["item_armament_32_level2"]			="item_armament_32",
		["item_armament_33"]				="item_armament_33",
		["item_recipe_armament_33_level2"]	="item_armament_33",
		["item_armament_33_level2"]			="item_armament_33",
		["item_recipe_armament_33_level3"]	="item_armament_33",
		["item_armament_33_level3"]			="item_armament_33",
		["item_armament_34"]				="item_armament_34",
		["item_armament_35"]				="item_armament_35",
		["item_armament_36"]				="item_armament_36",
		["item_armament_37"]				="item_armament_37",
		["item_armament_38"]				="item_armament_38",
	}

function HasAnyAvailableInventorySpace(hero)
	for i = 0, 5 do
		local item = hero:GetItemInSlot(i)
		if item == nil then
			return true
		end
	end
	return false
end

function CbtfGameMode:ExecuteOrderFilter( filterTable )
	-- print("ExecuteOrderFilter begin")
	-- for k, v in pairs( filterTable ) do
	-- 	print("EO: " .. k .. " " .. tostring(v) )
	-- end
	-- print("ExecuteOrderFilter end")
	--entindex_ability
	--sequence_number_const
	--queue
	--units
	--entindex_target
	--position_z
	--position_x
	--order_type
	--position_y
	--issuer_player_id_const
	--军备购买条件
	if filterTable.order_type == 16 then
		if filterTable.entindex_ability < 3000 or filterTable.entindex_ability > 4000 then
			return false
		end
		local hero = EntIndexToHScript(filterTable.units["0"])
		if not IsCommander(hero) then
			BTFGeneral:ShowError(hero:GetPlayerOwnerID(),"#OnlyCommanderCanTakeArmaments","General.NoGold") --警告信息
			return false
		end

		local itemname_levelup = levelupitemtable[filterTable.entindex_ability] or ""
		local itemname_s = ItemName[filterTable.entindex_ability] or ""
		if not hero:HasItemInInventory(itemname_levelup) then
			if not HasAnyAvailableInventorySpace(hero) then
				BTFGeneral:ShowError(hero:GetPlayerOwnerID(),"#PurchaseFail","General.NoGold") --警告信息
				return false
			else
				-- print(itemname_s)
				for i=0,5,1 do
					local item = hero:GetItemInSlot(i)
					if item then
						if LevelItemName[item:GetName()] == itemname_s then
							BTFGeneral:ShowError(hero:GetPlayerOwnerID(),"#TeamHasArmaments","General.NoGold") --警告信息
							return false
						end
					end
				end
			end
		end

		--队伍判断
		local teamHasArmaments = false
		PlayerData:Look(
			function(playerID, playerData)
				if PlayerResource:GetTeam(playerID) == hero:GetTeamNumber() and playerID ~= hero:GetPlayerOwnerID() then
					local _hero = playerData:GetHero()
					for i = 0, 5, 1 do
						local item = _hero:GetItemInSlot(i)
						if item then
							if LevelItemName[item:GetName()] == itemname_s then
								teamHasArmaments = true
								return true
							end
						end
					end
				end
			end
		)
		if teamHasArmaments then
			BTFGeneral:ShowError(hero:GetPlayerOwnerID(),"#TeamHasArmaments","General.NoGold") --警告信息
			return false
		end
	end
	--卖出军备判断
	if filterTable.order_type == 17 then

		local hero = EntIndexToHScript(filterTable.units["0"])
		local item = EntIndexToHScript(filterTable.entindex_ability)
		local playerData = PlayerData:GetPlayerData(hero:GetPlayerOwnerID())
		if not IsCommander(hero) then
			BTFGeneral:ShowError(hero:GetPlayerOwnerID(),"#OnlyCommanderCanTakeArmaments","General.NoGold") --警告信息
			return false
		end

		if playerData then
			if playerData:GetCrystal() < 300 then
				BTFGeneral:ShowError(hero:GetPlayerOwnerID(),"#SellItemLumberEnough","General.NoGold") --警告信息
				return false
			else
				local cost = item:GetCost()
				if (GameRules:GetGameTime()-item:GetPurchaseTime()) > 10 then
					cost = math.floor(cost/2)
				end
				playerData:ModifyGold(cost)
				playerData:ModifyCrystal(-300)
			end
		end
	end

	return true
end
--ItemAddedToInventoryFilter
function CbtfGameMode:ItemAddedToInventoryFilter(filterTable)
	local item = EntIndexToHScript(filterTable.item_entindex_const)
	local unit = EntIndexToHScript(filterTable.inventory_parent_entindex_const)
	if IsCommander(unit) then
		local playerID = unit:GetPlayerOwnerID()
		local playerData = PlayerData:GetPlayerData(playerID)

		playerData:ModifyGold(-item:GetCost())
	end
	return true
end
--触发事件 游戏规则改变
function CbtfGameMode:OnGameRulesStateChange( keys )
	--获取游戏进度
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		--开始选择英雄
		Game:SetLeftPlayerCount(PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS))
		Game:SetRightPlayerCount(PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_BADGUYS))

		local playerCount = Game:GetPlayerCount()
		if playerCount < 4 then
			Game:RankMode(false)
		end
		local PlayerPosition1 = 0
		local PlayerPosition2 = 4
		for i = 0, playerCount-1, 1 do
			if PlayerResource:GetTeam(i) == DOTA_TEAM_GOODGUYS then
				PlayerPosition1 = PlayerPosition1 + 1--位置1-4
				CbtfGameMode:InitPlayer(i, PlayerPosition1)
			end
			if PlayerResource:GetTeam(i) == DOTA_TEAM_BADGUYS then
				PlayerPosition2 = PlayerPosition2 + 1--位置5-8
				CbtfGameMode:InitPlayer(i, PlayerPosition2)
			end
		end

		local initLife = math.max(Game:GetLeftPlayerCount(), Game:GetRightPlayerCount())
		Game:ModifyLeftLife(initLife)
		Game:ModifyRightLife(initLife)

		Game:SetRoundTime(38)
		Game:SetEarnCrystalTime(7)
		--刷王和地基等物体
		chushihua:SpawnBuildBase()
	elseif newState == DOTA_GAMERULES_STATE_PRE_GAME then
		--游戏准备
		playerstarts:CreatePortal()
	elseif newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--游戏开始
		PlayerData:Look(
			function(playerID, playerData)
				local playerPosition = playerData:GetPlayerPosition()

				if playerData:GetHero() == nil and PlayerResource:IsValidPlayer(playerID) then
					local hero = CreateHeroForPlayer(GetRandomCommanderName(), PlayerResource:GetPlayer(playerID))
					hero:SetControllableByPlayer(playerID, true)
					playerData:SetHero(hero)
				end

				local ent = Entities:FindByName(nil, "player_"..tostring(playerPosition).."_farmer_4")
				local techBuilding = UnitManager:CreateUnitByName("npc_dummy_lib", ent:GetAbsOrigin(), false, playerID, PlayerResource:GetTeam(playerID))
				techBuilding:SetControllableByPlayer(playerID, true)
				playerData:SetTechBuilding(techBuilding)

				local ent = Entities:FindByName(nil, "player_"..tostring(playerPosition).."_farmer_3")
				local foodBuilding = UnitManager:CreateUnitByName("npc_dummy_pig", ent:GetAbsOrigin(), false, playerID, PlayerResource:GetTeam(playerID))
				foodBuilding:SetControllableByPlayer(playerID, true)
				playerData:SetFoodBuilding(foodBuilding)

				local ent = Entities:FindByName(nil, "player_"..tostring(playerPosition).."_farmer_2")
				local bannerBuilding = UnitManager:CreateUnitByName("npc_dummy_banner", ent:GetAbsOrigin(), false, playerID, PlayerResource:GetTeam(playerID))
				bannerBuilding:SetControllableByPlayer(playerID, true)
				if PlayerResource:GetTeam(playerID) == DOTA_TEAM_BADGUYS then
					bannerBuilding:SetOriginalModel("models/props_teams/banner_dire_small.vmdl")
				end
				playerData:SetBannerBuilding(bannerBuilding)

				playerData:LookBuildings(
					function(n, building)
						building:SetBaseManaRegen(20)
					end
				)
			end
		)

		--计时器
		Game:SetNextRoundTime(GameRules:GetGameTime() + Game:GetRoundTime())
		Game:SetNextEarnCrystalTime(GameRules:GetGameTime() + Game:GetEarnCrystalTime())
		GameRules:GetGameModeEntity():SetContextThink("GlobalThink",
			function()
				local now = GameRules:GetGameTime()
				RoundThinker(now)

				if GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
					return nil
				end
				return 0
			end
		,0)
	end
end
CustomMessage = false
--触发事件 单位重生和创建
function CbtfGameMode:OnNPCSpawned( keys )
	local trigger_unit = EntIndexToHScript(keys.entindex)
	local trigger_unit_team_number = trigger_unit:GetTeamNumber()
	--设置新生单位的朝向
	if trigger_unit_team_number == DOTA_TEAM_GOODGUYS then
		trigger_unit:SetForwardVector((Vector(2000,0,0) - Vector(-2000,0,0)):Normalized())--朝右
	end
	if trigger_unit_team_number == DOTA_TEAM_BADGUYS then
		trigger_unit:SetForwardVector((Vector(-2000,0,0) - Vector(2000,0,0)):Normalized())--朝左
	end

	--是英雄的话 传送到开始点
	if trigger_unit:IsRealHero() == true then
		local hero = trigger_unit
		local playerID = hero:GetPlayerOwnerID()
		local playerData = PlayerData:GetPlayerData(playerID)

		playerData:SetHero(hero)

		if not CustomMessage then
			CustomMessage = true
			ShowCustomHeaderMessage("#SelectTime", playerID, hero:entindex(), 5)
		end

		playerstarts:init(hero)
	end
end

function GameWinner(winner_team)
	local king
	Game:SetWinnerTeam(winner_team)
	if winner_team == DOTA_TEAM_GOODGUYS then
		king = Game:GetRightKing()
	end
	if winner_team == DOTA_TEAM_BADGUYS then
		king = Game:GetLeftKing()
	end
	GameRules:SetGameWinner(winner_team)
	for _, i in pairs( AllPlayers ) do
		local pid = PlayerCalc:GetPlayerIDByPosition(i)
		PlayerResource:SetCameraTarget(pid, king)
	end
	CustomUI:DynamicHud_Create(-1,"end_screen","file://{resources}/layout/custom_game/end_screen.xml",nil)
	ComputeAndSendPlayerStates()
end
--单位被杀死
NoDeathAnimationUnitNameTable={
	"npc_unit_G4_00_BZ",
	"npc_unit_G4_10_BZ",
	"npc_unit_G4_11_BZ",
	"npc_unit_R7_00_BZ",
	"npc_unit_R7_10_BZ",
}
function IsNoDeathAnimation(unit)
	if unit then
		for i,v in pairs(NoDeathAnimationUnitNameTable) do
			if unit:GetUnitName() == v then
				return true
			end
		end
	end
	return false
end
function CbtfGameMode:OnEntityKilled(keys)
	local killed_unit = EntIndexToHScript( keys.entindex_killed )
	local killing_unit = EntIndexToHScript( keys.entindex_attacker )

	if killed_unit == Game:GetLeftKing() then
		GameWinner(DOTA_TEAM_BADGUYS)
	end
	if killed_unit == Game:GetRightKing() then
		GameWinner(DOTA_TEAM_GOODGUYS)
	end
	if killed_unit then
		if IsNoDeathAnimation(killed_unit) then
			killed_unit:SetAbsOrigin(killed_unit:GetAbsOrigin()+Vector(0,0,-1000))
		end
	end
end

function CbtfGameMode:OnEvent(keys)
	-- print("---------- UnKnow Dota Event ----------")
	-- DeepPrintTable(keys)
end

--记分牌
function CbtfGameMode:UpdateScoreboard()
	-- if IsServer() then
	-- 	for _, PlayerPosition in pairs( AllPlayers ) do
	-- 		local pid = PlayerCalc:GetPlayerIDByPosition(PlayerPosition)
	-- 		PlayerS[PlayerPosition].Gold = PlayerResource:GetGold(pid)  --金币绑定

	-- 		local hero = PlayerS[PlayerPosition].Hero
	-- 		if hero then
	-- 			PlayerS[PlayerPosition].Arms = 0
	-- 			for i=0,5,1 do
	-- 				local item = hero:GetItemInSlot(i)
	-- 				if item then
	-- 					PlayerS[PlayerPosition].Arms = PlayerS[PlayerPosition].Arms + item:GetCost()
	-- 				end
	-- 			end
	-- 		end

	-- 		local GoldNum = PlayerS[PlayerPosition].Gold
	-- 		local LumberNum = PlayerS[PlayerPosition].Lumber
	-- 		local CurFoodNum = PlayerS[PlayerPosition].CurFood
	-- 		local FullFoodNum = PlayerS[PlayerPosition].FullFood
	-- 		local TechNum = PlayerS[PlayerPosition].Tech
	-- 		local FarmerNum = PlayerS[PlayerPosition].FarmerNum
	-- 		local ScoreNum = PlayerS[PlayerPosition].Score
	-- 		local BaseIncomeNum = PlayerS[PlayerPosition].BaseIncome
	-- 		local IncomeNum = PlayerS[PlayerPosition].Income
	-- 		local ArmsNum = PlayerS[PlayerPosition].Arms
	-- 		local ADLevel = PlayerS[PlayerPosition].ADLevel
	-- 		local HLevel = PlayerS[PlayerPosition].HLevel
	-- 		local HRLevel = PlayerS[PlayerPosition].HRLevel


	-- 		local BossADLevel = 0
	-- 		local BossHLevel = 0
	-- 		local BossHRLevel = 0
	-- 		if king_left and king_right then
	-- 			if PlayerResource:GetTeam(pid) == DOTA_TEAM_GOODGUYS then
	-- 				BossADLevel = king_left:GetContext("attackdamagelevel")
	-- 				BossHLevel = king_left:GetContext("healthlevel")
	-- 				BossHRLevel = king_left:GetContext("healthregenlevel")
	-- 			else
	-- 				BossADLevel = king_right:GetContext("attackdamagelevel")
	-- 				BossHLevel = king_right:GetContext("healthlevel")
	-- 				BossHRLevel = king_right:GetContext("healthregenlevel")
	-- 			end
	-- 		end
	-- 		if PlayerResource:IsValidPlayer(pid) then
	-- 			local player = PlayerResource:GetPlayer(pid)
	-- 			if IsValidEntity(player) then
	-- 				CustomGameEventManager:Send_ServerToPlayer(player, "updateplayerstates",{
	-- 					gold=GoldNum,
	-- 					crystal=LumberNum,
	-- 					baseincome=BaseIncomeNum,
	-- 					income=IncomeNum,
	-- 					score=ScoreNum,
	-- 					woker=FarmerNum,
	-- 					tech=TechNum,
	-- 					food_count=CurFoodNum,
	-- 					food_max=FullFoodNum,
	-- 					ranking_level=PlayerS[PlayerPosition].ranking_level,
	-- 					ranking_appellation=PlayerS[PlayerPosition].ranking_appellation,
	-- 					ranking_score=PlayerS[PlayerPosition].ranking_score,
	-- 					ranking_rank=PlayerS[PlayerPosition].ranking_rank,
	-- 					bossadlevel=BossADLevel,
	-- 					bosshlevel=BossHLevel,
	-- 					bosshrlevel=BossHRLevel,
	-- 				})--传递数据到玩家面板，更新玩家数据
	-- 			end
	-- 		end
	-- 		CustomGameEventManager:Send_ServerToAllClients("updateflyoutscoreboard",{
	-- 			position=PlayerPosition,
	-- 			playerid=pid,
	-- 			income=IncomeNum+BaseIncomeNum,
	-- 			score=ScoreNum,
	-- 			woker=FarmerNum,
	-- 			tech=TechNum,
	-- 			armaments=ArmsNum,
	-- 			ranking_level=PlayerS[PlayerPosition].ranking_level,
	-- 			ranking_appellation=PlayerS[PlayerPosition].ranking_appellation,
	-- 			showtoother=(GetRound()>=8),
	-- 			playerteam=PlayerResource:GetTeam(pid),
	-- 			adlevel=ADLevel,
	-- 			hlevel=HLevel,
	-- 			hrlevel=HRLevel,
	-- 			bossbool=(king_left and king_right),
	-- 			boss1=king_left:GetEntityIndex(),
	-- 			bosslife1=GameRules.LeftLife,
	-- 			boss2=king_right:GetEntityIndex(),
	-- 			bosslife2=GameRules.RightLife,
	-- 		})--传递数据到积分板，更新玩家数据
	-- 	end
	-- 	CustomGameEventManager:Send_ServerToAllClients("updateround",{round=GetRound()})
	-- end
end
--初始化玩家
function CbtfGameMode:InitPlayer(PlayerID,PlayerPosition)
	-- PlayerCalc:SetPlayerIDPosition(PlayerID,PlayerPosition)
	-- if PlayerS[PlayerPosition] == nil then--用位置来代替玩家ID
	-- 	PlayerS[PlayerPosition] = {}
	-- 	PlayerS[PlayerPosition].playerid = PlayerID
	-- 	table.insert( AllPlayers, PlayerPosition)                                                         --加入全部玩家队伍

	-- 	local start_ent = Entities:FindByName(nil,"portal"..tostring(PlayerPosition))
	-- 	local start_point = start_ent:GetAbsOrigin()

	-- 	PlayerS[PlayerPosition].StartPoint = start_point

	-- 	PlayerS[PlayerPosition].Lumber = 0                 --定义初始木材  0
	-- 	PlayerS[PlayerPosition].CurFood = 1                      --初始当前人口1
	-- 	PlayerS[PlayerPosition].FullFood = 16                     --初始最大人口16            每次提升8
	-- 	PlayerS[PlayerPosition].FarmerNum = 1                    --初始采集者数量 1         最多为8
	-- 	PlayerS[PlayerPosition].Tech = 0                         --初始采集科技等级        最多为8
	-- 	PlayerS[PlayerPosition].Score = 0                     --初始兵力
	-- 	PlayerS[PlayerPosition].BaseIncome = 100                 --初始基础收入
	-- 	PlayerS[PlayerPosition].Income = 0                       --初始额外收入
	-- 	PlayerS[PlayerPosition].Arms = 0 						--初始军备
	-- 					  --print(PlayerS[PlayerPosition].Gold)
	-- 					  --print("player"..tostring(i).." gold is  "..PlayerS[PlayerPosition].Gold)
	-- 	PlayerS[PlayerPosition].HireRoad = PlayerPosition 				--玩家默认的雇佣兵进攻路线
	-- 	PlayerS[PlayerPosition].Unit = {}                                                                          --玩家单位
	-- 	PlayerS[PlayerPosition].Farmer = {}                                                                        --玩家采集者单位
	-- 	PlayerS[PlayerPosition].Build = {}                                                                         --玩家的建筑
	-- 	PlayerS[PlayerPosition].NewBuild = {}                                                                      --未出兵的建筑
	-- 	PlayerS[PlayerPosition].Hire = {}                                                                          --玩家的佣兵
	-- 	PlayerS[PlayerPosition].NewHire = {}
	-- 	PlayerS[PlayerPosition].ItemNum = 0                                                                        --可拥有道具数量
	-- 	PlayerS[PlayerPosition].Abhere = false                                                                     --固守状态
	-- 	PlayerS[PlayerPosition].BuildTable = {"Q","W","E","D","F","G","R","X"}
	-- 	PlayerS[PlayerPosition].TechLevel = 0                                                                      --科技等级

	-- 	PlayerS[PlayerPosition].ADLevel = 0 		                                                               --王攻击强化等级
	-- 	PlayerS[PlayerPosition].HLevel = 0 		                                                                   --王生命强化等级
	-- 	PlayerS[PlayerPosition].HRLevel = 0 		                                                               --王回复强化等级

	-- 	PlayerS[PlayerPosition].ranking_score = 0
	-- 	PlayerS[PlayerPosition].ranking_rank = 0
	-- 	PlayerS[PlayerPosition].ranking_total = 0
	-- 	PlayerS[PlayerPosition].ranking_per = 100
	-- 	PlayerS[PlayerPosition].ranking_level = 1
	-- 	PlayerS[PlayerPosition].ranking_appellation = 1
	-- 	--MVP系统
	-- 	PlayerS[PlayerPosition].MVP_DamageToKing = 0						--对王的伤害量
	-- 	PlayerS[PlayerPosition].MVP_BreakGold = 0							--突破总奖励
	-- 	PlayerS[PlayerPosition].MVP_KillCount = 0								--击杀
	-- 	PlayerS[PlayerPosition].MVP_TotalLumer = 0							--总水晶
	-- 	PlayerS[PlayerPosition].MVP_TotalGold = 0							--总金钱

	-- 	PlayerS[PlayerPosition].Abandon = false
	-- 	PlayerS[PlayerPosition].AbandonRound = 0
	-- 	--HEX系统
	-- 	PlayerS[PlayerPosition].hex_Q3 = false

	-- 	--玩家设置
	-- 	PlayerS[PlayerPosition].show_damage_message = false					--显示真实伤害
	-- 	--测试模式
	-- 	if Game:IsTestMode() then
	-- 		PlayerS[PlayerPosition].Lumber = 10000
	-- 		PlayerS[PlayerPosition].Score = 20000
	-- 	end
	-- end

	local playerData = PlayerData:GetPlayerData(PlayerID)
	playerData:SetPlayerPosition(PlayerPosition)
	if Game:IsTestMode() then
		playerData:ModifyGold(99999)
		playerData:ModifyCrystal(99999)
		playerData:SetScore(99999)
	else
		playerData:ModifyGold(700)
		playerData:ModifyCrystal(0)
		playerData:SetScore(0)
	end
	playerData:SetIncome(100, true)
	playerData:SetIncome(0, false)
	playerData:AddFarmer()
	playerData:SetCurFood(1)
	playerData:SetFullFood(16)

	--自定义数据
	playerData:Save("hex_Q3", false)
end


--玩家重连
function CbtfGameMode:OnPlayerReconnected(keys)
	--DeepPrintTable(keys)    --详细打印传递进来的表
	local playerID = keys.PlayerID
	if GameRules:State_Get() >= DOTA_GAMERULES_STATE_HERO_SELECTION then --判断是否进入了游戏
		-- print("Reconnected Player is "..keys.PlayerID)
		local playerData = PlayerData:GetPlayerData(playerID)
		if playerData:GetHero() == nil and PlayerResource:IsValidPlayer(playerID) then
			local hero = CreateHeroForPlayer(GetRandomCommanderName(), PlayerResource:GetPlayer(playerID))
			hero:SetControllableByPlayer(playerID, true)
			playerData:SetHero(hero)
		end

		GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("OnPlayerReconnected"),
			function()
				local build_table = Entities:FindAllByClassname("npc_dota_creature")
				for i,build in pairs(build_table) do
					if build:HasAbility("ability_farmer") then
						local ab = build:FindAbilityByName("ability_farmer")
						build:RemoveModifierByName("modifier_farmer_partic")
						ab:ApplyDataDrivenModifier(build, build, "modifier_farmer_partic", {})
					end
					if build:HasAbility("effect_build_left") then
						local ab = build:FindAbilityByName("effect_build_left")
						build:RemoveModifierByName("modifier_farmer_partic")
						ab:ApplyDataDrivenModifier(build, build, "modifier_farmer_partic", {})
					end
					if build:HasAbility("effect_build_right") then
						local ab = build:FindAbilityByName("effect_build_right")
						build:RemoveModifierByName("modifier_farmer_partic")
						ab:ApplyDataDrivenModifier(build, build, "modifier_farmer_partic", {})
					end
					if build:HasAbility("portal") then
						local ab = build:FindAbilityByName("portal")
						build:RemoveModifierByName("modifier_portal_partic")
						ab:ApplyDataDrivenModifier(build, build, "modifier_portal_partic", {})
					end
				end
			end
		, 2)

		PlayerResource:SetCameraTarget(playerID, nil) --解锁镜头
	end
end

--[[
攻防相克表
攻击类型   混乱 L 普通攻击 B 魔法攻击 M 穿刺攻击 P  攻城攻击 S 英雄 H
护甲类型   重甲 Z  中甲 S   轻甲 W  坚甲城甲 C   无甲 B   英雄 H

技能名字AL 混乱  AB普通  AM魔法 AP穿刺 AS攻城 AH英雄
		DZ 重甲  DS中甲  DW轻甲 DC城甲 DB无甲 DH英雄

]]