if BTFGeneral == nil then
	BTFGeneral = class({})
end

function GetUnitLane(unit)
	local y = unit:GetAbsOrigin().y
	if y <= -4608 and y > -7680 then
		return 4
	end
	if y <= -1536 and y > -4608 then
		return 3
	end
	if y <= 4608 and y > 1536 then
		return 2
	end
	if y <= 7680 and y > 4608 then
		return 1
	end
	return 0
end
function Round(n,s)
	if n then
		local d = n/s
		if d - math.floor(d) >= 0.5 then
			return (math.floor(d)+1)*s
		else
			return math.floor(d)*s
		end
	end
	return 0
end
-----------------------------
------自定义错误信息---------
-----------------------------
function BTFGeneral:ShowError(playerid,msg,soundname)
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerid), "showmessage", {Message=msg,SoundName=soundname})
end


function BTFGeneral:ToTopBarUI(playerid,IncomeNum,Farmer,TechNum,Score,Arms,Lumber,CurFood,FullFood)

	FireGameEvent('UpdateTopBar', {PID = playerid,income=IncomeNum, FarmerNum= Farmer,Tech=TechNum,troops= Score,arms=Arms,source=Lumber,curPopulation=CurFood,Population=FullFood})

end
function BTFGeneral:ToKingBarUI(LeftHP,RightHP)

	FireGameEvent('UpdateTopBar', {health1=LeftHP,health2=RightHP})

end


if PlayerCalc == nil then
	PlayerCalc = class({})
end

function PlayerCalc:GetPlayerByPosition(i_player_position)
	return PlayerS[i_player_position].player
end
function PlayerCalc:SetPlayerIDPosition(i_player_id,i_player_position)
	PlayerCalc[i_player_id]=i_player_position
end
function PlayerCalc:GetPlayerIDByPosition(i_player_position)
	return PlayerS[i_player_position].playerid
end

function PlayerCalc:GetPlayerPositionByID(i_player_id)
	for _, PlayerPosition in pairs( AllPlayers ) do
		if PlayerCalc:GetPlayerIDByPosition(PlayerPosition) == i_player_id then
			return PlayerPosition
		end
	end
	print("Debug:Can't GetPlayerPositionByID for "..i_player_id)
	return nil
end

if AbilityManager == nil then
	AbilityManager = {}
end

function AbilityManager:AddAndSet( u_unit, s_ability_name )
	u_unit:AddAbility(s_ability_name)
	a_ability = u_unit:FindAbilityByName(s_ability_name)
	a_ability:SetLevel(1)
	return a_ability
end

function AbilityManager:GetBuffRegister( u_unit )
	local a_ability = u_unit:FindAbilityByName("buff_register")
	if (a_ability == nil) then
		a_ability = AbilityManager:AddAndSet( u_unit, "buff_register" )
	end
	return a_ability
end

if UnitManager == nil then
	UnitManager = {}
end
UnitManager.AbilityTable={
	npc_unit_Q1_10_BZ={"jn_Q1_10"},
	npc_unit_Q1_20_BZ={"jn_Q1_10","jn_Q1_20"},
	npc_unit_Q1_21_BZ={"jn_Q1_21a","jn_Q1_21b"},
	npc_unit_Q2_10_BZ={"jn_Q2_10"},
	npc_unit_Q2_20_BZ={"jn_Q2_20a","jn_Q2_20b"},
	npc_unit_Q2_21_BZ={"jn_Q2_21a","jn_Q2_21b"},
	npc_unit_Q3_00_BZ={"jn_Q3_00"},
	npc_unit_Q3_10_BZ={"jn_Q3_00","jn_Q3_10"},
	npc_unit_Q3_20_BZ={"jn_Q3_00","jn_Q3_20a","jn_Q3_20b"},
	npc_unit_Q4_10_PZ={"jn_Q4_10"},
	npc_unit_Q4_20_PZ={"jn_Q4_20"},
	npc_unit_Q5_10_PZ={"jn_Q5_10"},
	npc_unit_Q5_20_PZ={"jn_Q5_10","jn_Q5_20"},
	npc_unit_Q5_21_SZ={"jn_Q5_21a","jn_Q5_21b"},
	npc_unit_W1_10_PS={"jn_W1_10"},
	npc_unit_W1_11_SW={"jn_W1_11"},
	npc_unit_W1_20_PS={"jn_W1_20"},
	npc_unit_W1_21_SW={"jn_W1_11"},
	npc_unit_W2_10_PS={"jn_W2_10a","jn_W2_10b"},
	npc_unit_W2_20_PS={"jn_W2_20a","jn_W2_20b"},
	npc_unit_W3_10_PW={"jn_W3_10"},
	npc_unit_W3_20_PW={"jn_W3_20"},
	npc_unit_W4_10_PS={"jn_W4_10"},
	npc_unit_W4_20_PS={"jn_W4_10"},
	npc_unit_W5_10_BS={"jn_W5_10"},
	npc_unit_W5_10_BS={"jn_W5_10"},
	npc_unit_W5_20_BS={"jn_W5_20"},
	npc_unit_W5_21_BS={"jn_W5_21"},
	npc_unit_E1_00_BC={"jn_E1_00"},
	npc_unit_E1_10_SC={"jn_E1_10a","jn_E1_10b"},
	npc_unit_E2_00_BS={"jn_E2_00"},
	npc_unit_E2_10_BS={"jn_E2_10a","jn_E2_10b"},
	npc_unit_G1_00_BZ={"jn_G1_00"},
	npc_unit_G1_10_BZ={"jn_G1_10a","jn_G1_10b"},
	npc_unit_E4_00_SS={"jn_E4_00"},
	npc_unit_E4_10_SS={"jn_E4_00","jn_E4_10"},
	npc_unit_E5_00_BZ={"jn_E5_00"},
	npc_unit_E5_10_BS={"jn_E5_10a","jn_E5_10b"},
	npc_unit_E5_11_BZ={"jn_E5_11a","jn_E5_11b"},
	npc_unit_G2_00_LZ={"jn_G2_00"},
	npc_unit_G2_10_LC={"jn_G2_10a","jn_G2_10b"},
	npc_unit_G2_11_MC={"jn_G2_11"},
	npc_unit_D1_00_MW={"jn_D1_00"},
	npc_unit_D1_10_MW={"jn_D1_10a","jn_D1_10b"},
	npc_unit_D2_00_BZ={"jn_D2_00"},
	npc_unit_D2_10_BZ={"jn_D2_10a","jn_D2_10b"},
	npc_unit_D3_00_MS={"jn_D3_00"},
	npc_unit_D3_10_MS={"jn_D3_10"},
	npc_unit_D4_00_LS={"jn_D4_00"},
	npc_unit_D4_10_LS={"jn_D4_10a","jn_D4_10b","jn_D4_10c"},
	npc_unit_D5_00_MS={"jn_D5_00"},
	npc_unit_D5_10_MS={"jn_D5_10a","jn_D5_10b"},
	npc_unit_D6_00_MB={"jn_D6_00"},
	npc_unit_D6_10_MS={"jn_D6_10a","jn_D6_10b"},
	npc_unit_D6_11_MB={"jn_D6_11a","jn_D6_11b"},
	npc_unit_F1_00_MB={"jn_F1_00"},
	npc_unit_F1_10_MB={"jn_F1_10"},
	npc_unit_F1_20_MH={"jn_F1_10","jn_F1_20"},
	npc_unit_F2_00_MW={"jn_F2_00"},
	npc_unit_F2_10_MW={"jn_F2_10a","jn_F2_10b"},
	npc_unit_F3_00_MW={"jn_F3_00"},
	npc_unit_F3_10_MW={"jn_F3_10a","jn_F3_10b"},
	npc_unit_F3_11_MW={"jn_F3_11"},
	npc_unit_F4_00_PZ={"jn_F4_00"},
	npc_unit_F4_10_PZ={"jn_F4_10"},
	npc_unit_F4_11_SC={"jn_F4_11a","jn_F4_11b"},
	npc_unit_F5_00_PW={"jn_F5_00"},
	npc_unit_F5_10_PW={"jn_F5_10"},
	npc_unit_R1_00_MW={"jn_R1_00"},
	npc_unit_R1_10_MS={"jn_R1_10"},
	npc_unit_R1_11_MW={"jn_R1_11a","jn_R1_11b"},
	npc_unit_R2_00_PW={"jn_R2_00"},
	npc_unit_R2_10_PW={"jn_R2_10"},
	npc_unit_R2_11_MS={"jn_R2_11"},
	npc_unit_R3_00_LW={"jn_R3_00"},
	npc_unit_R3_10_LZ={"jn_R3_00","jn_R3_10"},
	npc_unit_R4_00_MW={"jn_R4_00"},
	npc_unit_R4_10_MZ={"jn_R4_00"},
	npc_unit_R4_11_SW={"jn_R4_11"},
	npc_unit_R5_00_PW={"jn_R5_00"},
	npc_unit_R5_10_PW={"jn_R5_10"},
	npc_unit_D7_00_MW={"jn_D7_00"},
	npc_unit_D7_10_MW={"jn_D7_10"},
	npc_unit_D7_11_BW={"jn_D7_11"},
	npc_unit_Q6_00_BS={"jn_Q6_00"},
	npc_unit_Q6_10_BS={"jn_Q6_10"},
	npc_unit_Q6_20_BS={"jn_Q6_20a","jn_Q6_20b"},
	npc_unit_Q6_21_BZ={"jn_Q6_21"},
	npc_unit_E7_00_BS={"jn_E7_00"},
	npc_unit_E7_10_BS={"jn_E7_10"},
	npc_unit_E7_11_BS={"jn_E7_11a","jn_E7_11b"},
	npc_unit_F6_00_MB={"jn_F6_00"},
	npc_unit_F6_10_MB={"jn_F6_10"},
	npc_unit_F6_11_MH={"jn_F6_11"},
	npc_unit_G3_00_MB={"jn_G3_00a","jn_G3_00b"},
	npc_unit_G3_10_MB={"jn_G3_00a","jn_G3_10"},
	npc_unit_G3_11_MS={"jn_G3_11"},
	npc_unit_G4_00_BZ={"jn_G4_00"},
	npc_unit_G4_10_BZ={"jn_G4_10"},
	npc_unit_G4_11_BZ={"jn_G4_11"},
	npc_unit_G5_00_BZ={"jn_G5_00"},
	npc_unit_G5_10_BZ={"jn_G5_10a","jn_G5_10b"},
	npc_unit_G5_11_LS={"jn_G5_11"},
	npc_unit_X1_00_HH={"jn_X1_00a","jn_X1_00b"},
	npc_unit_X1_10_HH={"jn_X1_10a","jn_X1_10b","jn_X1_10c"},
	npc_unit_X2_00_HH={"jn_X2_00a","jn_X2_00b","jn_X2_00c"},
	npc_unit_X2_10_HH={"jn_X2_10a","jn_X2_10b","jn_X2_10c"},
	npc_unit_X3_00_HH={"jn_X3_00a","jn_X3_00b","jn_X3_00c"},
	npc_unit_X3_10_LH={"jn_X3_10a","jn_X3_10b","jn_X3_10c","jn_X3_10d"},
	npc_unit_X4_00_HH={"jn_X4_00a","jn_X4_00b"},
	npc_unit_X4_10_HH={"jn_X4_10a","jn_X4_10b","jn_X4_10c"},
	npc_unit_X5_00_HH={"jn_X5_00a","jn_X5_00b","jn_X5_00c"},
	npc_unit_X5_10_HH={"jn_X5_10a","jn_X5_00b","jn_X5_10c"},
	npc_unit_Q7_10_BZ={"jn_Q7_10"},
	npc_unit_Q7_20_BZ={"jn_Q7_20"},
	npc_unit_Q7_21_BS={"jn_Q7_21"},
	npc_unit_W6_10_PS={"jn_W6_10"},
	npc_unit_W6_20_PS={"jn_W6_10"},
	npc_unit_W6_21_BS={"jn_W6_21a","jn_W6_21b"},
	npc_unit_W7_10_BS={"jn_W7_10"},
	npc_unit_W7_20_BS={"jn_W7_20"},
	npc_unit_E3_00_SS={"jn_E3_00"},
	npc_unit_E3_10_SS={"jn_E3_00","jn_E3_10"},
	npc_unit_E3_11_BZ={"jn_E3_11a","jn_E3_11b"},
	npc_unit_E6_00_BZ={"jn_E6_00"},
	npc_unit_E6_10_BZ={"jn_E6_10"},
	npc_unit_D8_00_PW={"jn_D8_00"},
	npc_unit_D8_10_PW={"jn_D8_10"},
	npc_unit_R6_00_MS={"jn_R6_00"},
	npc_unit_R6_10_MS={"jn_R6_10"},
	npc_unit_R6_11_BZ={"jn_R6_11a","jn_R6_11b"},
	npc_unit_Q8_10_BC={"jn_Q8_10"},
	npc_unit_Q8_20_BC={"jn_Q8_20"},
	npc_unit_F7_00_MS={"jn_F7_00"},
	npc_unit_F7_10_MS={"jn_F7_00","jn_F7_10"},
	npc_unit_F8_00_MW={"jn_F8_00"},
	npc_unit_F8_10_MW={"jn_F8_10a","jn_F8_10b"},
	npc_unit_G6_00_MS={"jn_G6_00"},
	npc_unit_G6_10_MS={"jn_G6_10a","jn_G6_10b"},
	npc_unit_G6_11_MS={"jn_G6_11a","jn_G6_11b"},
	npc_unit_R7_00_BZ={"jn_R7_00"},
	npc_unit_R7_10_BZ={"jn_R7_00","jn_R7_10"},
	npc_unit_F9_00_MW={"jn_F9_00"},
	npc_unit_F9_10_MW={"jn_F9_00","jn_F9_10"},
	npc_unit_F9_11_MW={"jn_F9_11"},
	npc_unit_X6_00_HH={"jn_X6_00a","jn_X6_00b","jn_X6_00c"},
	npc_unit_X6_10_HH={"jn_X6_10a","jn_X6_10b","jn_X6_10c"},
	npc_unit_X7_00_LH={"jn_X7_00a","jn_X7_00b"},
	npc_unit_X7_10_LH={"jn_X7_10a","jn_X7_10b","jn_X7_10c"},
	npc_unit_X8_00_LH={"jn_X8_00a"},
	npc_unit_X8_10_LH={"jn_X8_10a"},
	npc_unit_G7_00_BS={"jn_G7_00",},
	npc_unit_G7_10_BS={"jn_G7_10",},
	npc_unit_G7_11_BS={"jn_G7_11a","jn_G7_11b",},
	npc_unit_G8_00_BS={"jn_G8_00",},
	npc_unit_G8_10_BS={"jn_G8_10a","jn_G8_10b",},
	npc_unit_G8_11_MZ={"jn_G8_11a","jn_G8_11b",},
	npc_unit_armament_36_BZ={"necronomicon_warrior_last_will"},
	npc_hire_1_BS={"jn_hire_1"},
	npc_hire_2_PW={"jn_hire_2"},
	npc_hire_3_BZ={"jn_hire_3"},
	npc_hire_4_MZ={"jn_hire_4"},
	npc_hire_5_SC={"jn_hire_5"},
	npc_hire_6_PW={"jn_hire_6"},
	npc_hire_7_LZ={"jn_hire_7"},
	npc_hire_8_PW={"jn_hire_8"},
	npc_hire_9_BB={"jn_hire_9a","jn_hire_9b"},
	npc_hire_10_HZ={"jn_hire_10a","jn_hire_10b"},
	npc_hire_11_LS={"jn_hire_11a","jn_hire_11b","jn_hire_11c"},
	npc_hire_12_HH={"jn_hire_12a","jn_hire_12b","jn_hire_12c"},
	npc_hire_10_HZ={"jn_hire_10a","jn_hire_10b"},
	npc_general_1_LH={"jn_general_1"},
	npc_general_2_LH={"jn_general_2","jn_king_40"},
	npc_general_3_LH={"jn_general_3"},
	npc_general_4_LH={"jn_general_4","jn_king_60"},
	npc_general_5_LH={"jn_general_5"},
	npc_general_6_LH={"jn_general_6"},
}
function UnitManager:GetTypeFromName( s_unit_name )
	return string.sub( s_unit_name , -8, -4)
end

function UnitManager:GetAttackTypeFromName( s_unit_name )
	return string.sub( s_unit_name , -2, -2)
end
function UnitManager:IsHire(u_unit)
	if u_unit then
		if string.sub(u_unit:GetUnitName(),5,8) == "hire" then
			return true
		end
	end
	return false
end
function UnitManager:GetDefendTypeFromName( s_unit_name )
	return string.sub( s_unit_name , -1, -1)
end
function UnitManager:AddDefaultAbility( u_unit )
	local s_unit_name = u_unit:GetUnitName()
	for n,v in pairs(UnitManager.AbilityTable) do
		if n == s_unit_name then
			for i,abilityname in pairs(UnitManager.AbilityTable[s_unit_name]) do
				AbilityManager:AddAndSet( u_unit, abilityname)
			end
			break
		end
	end
	if s_unit_name == "npc_unit_Q3_20_BZ" then
		local PlayerPosition = PlayerCalc:GetPlayerPositionByID(u_unit:GetPlayerOwnerID())
		if PlayerS[PlayerPosition].hex_Q3 == true then
			local ab = AbilityManager:AddAndSet(u_unit, "jn_Q3_20z")
			ab:ApplyDataDrivenModifier(u_unit, u_unit, "modifier_jn_Q3_20z", {})
		end
	end
	AbilityManager:AddAndSet(u_unit, "ability_dummy")
end
function UnitManager:CreateUnitByName(sUnitName, vLocation, bFindClearSpace, iPlayerID, iTeamNumber)
	local hero = PlayerS[PlayerCalc:GetPlayerPositionByID(iPlayerID)].Hero
	local unit = CreateUnitByName(sUnitName, vLocation, bFindClearSpace, hero, hero, iTeamNumber)
	unit:SetOwner(hero)
	return unit
end
--从建筑创建单位
function UnitManager:CreateUnitByBuilding( u_building , s_ability_name)
	--local s_building_name = u_building:GetUnitName() 
	
	--local s_unit_name = "npc_unit_" .. string.sub(s_building_name, 11, -1) 
	local s_unit_name = u_building:GetUnitName() 
	local s_unit_type = string.sub(s_unit_name, -8, -4)
	local v_unit_point = u_building:GetAbsOrigin() 
	local i_playerID = u_building:GetPlayerOwnerID()
	local i_teamnumber = PlayerResource:GetTeam(i_playerID) 
	local PlayerPosition = PlayerCalc:GetPlayerPositionByID(i_playerID)

	local u_unit = UnitManager:CreateUnitByName( s_unit_name, v_unit_point, true, i_playerID, i_teamnumber)

	AandDSystem(u_unit)

	u_unit:AddNewModifier(nil, nil, "modifier_phased", {duration=0.3})
	local v_order = nil

	if i_teamnumber == DOTA_TEAM_GOODGUYS then
		v_order = Vector( 8500, 0, 0 )+v_unit_point
	end
	if i_teamnumber == DOTA_TEAM_BADGUYS then
		v_order = Vector( -8500, 0, 0 )+v_unit_point
	end
	v_order.x = math.min(v_order.x,6400)
	v_order.x = math.max(v_order.x,-6400)
	local t_order = 
		{                                        --发送攻击指令
			UnitIndex = u_unit:entindex(), 
			OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
			TargetIndex = nil, 
			AbilityIndex = 0, 
			Position = v_order, 
			Queue = 0 
		}
	u_unit:SetContextThink(DoUniqueString("order_later"),
		function()
			ExecuteOrderFromTable(t_order)
			if PlayerS[PlayerPosition].Unit then--BUG
				table.insert(PlayerS[PlayerPosition].Unit,u_unit)
			end
		end
	, 0)
	--军备技能
	local item_armament_7
	local item_armament_7_hero
	local item_armament_8
	local item_armament_8_hero
	local item_armament_17
	local item_armament_17_hero
	local item_armament_18
	local item_armament_18_hero
	local item_armament_32
	local item_armament_32_hero
	local item

		local hero = PlayerS[PlayerPosition].Hero
		if hero:HasItemInInventory("item_armament_7") or hero:HasItemInInventory("item_armament_8") or hero:HasItemInInventory("item_armament_17") or hero:HasItemInInventory("item_armament_18") or hero:HasItemInInventory("item_armament_32") then
			for i=0,5,1 do
				item = hero:GetItemInSlot(i)
				if item then
					if item:GetName() == "item_armament_7" then
						item_armament_7_hero = hero
						item_armament_7 = item
					end
					if item:GetName() == "item_armament_8" then
						item_armament_8_hero = hero
						item_armament_8 = item
					end
					if item:GetName() == "item_armament_17" then
						item_armament_17_hero = hero
						item_armament_17 = item
					end
					if item:GetName() == "item_armament_18" then
						item_armament_18_hero = hero
						item_armament_18 = item
					end
					if item:GetName() == "item_armament_32" then
						item_armament_32_hero = hero
						item_armament_32 = item
					end
				end
			end
		end
		local n
		local nmax
		if i_teamnumber == DOTA_TEAM_GOODGUYS then
			n = 1
			nmax = 4
		end
		if i_teamnumber == DOTA_TEAM_BADGUYS then
			n = 5
			nmax = 8
		end
		for position=n,nmax,1 do
			hero = PlayerS[position].Hero
			if hero then
				if hero:HasItemInInventory("item_armament_7_level2") or hero:HasItemInInventory("item_armament_8_level2") or hero:HasItemInInventory("item_armament_17_level2") or hero:HasItemInInventory("item_armament_18_level2") or hero:HasItemInInventory("item_armament_32_level2") then
					for i=0,5,1 do
						item = hero:GetItemInSlot(i)
						if item then
							if item:GetName() == "item_armament_7_level2" then
								item_armament_7_hero = hero
								item_armament_7 = item
							end
							if item:GetName() == "item_armament_8_level2" then
								item_armament_8_hero = hero
								item_armament_8 = item
							end
							if item:GetName() == "item_armament_17_level2" then
								item_armament_17_hero = hero
								item_armament_17 = item
							end
							if item:GetName() == "item_armament_18_level2" then
								item_armament_18_hero = hero
								item_armament_18 = item
							end
							if item:GetName() == "item_armament_32_level2" then
								item_armament_32_hero = hero
								item_armament_32 = item
							end
						end
					end
				end
			end
		end

	if item_armament_7 then
		if RandomInt(0,100) <= item_armament_7:GetSpecialValueFor("chance") then
			item_armament_7:ApplyDataDrivenModifier(item_armament_7_hero, u_unit, "modifier_armament_7_buff", {})
		end
	end
	if item_armament_8 then
		if RandomInt(0,100) <= item_armament_8:GetSpecialValueFor("chance") then
			item_armament_8:ApplyDataDrivenModifier(item_armament_8_hero, u_unit, "modifier_armament_8_buff", {})
		end
	end
	if item_armament_17 then
		if RandomInt(0,100) <= item_armament_17:GetSpecialValueFor("chance") then
			item_armament_17:ApplyDataDrivenModifier(item_armament_17_hero, u_unit, "modifier_armament_17_buff", {})
		end
	end
	if item_armament_18 then
		if RandomInt(0,100) <= item_armament_18:GetSpecialValueFor("chance") then
			item_armament_18:ApplyDataDrivenModifier(item_armament_18_hero, u_unit, "modifier_armament_18_buff", {})
		end
	end
	if item_armament_32 then
		if RandomInt(0,100) <= item_armament_32:GetSpecialValueFor("chance") then
			item_armament_32:ApplyDataDrivenModifier(item_armament_32_hero, u_unit, "modifier_armament_32_buff", {})
		end
	end

	AbilityManager:AddAndSet( u_unit, "buff_register" )
	if not s_ability_name then
		if u_unit:HasAbility("jn_G3_00b") then
			UnitManager:CreateUnitByBuilding(u_building,"jn_G3_00b")
		end
		if u_unit:HasAbility("jn_Q7_21") then
			UnitManager:CreateUnitByBuilding(u_building,"jn_Q7_21")
			UnitManager:CreateUnitByBuilding(u_building,"jn_Q7_21")
		end
	end
	return u_unit
end
--召唤单位
function UnitManager:SummonUnit(u_caster,u_unit)
	local i_playerID = u_caster:GetPlayerOwnerID()
	local s_unit_name = u_unit:GetUnitName()
	local v_unit_point = u_unit:GetAbsOrigin()
	local s_unit_type = string.sub(s_unit_name, -8, -4)
	local i_teamnumber = PlayerResource:GetTeam(i_playerID)
	local PlayerPosition = PlayerCalc:GetPlayerPositionByID(i_playerID)

	u_unit:SetOwner(PlayerS[PlayerPosition].Hero)
	u_unit:SetControllableByPlayer(-1,true)

	AandDSystem(u_unit)

	AddLabel(u_unit,"SummonUnit")--标记为召唤单位
	u_unit:AddNewModifier(nil, nil, "modifier_phased", {duration=0.3})
	local v_order = nil

	if i_teamnumber == DOTA_TEAM_GOODGUYS then
		v_order = Vector( 9500, 0, 0 )+v_unit_point
	end
	if i_teamnumber == DOTA_TEAM_BADGUYS then
		v_order = Vector( -9500, 0, 0 )+v_unit_point
	end
	v_order.x = math.min(v_order.x,5120)
	v_order.x = math.max(v_order.x,-5120)
	local t_order = 
		{                                        --发送攻击指令
			UnitIndex = u_unit:entindex(), 
			OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
			TargetIndex = nil, 
			AbilityIndex = 0, 
			Position = v_order, 
			Queue = 0 
		}
	u_unit:SetContextThink(DoUniqueString("order_later"),
		function()
			ExecuteOrderFromTable(t_order)
			if PlayerS[PlayerPosition].Unit then
				table.insert(PlayerS[PlayerPosition].Unit,u_unit)
			end
		end
	, 0)

	AbilityManager:AddAndSet( u_unit, "buff_register" )
	return u_unit
end
--购买雇佣兵
UnitManager.HireNameTable={
	item_hire_1="npc_hire_1_BS",
	item_hire_2="npc_hire_2_PW",
	item_hire_3="npc_hire_3_BZ",
	item_hire_4="npc_hire_4_MZ",
	item_hire_5="npc_hire_5_SC",
	item_hire_6="npc_hire_6_PW",
	item_hire_7="npc_hire_7_LZ",
	item_hire_8="npc_hire_8_PW",
	item_hire_9="npc_hire_9_BB",
	item_hire_10="npc_hire_10_HZ",
	item_hire_11="npc_hire_11_LS",
	item_hire_12="npc_hire_12_HH",
}
function UnitManager:GetHireNameByItemName(s_item)
	if s_item then
		local s_hirename = UnitManager.HireNameTable[s_item]
		if s_hirename then
			return s_hirename
		end
	end
	return nil
end
function UnitManager:HireUnit(i_playerID,s_item,position)
	local s_unit_name = UnitManager:GetHireNameByItemName(s_item)
	local s_unit_type = string.sub(s_unit_name, -8, -4)
	local i_teamnumber = PlayerResource:GetTeam(i_playerID)
	local PlayerPosition = PlayerCalc:GetPlayerPositionByID(i_playerID)
	local v_unit_point = Entities:FindByName(nil, "hire_"..tostring(position)):GetAbsOrigin()+RandomVector(150)

	local u_unit = UnitManager:CreateUnitByName( s_unit_name,v_unit_point, true, i_playerID, i_teamnumber)

	AandDSystem(u_unit)

	u_unit:AddNewModifier(nil, nil, "modifier_phased", {duration=0.3})

	u_unit:SetContextThink(DoUniqueString("order_later"),
		function()
			if PlayerS[position].NewHire then
				table.insert(PlayerS[position].NewHire,u_unit)
			end
			if PlayerS[PlayerPosition].Hire then
				table.insert(PlayerS[PlayerPosition].Hire,u_unit)
			end
		end
	,0)

	AbilityManager:AddAndSet( u_unit, "buff_register" )
	AbilityManager:AddAndSet( u_unit, "kexuanmajia" )
	return u_unit
end
--征召勤王大将
UnitManager.GeneralNameTable={
	general_1="npc_general_1_LH",
	general_2="npc_general_2_LH",
	general_3="npc_general_3_LH",
	general_4="npc_general_4_LH",
	general_5="npc_general_5_LH",
	general_6="npc_general_6_LH",
}
function UnitManager:GetGeneralNameByItemName(s_item)
	if s_item then
		local s_generalname = UnitManager.GeneralNameTable[s_item]
		if s_generalname then
			return s_generalname
		end
	end
	return nil
end
function UnitManager:CreateGeneral(i_playerID,s_item)
	local s_unit_name = UnitManager:GetGeneralNameByItemName(s_item)
	local s_unit_type = string.sub(s_unit_name, -8, -4)
	local i_teamnumber = PlayerResource:GetTeam(i_playerID)
	local PlayerPosition = PlayerCalc:GetPlayerPositionByID(i_playerID)
	local x = RandomInt(1,7)
	local v_unit_point
	if i_teamnumber == DOTA_TEAM_GOODGUYS then
		v_unit_point = Entities:FindByName(nil,    "l_portal"..tostring(x)):GetAbsOrigin()
	end
	if i_teamnumber == DOTA_TEAM_BADGUYS then
		v_unit_point = Entities:FindByName(nil,    "r_portal"..tostring(x)):GetAbsOrigin()
	end

	local u_unit = UnitManager:CreateUnitByName( s_unit_name,v_unit_point, true, i_playerID, i_teamnumber)

	AandDSystem(u_unit)

	if s_item == "general_1" then
		if i_teamnumber == DOTA_TEAM_GOODGUYS then
			AbilityManager:AddAndSet( u_unit, "jn_king_20_left" )
		end
		if i_teamnumber == DOTA_TEAM_BADGUYS then
			AbilityManager:AddAndSet( u_unit, "jn_king_20_right" )
		end
	end
	u_unit:AddNewModifier(nil, nil, "modifier_phased", {duration=0.3})
	local v_order = nil

	if i_teamnumber == DOTA_TEAM_GOODGUYS then
		v_order = Vector( 8500, 0, 0 )+v_unit_point
	end
	if i_teamnumber == DOTA_TEAM_BADGUYS then
		v_order = Vector( -8500, 0, 0 )+v_unit_point
	end
	v_order.x = math.min(v_order.x,5120)
	v_order.x = math.max(v_order.x,-5120)
	local t_order = 
		{
			UnitIndex = u_unit:entindex(), 
			OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
			TargetIndex = nil, 
			AbilityIndex = 0, 
			Position = v_order, 
			Queue = 0 
		}
	u_unit:SetContextThink(DoUniqueString("order_later"),
		function()
			ExecuteOrderFromTable(t_order)
			if PlayerS[PlayerPosition].Unit then
				table.insert(PlayerS[PlayerPosition].Unit,u_unit)
			end
		end
	, 0)

	AbilityManager:AddAndSet( u_unit, "buff_register" )
	return u_unit
end

if DamageManager == nil then
	DamageManager = {}
end
--技能伤害，即技能的伤害
function DamageManager:SpellDamage( caster, target, damage)
	if caster == nil or target == nil or damage == nil then
		return
	end
	if target:HasModifier("modifier_jn_X5_00c_buff") then
		if target:GetContext("jn_X5_00c_absorb") > 0 then
			local absorb = target:GetContext("jn_X5_00c_absorb")
			absorb = absorb - damage
			target:SetContextNum("jn_X5_00c_absorb", absorb, 0)
			damage = math.max(0,-absorb)
			if absorb <= 0 then
				target:RemoveModifierByName("modifier_jn_X5_00c_buff")
			end
		end
	end
	if target:HasModifier("modifier_jn_X5_10c_buff") then
		if target:GetContext("jn_X5_10c_absorb") > 0 then
			local absorb = target:GetContext("jn_X5_10c_absorb")
			absorb = absorb - damage
			target:SetContextNum("jn_X5_10c_absorb", absorb, 0)
			damage = math.max(0,-absorb)
			if absorb <= 0 then
				target:RemoveModifierByName("modifier_jn_X5_10c_buff")
			end
		end
	end
	if damage > 0 then
		local damageTable = 
		{
			victim = target,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}
		ApplyDamage(damageTable)
	end
end
function CalculateArmorResistance(target)
	local armor = target:GetPhysicalArmorValue()
	if armor >= 0 then
		return (armor*0.06)/(1+armor*0.06)
	else
		return (armor*0.06)/(1-armor*0.06)
	end
end
function DamageManager:CustonDamage( caster, target, a_type, base_damage, isattack )

	local pure_damage = base_damage
	local damageTable
	if isattack then
		damageTable = 
		{
			victim = target,
			attacker = caster,
			damage = pure_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
	else
		local damaged_unit_AandD = AandDSystem:GetAandDSystem(target)
		local source_unit_AandD = AandDSystem:GetAandDSystem(caster)
		local resistance = damaged_unit_AandD:GetAttacktypeResistance(source_unit_AandD:GetAttackType())
		damageTable = 
		{
			victim = target,
			attacker = caster,
			damage = pure_damage*(1-CalculateArmorResistance(target))*(1-resistance),
			damage_type = DAMAGE_TYPE_PURE,
		}
	end
	ApplyDamage(damageTable)
end