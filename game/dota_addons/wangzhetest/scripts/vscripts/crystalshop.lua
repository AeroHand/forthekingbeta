function ItemPurchased(index,keys)
	--for i,v in pairs(keys) do
		--print(tostring(i).."="..tostring(v))
	--end
	--[[这里是UI传递过来的表内容
	id  该变量不能改动也没用
	ItemName  被购买的物品名字
	GoldCost  物品所要花费的金钱
	LumberCost  物品所要花费的水晶
	NeedScore  物品所需兵力
	Income 增加收入
	Stock 库存
	Way  雇佣兵路线，0为默认位置，总共有4条路线所对应的值为1、2、3、4
	]]--
	local pid = keys.PlayerID
	local PlayerPosition = PlayerCalc:GetPlayerPositionByID(pid)
	local itemname = keys.ItemName
	local GoldCost = keys.GoldCost
	local LumberCost = keys.LumberCost
	local NeedScore = keys.NeedScore
	local Stock = keys.Stock
	local Gold = PlayerResource:GetGold(pid)
	local Lumber = PlayerS[PlayerPosition].Lumber
	local Score = PlayerS[PlayerPosition].Score
	local hero = PlayerS[PlayerPosition].Hero
	local way = keys.Way
	if itemname == "general_1" or itemname == "general_2" or itemname == "general_3" or itemname == "general_4" or itemname == "general_5" or itemname == "general_6" then
		if Lumber >= LumberCost and Gold >= GoldCost and Score >= NeedScore and Stock > 0 and not GameRules:IsGamePaused() then
			PlayerResource:SetGold(pid,Gold-GoldCost, false)
			PlayerS[PlayerPosition].Lumber = Lumber - LumberCost
			PlayerS[PlayerPosition].Income = PlayerS[PlayerPosition].Income + keys.Income
			UnitManager:CreateGeneral(pid,itemname)
			EmitGlobalSound("Hero_LegionCommander.Duel")
			BTFGeneral:ShowError(pid,"","General.Buy")
			local message = "#Team1GeneralMessage"
			if PlayerResource:GetTeam(pid) == DOTA_TEAM_BADGUYS then
				message = "#Team2GeneralMessage"
			end
			GameRules:SendCustomMessage(message, -1, 0)
			if PlayerResource:IsValidPlayer(pid) then
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "GeneralSuccess", {id=keys.id})
			end
		else
			if Stock <= 0 then
				BTFGeneral:ShowError(pid,"#NoStock","General.NoGold")
			elseif Gold < GoldCost then
				BTFGeneral:ShowError(pid,"#NoEnoughMoney","General.NoGold")
			elseif Lumber < LumberCost then
				BTFGeneral:ShowError(pid,"#NoEnoughLumber","General.NoGold")
			elseif Score < NeedScore then
				BTFGeneral:ShowError(pid,"#NoEnoughScore5000","General.NoGold")
			end
		end
		return
	end
	if way == 0 then
		way = PlayerPosition
	else
		if PlayerResource:GetTeam(pid) == DOTA_TEAM_BADGUYS then
			way = way + 4
		end
	end
	if Lumber >= LumberCost and Gold >= GoldCost and Score >= NeedScore and Stock > 0 and not GameRules:IsGamePaused() and PlayerS[way].NewHire then
		PlayerResource:SetGold(pid,Gold-GoldCost, false)
		PlayerS[PlayerPosition].Lumber = Lumber - LumberCost
		PlayerS[PlayerPosition].Income = PlayerS[PlayerPosition].Income + keys.Income
		UnitManager:HireUnit(pid,itemname,way)
		BTFGeneral:ShowError(pid,"","General.Buy")
		if PlayerResource:IsValidPlayer(pid) then
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "HireSuccess", {id=keys.id})
		end
	else
		if not PlayerS[way].NewHire then
			BTFGeneral:ShowError(pid,"#InvalidWay","General.NoGold")
		elseif Stock <= 0 then
			BTFGeneral:ShowError(pid,"#NoStock","General.NoGold")
		elseif Gold < GoldCost then
			BTFGeneral:ShowError(pid,"#NoEnoughMoney","General.NoGold")
		elseif Lumber < LumberCost then
			BTFGeneral:ShowError(pid,"#NoEnoughLumber","General.NoGold")
		elseif Score < NeedScore then
			BTFGeneral:ShowError(pid,"#NoEnoughScore","General.NoGold")
		end
	end
end
function BossLevelup(index,keys)
	local pid = keys.PlayerID
	local PlayerPosition = PlayerCalc:GetPlayerPositionByID(pid)
	local team = PlayerResource:GetTeam(pid)
	local LumberCost = keys.LumberCost
	local Lumber = PlayerS[PlayerPosition].Lumber
	local bool = true
	if Lumber >= LumberCost and not GameRules:IsGamePaused() then
		if keys.LevelUpType == "attackdamage" then
			if team == DOTA_TEAM_GOODGUYS then
				if king_left:GetContext("attackdamagelevel") < 20 then
					PlayerS[PlayerPosition].ADLevel = PlayerS[PlayerPosition].ADLevel + 1
					king_left:SetContextNum("attackdamagelevel", king_left:GetContext("attackdamagelevel")+1, 0)
				else
					bool = false
					BTFGeneral:ShowError(pid,"#BossADLevelIsMax","General.NoGold")
				end
			end
			if team == DOTA_TEAM_BADGUYS then
				if king_right:GetContext("attackdamagelevel") < 20 then
					PlayerS[PlayerPosition].ADLevel = PlayerS[PlayerPosition].ADLevel + 1
					king_right:SetContextNum("attackdamagelevel", king_right:GetContext("attackdamagelevel")+1, 0)
				else
					bool = false
					BTFGeneral:ShowError(pid,"#BossADLevelIsMax","General.NoGold")
				end
			end
		end
		if keys.LevelUpType == "health" then
			if team == DOTA_TEAM_GOODGUYS then
				if king_left:GetContext("healthlevel") < 20 then
					PlayerS[PlayerPosition].HLevel = PlayerS[PlayerPosition].HLevel + 1
					king_left:SetContextNum("healthlevel", king_left:GetContext("healthlevel")+1, 0)
				else
					bool = false
					BTFGeneral:ShowError(pid,"#BossHLevelIsMax","General.NoGold")
				end
			end
			if team == DOTA_TEAM_BADGUYS then
				if king_right:GetContext("healthlevel") < 20 then
					PlayerS[PlayerPosition].HLevel = PlayerS[PlayerPosition].HLevel + 1
					king_right:SetContextNum("healthlevel", king_right:GetContext("healthlevel")+1, 0)
				else
					bool = false
					BTFGeneral:ShowError(pid,"#BossHLevelIsMax","General.NoGold")
				end
			end
		end
		if keys.LevelUpType == "healthregen" then
			if team == DOTA_TEAM_GOODGUYS then
				if king_left:GetContext("healthregenlevel") < 20 then
					PlayerS[PlayerPosition].HRLevel = PlayerS[PlayerPosition].HRLevel + 1
					king_left:SetContextNum("healthregenlevel", king_left:GetContext("healthregenlevel")+1, 0)
				else
					bool = false
					BTFGeneral:ShowError(pid,"#BossHRLevelIsMax","General.NoGold")
				end
			end
			if team == DOTA_TEAM_BADGUYS then
				if king_right:GetContext("healthregenlevel") < 20 then
					PlayerS[PlayerPosition].HRLevel = PlayerS[PlayerPosition].HRLevel + 1
					king_right:SetContextNum("healthregenlevel", king_right:GetContext("healthregenlevel")+1, 0)
				else
					bool = false
					BTFGeneral:ShowError(pid,"#BossHRLevelIsMax","General.NoGold")
				end
			end
		end
		if bool then
			PlayerS[PlayerPosition].Lumber = Lumber - LumberCost
			PlayerS[PlayerPosition].Income = PlayerS[PlayerPosition].Income + keys.Income
			BTFGeneral:ShowError(pid,"#BossLevelUpSuccess","General.Buy")
		end
	else
		if GameRules:IsGamePaused() then
			BTFGeneral:ShowError(pid,"","General.NoGold")
		elseif Lumber < LumberCost then
			BTFGeneral:ShowError(pid,"#NoEnoughLumber","General.NoGold")
		end
	end
end
function FilterUnit(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if target:GetUnitName() == "npc_king_left_LC" or target:GetUnitName() == "npc_king_right_LC" or target:GetUnitName() == "npc_unit_huweidui_left_BZ" or target:GetUnitName() == "npc_unit_huweidui_right_BZ" or target:GetUnitName() == "npc_general_1_LH" or target:GetUnitName() == "npc_general_2_LH" or target:GetUnitName() == "npc_general_3_LH" or target:GetUnitName() == "npc_general_4_LH" or target:GetUnitName() == "npc_general_5_LH" or target:GetUnitName() == "npc_general_6_LH" then
		ab:ApplyDataDrivenModifier(caster, target, "modifier_BossLevelup_aura_buff", nil)
	end
end
function UpdateModifier(keys)
	if GameRules:State_Get() < DOTA_GAMERULES_STATE_POST_GAME then
		local caster = keys.caster
		local target = keys.target
		local adlevel = caster:GetContext("attackdamagelevel")
		local hlevel = caster:GetContext("healthlevel")
		local hrlevel = caster:GetContext("healthregenlevel")
		local level = adlevel+hlevel+hrlevel
		local attackdamage = 0
		local health = 0
		local healthregen = 0
		target:SetModifierStackCount("modifier_BossLevelup_aura_buff", caster, level)
		if target:GetUnitName() == "npc_king_left_LC" or target:GetUnitName() == "npc_king_right_LC" then
			attackdamage = adlevel*10
			health = hlevel*350
			healthregen = hrlevel*3.5
		elseif target:GetUnitName() == "npc_unit_huweidui_left_BZ" or target:GetUnitName() == "npc_unit_huweidui_right_BZ" then
			attackdamage = adlevel*1
			health = hlevel*35
			healthregen = hrlevel*0.35
		elseif target:GetUnitName() == "npc_general_1_LH" or target:GetUnitName() == "npc_general_2_LH" or target:GetUnitName() == "npc_general_3_LH" or target:GetUnitName() == "npc_general_4_LH" or target:GetUnitName() == "npc_general_5_LH" or target:GetUnitName() == "npc_general_6_LH" then
			attackdamage = adlevel*2
			health = hlevel*70
			healthregen = hrlevel*0.7
		end
		if target:GetContext("attackdamage") == nil then
			target:SetContextNum("attackdamage",0,0)
		end
		if attackdamage ~= target:GetContext("attackdamage") then
			target:SetBaseDamageMax(target:GetBaseDamageMax()+attackdamage-target:GetContext("attackdamage"))
			target:SetBaseDamageMin(target:GetBaseDamageMin()+attackdamage-target:GetContext("attackdamage"))
			target:SetContextNum("attackdamage", attackdamage, 0)
		end

		if target:GetContext("health") == nil then
			target:SetContextNum("health",0,0)
		end
		if health ~= target:GetContext("health") then
			local healthpercent = target:GetHealthPercent()
			target:SetBaseMaxHealth(target:GetBaseMaxHealth()+health-target:GetContext("health"))
			target:SetMaxHealth(target:GetMaxHealth()+health-target:GetContext("health"))
			target:SetHealth(target:GetMaxHealth()*healthpercent*0.01)
			target:SetContextNum("health", health, 0)
		end

		if target:GetContext("healthregen") == nil then
			target:SetContextNum("healthregen",0,0)
		end
		if healthregen ~= target:GetContext("healthregen") then
			target:SetBaseHealthRegen(target:GetBaseHealthRegen()+healthregen-target:GetContext("healthregen"))
			target:SetContextNum("healthregen", healthregen, 0)
		end
	end
end
