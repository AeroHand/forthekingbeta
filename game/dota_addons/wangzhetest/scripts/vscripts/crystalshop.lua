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
	local playerID = keys.PlayerID
	local playerData = PlayerData:GetPlayerData(playerID)
	local itemname = keys.ItemName
	local goldCost = keys.GoldCost
	local crystalCost = keys.LumberCost
	local needScore = keys.NeedScore
	local addIncome = keys.Income
	local Stock = keys.Stock
	local gold = playerData:GetGold()
	local crystal = playerData:GetCrystal()
	local Score = playerData:GetScore()
	local hero = playerData:GetHero()
	local line = keys.Way
	if itemname == "general_1" or itemname == "general_2" or itemname == "general_3" or itemname == "general_4" or itemname == "general_5" or itemname == "general_6" then
		if crystal >= crystalCost and gold >= goldCost and Score >= needScore and Stock > 0 and not GameRules:IsGamePaused() then
			playerData:ModifyGold(-goldCost)
			playerData:ModifyCrystal(-crystalCost)
			playerData:ModifyIncome(addIncome)

			UnitManager:CreateGeneral(playerID,itemname)
			EmitGlobalSound("Hero_LegionCommander.Duel")
			BTFGeneral:ShowError(playerID,"","General.Buy")

			local message = "#Team1GeneralMessage"
			if PlayerResource:GetTeam(playerID) == DOTA_TEAM_BADGUYS then
				message = "#Team2GeneralMessage"
			end
			GameRules:SendCustomMessage(message, -1, 0)

			if PlayerResource:IsValidPlayer(playerID) then
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "GeneralSuccess", {id=keys.id})
			end
		else
			if Stock <= 0 then
				BTFGeneral:ShowError(playerID,"#NoStock","General.NoGold")
			elseif gold < goldCost then
				BTFGeneral:ShowError(playerID,"#NoEnoughMoney","General.NoGold")
			elseif crystal < crystalCost then
				BTFGeneral:ShowError(playerID,"#NoEnoughLumber","General.NoGold")
			elseif Score < needScore then
				BTFGeneral:ShowError(playerID,"#NoEnoughScore5000","General.NoGold")
			end
		end
		return
	end
	if line == 0 then
		line = playerData:GetPlayerPosition()
	else
		if PlayerResource:GetTeam(playerID) == DOTA_TEAM_BADGUYS then
			line = line + 4
		end
	end
	local _playerData = PlayerData:GetPlayerDataByPosition(line)
	if crystal >= crystalCost and gold >= goldCost and Score >= needScore and Stock > 0 and not GameRules:IsGamePaused() and _playerData then
		playerData:ModifyGold(-goldCost)
		playerData:ModifyCrystal(-crystalCost)
		playerData:ModifyIncome(addIncome)

		UnitManager:HireUnit(playerID,itemname,line)
		BTFGeneral:ShowError(playerID,"","General.Buy")
		if PlayerResource:IsValidPlayer(playerID) then
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "HireSuccess", {id=keys.id})
		end
	else
		if not _playerData then
			BTFGeneral:ShowError(playerID,"#InvalidWay","General.NoGold")
		elseif Stock <= 0 then
			BTFGeneral:ShowError(playerID,"#NoStock","General.NoGold")
		elseif gold < goldCost then
			BTFGeneral:ShowError(playerID,"#NoEnoughMoney","General.NoGold")
		elseif crystal < crystalCost then
			BTFGeneral:ShowError(playerID,"#NoEnoughLumber","General.NoGold")
		elseif Score < needScore then
			BTFGeneral:ShowError(playerID,"#NoEnoughScore","General.NoGold")
		end
	end
end
function BossLevelup(index,keys)
	local playerID = keys.PlayerID
	local playerData = PlayerData:GetPlayerData(playerID)
	local team = PlayerResource:GetTeam(playerID)
	local crystalCost = keys.LumberCost
	local crystal = playerData:GetCrystal()
	local addIncome = keys.Income
	local bool = true
	if crystal >= crystalCost and not GameRules:IsGamePaused() then
		if keys.LevelUpType == "attackdamage" then
			if team == DOTA_TEAM_GOODGUYS then
				if Game:GetLeftADLevel() < 20 then
					playerData:UpgradeADLevel()
					Game:SetLeftADLevel(Game:GetLeftADLevel() + 1)
				else
					bool = false
					BTFGeneral:ShowError(playerID,"#BossADLevelIsMax","General.NoGold")
				end
			end
			if team == DOTA_TEAM_BADGUYS then
				if Game:GetRightADLevel() < 20 then
					playerData:UpgradeADLevel()
					Game:SetRightADLevel(Game:GetRightADLevel() + 1)
				else
					bool = false
					BTFGeneral:ShowError(playerID,"#BossADLevelIsMax","General.NoGold")
				end
			end
		end
		if keys.LevelUpType == "health" then
			if team == DOTA_TEAM_GOODGUYS then
				if Game:GetLeftHLevel() < 20 then
					playerData:UpgradeHLevel()
					Game:SetLeftHLevel(Game:GetLeftHLevel() + 1)
				else
					bool = false
					BTFGeneral:ShowError(playerID,"#BossHLevelIsMax","General.NoGold")
				end
			end
			if team == DOTA_TEAM_BADGUYS then
				if Game:GetRightHLevel() < 20 then
					playerData:UpgradeHLevel()
					Game:SetRightHLevel(Game:GetRightHLevel() + 1)
				else
					bool = false
					BTFGeneral:ShowError(playerID,"#BossHLevelIsMax","General.NoGold")
				end
			end
		end
		if keys.LevelUpType == "healthregen" then
			if team == DOTA_TEAM_GOODGUYS then
				if Game:GetLeftHRLevel() < 20 then
					playerData:UpgradeHRLevel()
					Game:SetLeftHRLevel(Game:GetLeftHRLevel() + 1)
				else
					bool = false
					BTFGeneral:ShowError(playerID,"#BossHRLevelIsMax","General.NoGold")
				end
			end
			if team == DOTA_TEAM_BADGUYS then
				if Game:GetRightHRLevel() < 20 then
					playerData:UpgradeHRLevel()
					Game:SetRightHRLevel(Game:GetRightHRLevel() + 1)
				else
					bool = false
					BTFGeneral:ShowError(playerID,"#BossHRLevelIsMax","General.NoGold")
				end
			end
		end
		if bool then
			playerData:ModifyCrystal(-crystalCost)
			playerData:ModifyIncome(addIncome)
			BTFGeneral:ShowError(playerID,"#BossLevelUpSuccess","General.Buy")
		end
	else
		if GameRules:IsGamePaused() then
			BTFGeneral:ShowError(playerID,"","General.NoGold")
		elseif crystal < crystalCost then
			BTFGeneral:ShowError(playerID,"#NoEnoughLumber","General.NoGold")
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
		local adlevel = Game:GetLeftADLevel()
		local hlevel = Game:GetLeftHLevel()
		local hrlevel = Game:GetLeftHRLevel()
		if target:GetTeam() == DOTA_TEAM_BADGUYS then
			adlevel = Game:GetRightADLevel()
			hlevel = Game:GetRightHLevel()
			hrlevel = Game:GetRightHRLevel()
		end
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
