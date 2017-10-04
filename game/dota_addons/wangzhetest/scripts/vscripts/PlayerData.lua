PlayerData = PlayerData or class(
	{
		--非UI非特定的数据储存表，例如hex_Q3
		Special = {},
		--ID,位置
		PlayerID = -1,
		PlayerPosition = -1,
		FrontEnemyPosition = -1,
		StartPoint = nil,
		EndPoint = nil,
		MercenaryPoint = nil,
		--英雄
		Hero = nil,
		--金钱，收入
		Gold = 0,
		BaseIncome = 0,
		Income = 0,
		--水晶，水晶科技，农民
		Crystal = 0,
		CrystalTech = 0,
		FarmerNum = 0,
		Farmers = {},
		--食物
		CurFood = 0,
		FullFood = 0,
		--科技
		Tech = 0,
		--兵力
		Score = 0,
		--军备
		ArmsValue = 0,
		--雇佣兵
		MercenaryRoad = -1,
		Mercenaries = {},
		NewMercenaries = {},
		--兵种列表
		BuildingTypeList = {
			Q = "",
			W = "",
			E = "",
			D = "",
			F = "",
			G = "",
			R = "",
			X = "",
		},
		RemovedBuildingType = {
			Q = false,
			W = false,
			E = false,
			D = false,
			F = false,
			G = false,
			R = false,
			X = false,
		},
		--科技建筑
		TechBuilding = nil,
		FoodBuilding = nil,
		BannerBuilding = nil,
		--建筑
		Buildings = {},
		NewBuildings = {},
		--部队
		Soliders = {},
		--固守
		Adherence = false,
		AdherenceStele = nil,
		--强化
		ADLevel = 0,
		HLevel = 0,
		HRLevel = 0,
		--天梯
		SteamID = -1,
		RankingScore = 0,
		RankingRank = 9999999,
		RankingTotal = 0,
		RankingPer = 1,
		RankingLevel = 1,
		RankingAppellation = 1,
		--MVP
		MVP_DamageToKing = 0,
		MVP_BreakGold = 0,
		MVP_Kills = 0,
		MVP_TotalCrystal = 0,
		MVP_TotalGold = 0,
		--离开
		IsAbandonState = false,
		AbandonRound = 0,
		--设置
		ShowDamage = false,
	}
, nil, nil)

PlayerData.t = PlayerData.t or {}

--[[
PlayerData的API
即通过使用PlayerData为传参调用
例子：
	local playerData = PlayerData:GetPlayerData(0) --获取玩家ID为0的玩家数据实例
]]--

--获取所有的玩家数据实例
function PlayerData:GetAllPlayerData()
	local t = {}
	for k, v in pairs(PlayerData.t) do
		t[k] = v
	end
	return t
end
--遍历玩家数据实例
function PlayerData:Look(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end
	for playerID, playerData in pairs(PlayerData.t) do
		if fCallback(playerID, playerData) == true then
			return true
		end
	end
end
--获取玩家数据实例
function PlayerData:GetPlayerData(iPlayerID)
	return PlayerData.t[iPlayerID]
end
--通过玩家位置获取玩家数据实例
function PlayerData:GetPlayerDataByPosition(iPlayerPosition)
	if iPlayerPosition == nil then return nil end

	local result = nil
	PlayerData:Look(
		function(playerID, playerData)
			if playerData:GetPlayerPosition() == iPlayerPosition then
				result = playerData
				return true
			end
		end
	)
	return result
end

--[[
实例的method
即通过使用创建的玩家数据实例为传参调用
例子：
	local playerData = PlayerData(0) --构建玩家ID为0的数据实例
	playerData:RemoveSelf() --删除该实例
]]--

--构建实例
function PlayerData:constructor(iPlayerID)
	self:SetPlayerID(iPlayerID)

	self:GetRankingFromServer()

	self:InitStartBuildingTypeList()

	self.entityKilledIndex = ListenToGameEvent("entity_killed", Dynamic_Wrap(PlayerData, "OnEntityKilled"), self)
end
--删除实例
function PlayerData:RemoveSelf()
	CustomNetTables:SetTableValue("PlayerData", "Player_"..self.PlayerID, nil)

	PlayerData.t[self.iPlayerID] = nil

	StopListeningToGameEvent(self.entityKilledIndex)
end
--Save
function PlayerData:Save(key, value)
	if value == nil then
		value = key
		key = DoUniqueString("value")
	end
	if value == nil then error("value is missing") end

	self.Special[key] = value

	return key
end
--Load
function PlayerData:Load(key)
	if key == nil or type(key) ~= "string" then error("key is missing or not a string") end

	return self.Special[key]
end
--Remove
function PlayerData:Remove(key)
	if key == nil or type(key) ~= "string" then error("key is missing or not a string") end

	self.Special[key] = nil
end

--玩家ID
function PlayerData:SetPlayerID(iPlayerID)
	if self.PlayerID ~= -1 then PlayerData.t[self.iPlayerID] = nil end

	self.PlayerID = iPlayerID
	PlayerData.t[iPlayerID] = self

	self:UpdateNetTable()
end
function PlayerData:GetPlayerID()
	return self.PlayerID
end
--玩家位置
function PlayerData:SetPlayerPosition(iPlayerPosition)
	self.PlayerPosition = iPlayerPosition
	self.FrontEnemyPlayerPosition = self.PlayerPosition + 4

	local team = DOTA_TEAM_GOODGUYS

	if self.PlayerPosition > 4 then
		self.FrontEnemyPlayerPosition = self.FrontEnemyPlayerPosition - 8
		team = DOTA_TEAM_BADGUYS
	end

	local startEnt = Entities:FindByName(nil, "portal"..tostring(self.PlayerPosition))
	if startEnt ~= nil then
		self.StartPoint = startEnt:GetAbsOrigin()
	end

	local endEnt = Entities:FindByName(nil, "portal"..tostring(self.FrontEnemyPlayerPosition))
	if endEnt ~= nil then
		self.EndPoint = endEnt:GetAbsOrigin()
	end

	local merEnt = Entities:FindByName(nil, "hire_"..tostring(self.PlayerPosition))
	if merEnt ~= nil then
		self.MercenaryPoint = merEnt:GetAbsOrigin()
	end

	self:UpdateNetTable()
end
function PlayerData:GetPlayerPosition()
	return self.PlayerPosition
end
function PlayerData:GetFrontEnemyPlayerPosition()
	return self.FrontEnemyPlayerPosition
end
function PlayerData:GetStartPoint()
	return self.StartPoint
end
function PlayerData:GetEndPoint()
	return self.EndPoint
end
function PlayerData:GetMercenaryPoint()
	return self.MercenaryPoint
end
--英雄
function PlayerData:SetHero(hHero)
	if hHero == nil or not IsValidEntity(hHero) then error("hHero is missing or not a CDOTA_BaseNPC_Hero") end

	self.Hero = hHero

	self.Hero:SetContextThink(DoUniqueString("ArmsValue"), 
		function()
			self:UpdateArms()
			return 0.5
		end
	, 0.5)

	self:UpdateNetTable()
end
function PlayerData:GetHero()
	return self.Hero
end
--金钱
function PlayerData:SetGold(iGold)
	self.Gold = iGold

	PlayerResource:SetGold(self.PlayerID, iGold, false)

	self:UpdateNetTable()
end
function PlayerData:ModifyGold(iGoldChange, nReason)
	self:SetGold(self.Gold + iGoldChange)
	
	nReason = nReason or DOTA_ModifyGold_Unspecified

	--增加总计
	self:IncrementTotalGold(math.max(0, iGoldChange))
end
function PlayerData:GetGold()
	return self.Gold
end
--收入
function PlayerData:SetIncome(iIncome, bIsBase)
	if bIsBase ~= nil and bIsBase == true then
		self.BaseIncome = iIncome
	else
		self.Income = iIncome
	end

	self:UpdateNetTable()
end
function PlayerData:ModifyIncome(iIncomeChange, bIsBase)
	if bIsBase ~= nil and bIsBase == true then
		self.BaseIncome = self.BaseIncome + iIncomeChange
	else
		self.Income = self.Income + iIncomeChange
	end

	self:UpdateNetTable()
end
function PlayerData:GetIncome(bIsBase)
	if bIsBase ~= nil and bIsBase == true then
		return self.BaseIncome
	end
	return self.Income
end
function PlayerData:GetAllIncome()
	return self.Income + self.BaseIncome
end
--水晶
function PlayerData:SetCrystal(iCrystal)
	self.Crystal = iCrystal

	self:UpdateNetTable()
end
function PlayerData:ModifyCrystal(iCrystalChange)
	self:SetCrystal(self.Crystal + iCrystalChange)

	--增加总计
	self:IncrementTotalCrystal(math.max(0, iCrystalChange))
end
function PlayerData:GetCrystal()
	return self.Crystal
end
--水晶科技
function PlayerData:UpgradeCrystalTech()
	self.CrystalTech = self.CrystalTech + 1

	self:UpdateNetTable()
end
function PlayerData:GetCrystalTech()
	return self.CrystalTech
end
--农民
function PlayerData:AddFarmer(iFarmerNum)
	if iFarmerNum == nil or iFarmerNum < 1 then iFarmerNum = 1 end

	for i = self.FarmerNum+1, self.FarmerNum+iFarmerNum, 1 do
		local farmerEnt = Entities:FindByName(nil, "player_"..tostring(self.PlayerPosition).."_farmer_"..tostring(i))
		self.Farmers[i] = UnitManager:CreateUnitByName("npc_dummy_farmer", farmerEnt:GetAbsOrigin() , false, self.PlayerID, PlayerResource:GetTeam(self.PlayerID)) 
	end

	self.FarmerNum = self.FarmerNum + iFarmerNum 

	self:UpdateNetTable()
end
function PlayerData:RemoveFarmer(iFarmerNum)
	if iFarmerNum == nil or iFarmerNum < 1 then iFarmerNum = 1 end

	for i = self.FarmerNum-iFarmerNum+1, self.FarmerNum, 1 do
		self.Farmers[i]:RemoveSelf()
		self.Farmers[i] = nil
	end

	self.FarmerNum = self.FarmerNum - iFarmerNum 

	self:UpdateNetTable()
end
function PlayerData:LookFarmer(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.Farmers) do
		if fCallback(k, v) == true then
			return true
		end
	end
	return
end
function PlayerData:GetFarmerNumber()
	return self.FarmerNum
end
--食物
function PlayerData:SetCurFood(iCurFood)
	self.CurFood = iCurFood

	self:UpdateNetTable()
end
function PlayerData:ModifyCurFood(iCurFoodChange)
	self.CurFood = self.CurFood + iCurFoodChange

	self:UpdateNetTable()
end
function PlayerData:GetCurFood()
	return self.CurFood
end
function PlayerData:SetFullFood(iFullFood)
	self.FullFood = iFullFood

	self:UpdateNetTable()
end
function PlayerData:ModifyFullFood(iFullFoodChange)
	self.FullFood = self.FullFood + iFullFoodChange

	self:UpdateNetTable()
end
function PlayerData:GetFullFood()
	return self.FullFood
end
--科技
function PlayerData:UpgradeTech()
	self.Tech = self.Tech + 1

	for item_index = 0, 5, 1 do
		local item = self.Hero:GetItemInSlot(item_index)
		if item then
			if self.Tech >= 1 and item:GetName() == "item_score_5" then
				self.Hero:RemoveItem(item)
			elseif self.Tech >= 2 and item:GetName() == "item_score_5" then
				self.Hero:RemoveItem(item)
			end
		end
	end

	self:UpdateNetTable()
end
function PlayerData:GetTechLevel()
	return self.Tech
end
--兵力
function PlayerData:SetScore(iScore)
	self.Score = iScore

	self:UpdateNetTable()
end
function PlayerData:ModifyScore(iScoreChange)
	self.Score = self.Score + iScoreChange

	if PlayerResource:GetTeam(self.PlayerID) == DOTA_TEAM_GOODGUYS then
		Game:ModifyLeftScore(iScoreChange)
	elseif PlayerResource:GetTeam(self.PlayerID) == DOTA_TEAM_BADGUYS then
		Game:ModifyRightScore(iScoreChange)
	end

	for item_index = 0, 5, 1 do
		local item = self.Hero:GetItemInSlot(item_index)
		if item then
			if self.Score >= 880 and item:GetName() == "item_score_1" then
				self.Hero:RemoveItem(item)
			elseif self.Score >= 6000 and item:GetName() == "item_score_2" then
				self.Hero:RemoveItem(item)
			elseif self.Score >= 9000 and item:GetName() == "item_score_3" then
				self.Hero:RemoveItem(item)
			elseif self.Score >= 12000 and item:GetName() == "item_score_4" then
				self.Hero:RemoveItem(item)
			end
		end
	end

	self:UpdateNetTable()
end
function PlayerData:GetScore()
	return self.Score
end
--军备
function PlayerData:UpdateArms()
	if self.Hero == nil then return end
	self.ArmsValue = 0
	for item_index = 0, 5, 1 do
		local item = self.Hero:GetItemInSlot(item_index)
		if item then
			self.ArmsValue = self.ArmsValue + item:GetCost()
		end
	end

	self:UpdateNetTable()
end
function PlayerData:GetArmsValue()
	return self.ArmsValue
end
--雇佣兵
function PlayerData:AddNewMercenary(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	table.insert(self.NewMercenaries, hUnit:entindex())

	self:UpdateNetTable()
end
function PlayerData:RemoveNewMercenary(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	for i = #self.NewMercenaries, 1, -1 do
		if self.NewMercenaries[i] == hUnit:entindex() then
			table.remove(self.NewMercenaries, i)
		end
	end

	self:UpdateNetTable()
end
function PlayerData:LookNewMercenaries(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.NewMercenaries) do
		if fCallback(k, EntIndexToHScript(v)) == true then
			return true
		end
	end
	return
end
function PlayerData:NewMercenariesCharge()
	self.NewMercenaries = {}

	self:UpdateNetTable()
end
function PlayerData:IsNewMercenary(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	local b = false

	self:LookNewMercenaries(
		function(n, newMercenary)
			if newMercenary == hUnit then
				b = true
				return true
			end
		end
	)
	return b
end
function PlayerData:AddMercenary(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	table.insert(self.Mercenaries, hUnit:entindex())

	self:UpdateNetTable()
end
function PlayerData:RemoveMercenary(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	for i = #self.Mercenaries, 1, -1 do
		if self.Mercenaries[i] == hUnit:entindex() then
			table.remove(self.Mercenaries, i)
		end
	end

	self:UpdateNetTable()
end
function PlayerData:LookMercenaries(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.Mercenaries) do
		if fCallback(k, EntIndexToHScript(v)) == true then
			return true
		end
	end
	return
end
function PlayerData:IsMercenary(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	local b = false

	self:LookMercenaries(
		function(n, mercenary)
			if mercenary == hUnit then
				b = true
				return true
			end
		end
	)
	return b
end
function PlayerData:SetMercenaryRoad(iMercenaryRoad)
	self.MercenaryRoad = iMercenaryRoad

	self:UpdateNetTable()
end
function PlayerData:GetMercenaryRoad()
	return self.MercenaryRoad
end
--兵种列表
function PlayerData:InitStartBuildingTypeList()
	for type,name in pairs(self.BuildingTypeList) do
		self.BuildingTypeList[type] = AllTypes[type][RandomInt(1, #AllTypes[type])]
	end

	self:UpdateNetTable()
end
function PlayerData:SetBuildingTypeName(sType, sName)
	for n,name in pairs(AllTypes[sType]) do
		if name == sName then
			self.BuildingTypeList[sType] = sName
			self:UpdateNetTable()
			return true
		end
	end
	return false
end
function PlayerData:GetBuildingTypeName(sType)
	if sType == nil or type(sType) ~= "string" then error("sType is missing or not a string") end

	return self.BuildingTypeList[sType]
end
function PlayerData:BuildingAddBuildAbility(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	if not self.RemovedBuildingType["Q"] then
		AbilityManager:AddAndSet(hUnit, self.BuildingTypeList["Q"])
	end
	if not self.RemovedBuildingType["W"] then
		AbilityManager:AddAndSet(hUnit, self.BuildingTypeList["W"])
	end
	if not self.RemovedBuildingType["E"] then
		AbilityManager:AddAndSet(hUnit, self.BuildingTypeList["E"])
	end
	if not self.RemovedBuildingType["D"] then
		AbilityManager:AddAndSet(hUnit, self.BuildingTypeList["D"])
	end
	if not self.RemovedBuildingType["F"] then
		AbilityManager:AddAndSet(hUnit, self.BuildingTypeList["F"])
	end
	if not self.RemovedBuildingType["G"] then
		AbilityManager:AddAndSet(hUnit, self.BuildingTypeList["G"])
	end
	if not self.RemovedBuildingType["R"] then
		AbilityManager:AddAndSet(hUnit, self.BuildingTypeList["R"])
	end
	if not self.RemovedBuildingType["X"] then
		AbilityManager:AddAndSet(hUnit, self.BuildingTypeList["X"])
	end
end
function PlayerData:UpdateBuildingsBuildAbility()
	self:LookBuildings(
		function(n, building)
			if building:GetUnitName() == "npc_dummy_build_base" and building:GetPlayerOwnerID() == self.PlayerID then
				for i = 0,15 do
					local ability = building:GetAbilityByIndex(i)
					if ability then
						if ability:GetAbilityName() ~= "kexuanmajia" then
							building:RemoveAbility(ability:GetAbilityName())
						end
					end
				end
				self:BuildingAddBuildAbility(building)
			end
		end
	)
end
function PlayerData:BuildingsRemoveBuildAbility(sType)
	self.RemovedBuildingType[sType] = true
	self:LookBuildings(
		function(n, building)
			if building:GetUnitName() == "npc_dummy_build_base" and building:GetPlayerOwnerID() == self.PlayerID then
				building:RemoveAbility(self:GetBuildingTypeName(sType))
			end
		end
	)

	self:UpdateNetTable()
end
--科技建筑
function PlayerData:SetTechBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	self.TechBuilding = hUnit

	self:UpdateNetTable()
end
function PlayerData:GetTechBuilding(hUnit)
	return self.TechBuilding
end
function PlayerData:SetFoodBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	self.FoodBuilding = hUnit

	self:UpdateNetTable()
end
function PlayerData:GetFoodBuilding(hUnit)
	return self.FoodBuilding
end
function PlayerData:SetBannerBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	self.BannerBuilding = hUnit

	self:UpdateNetTable()
end
function PlayerData:GetBannerBuilding(hUnit)
	return self.BannerBuilding
end
--建筑
function PlayerData:AddNewBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	table.insert(self.NewBuildings, hUnit:entindex())

	self:UpdateNetTable()
end
function PlayerData:NewBuildingsCharge()
	self.NewBuildings = {}

	self:UpdateNetTable()
end
function PlayerData:LookNewBuildings(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.NewBuildings) do
		if fCallback(k, EntIndexToHScript(v)) == true then
			return true
		end
	end
	return
end
function PlayerData:RemoveNewBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	for i = #self.NewBuildings, 1, -1 do
		if self.NewBuildings[i] == hUnit:entindex() then
			table.remove(self.NewBuildings, i)
		end
	end

	self:UpdateNetTable()
end
function PlayerData:IsNewBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	local b = false

	self:LookNewBuildings(
		function(n, newBuilding)
			if newBuilding == hUnit then
				b = true
				return true
			end
		end
	)
	return b
end
function PlayerData:AddBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	table.insert(self.Buildings, hUnit:entindex())

	self:UpdateNetTable()
end
function PlayerData:LookBuildings(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.Buildings) do
		if fCallback(k, EntIndexToHScript(v)) == true then
			return true
		end
	end
	return
end
function PlayerData:IsBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	local b = false

	self:LookBuildings(
		function(n, building)
			if building == hUnit then
				b = true
				return true
			end
		end
	)
	return b
end
function PlayerData:ReplaceBuilding(hOld, hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	for k, v in pairs(self.Buildings) do
		if v == hOld:entindex() then
			self.Buildings[k] = hUnit:entindex()
			self:UpdateNetTable()
		end
	end
end
--部队
function PlayerData:AddSolider(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	table.insert(self.Soliders, hUnit:entindex())

	self:UpdateNetTable()
end
function PlayerData:RemoveSolider(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	for i = #self.Soliders, 1, -1 do
		if self.Soliders[i] == hUnit:entindex() then
			table.remove(self.Soliders, i)
		end
	end

	self:UpdateNetTable()
end
function PlayerData:LookSoliders(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.Soliders) do
		if fCallback(k, EntIndexToHScript(v)) == true then
			return true
		end
	end
	return
end
function PlayerData:IsSolider(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	local b = false

	self:LookSoliders(
		function(n, solider)
			if solider == hUnit then
				b = true
				return true
			end
		end
	)
	return b
end
--固守
function PlayerData:StartAdherence(hAdherenceStele)
	self.AdherenceStele = hAdherenceStele
	self.Adherence = true
end
function PlayerData:IsAdherence()
	return self.Adherence
end
function PlayerData:GetAdherenceStele()
	return self.AdherenceStele
end
--强化
function PlayerData:UpgradeADLevel(iLevel)
	if iLevel == nil or iLevel < 1 then iLevel = 1 end

	self.ADLevel = self.ADLevel + iLevel

	self:UpdateNetTable()
end
function PlayerData:UpgradeHLevel(iLevel)
	if iLevel == nil or iLevel < 1 then iLevel = 1 end

	self.HLevel = self.HLevel + iLevel

	self:UpdateNetTable()
end
function PlayerData:UpgradeHRLevel(iLevel)
	if iLevel == nil or iLevel < 1 then iLevel = 1 end

	self.HRLevel = self.HRLevel + iLevel

	self:UpdateNetTable()
end
--天梯
function PlayerData:GetRankingFromServer()
	self.SteamID = PlayerResource:GetSteamID(self.PlayerID)

	local caculate = function(score, rank, per)
		score = score or 0
		rank = rank or 9999999
		per = per or 1

		local level = 101 - math.ceil(per*100)

		if score == 0 then
			level = 1
		end
		if rank <= 50 then
			level = 101
		end
		local appellation = 0
		if level == 1 then
			appellation = 1
		elseif level >=  2 and level < 30 then
			appellation = 2
		elseif level >= 30 and level < 50 then
			appellation = 3
		elseif level >= 50 and level < 70 then
			appellation = 4
		elseif level >= 70 and level < 80 then
			appellation = 5
		elseif level >= 80 and level < 90 then
			appellation = 6
		elseif level >= 90 and level < 96 then
			appellation = 7
		elseif level >= 96 and level < 100 then
			appellation = 8
		elseif level == 100 then
			appellation = 9
		elseif level == 101 then
			appellation = 10
		end
		return level,appellation
	end

	local url = "http://www.dota2rpg.com/game_wz1/wz_get_ladderpoints.php?playerid="..tostring(self.SteamID).."&hehe="..math.random()
	local req = CreateHTTPRequestScriptVM("GET", url)
	req:Send(
		function(result)
			local keys = json.decode(result.Body)
			if keys.score ~= nil and keys.rank ~= nil and keys.total ~= nil and keys.per ~= nil then
				self.RankingScore = tonumber(keys.score)
				self.RankingRank = tonumber(keys.rank)
				self.RankingTotal = tonumber(keys.total)
				self.RankingPer = keys.per
				self.RankingLevel,self.RankingAppellation = caculate(self.RankingScore, self.RankingRank, self.RankingPer)
			end
		end
	)
end
function PlayerData:GetSteamID()
	return self.SteamID
end
function PlayerData:GetRankingScore()
	return self.RankingScore
end
function PlayerData:GetRankingRank()
	return self.RankingRank
end
function PlayerData:GetRankingTotal()
	return self.RankingTotal
end
function PlayerData:GetRankingPer()
	return self.RankingPer
end
function PlayerData:GetRankingLevel()
	return self.RankingLevel
end
function PlayerData:GetRankingAppellation()
	return self.RankingAppellation
end
--MVP
function PlayerData:IncrementDamageToKing(iDTK)
	iDTK = iDTK or 0

	self.MVP_DamageToKing = self.MVP_DamageToKing + iDTK
end
function PlayerData:GetDamageToKing()
	return self.MVP_DamageToKing
end
function PlayerData:IncrementBreakGold(iBG)
	iBG = iBG or 0

	self.MVP_BreakGold = self.MVP_BreakGold + iBG
end
function PlayerData:GetBreakGold()
	return self.MVP_BreakGold
end
function PlayerData:IncrementKills()
	self.MVP_Kills = self.MVP_Kills + 1
end
function PlayerData:GetKills()
	return self.MVP_Kills
end
function PlayerData:IncrementTotalCrystal(iTC)
	iTC = iTC or 0

	self.MVP_TotalCrystal = self.MVP_TotalCrystal + iTC
end
function PlayerData:GetTotalCrystal()
	return self.MVP_TotalCrystal
end
function PlayerData:IncrementTotalGold(iTG)
	iTG = iTG or 0

	self.MVP_TotalGold = self.MVP_TotalGold + iTG
end
function PlayerData:GetTotalGold()
	return self.MVP_TotalGold
end
--设置
function PlayerData:ShowDamageMessage(bFlag)
	self.ShowDamage = bFlag

	self:UpdateNetTable()
end
function PlayerData:IsShowDamageMessage()
	return self.ShowDamage
end
function PlayerData:Abandon()
	self.IsAbandonState = true
	self.AbandonRound = GetRound()
end
function PlayerData:IsAbandon()
	return self.IsAbandonState
end
function PlayerData:GetAbandonRound()
	return self.AbandonRound
end
--事件
function PlayerData:OnEntityKilled(events)
	local killed_unit = EntIndexToHScript(events.entindex_killed)
	local killing_unit = EntIndexToHScript(events.entindex_attacker)

	if killing_unit and killed_unit then
		local killed_player = killed_unit:GetPlayerOwnerID()
		local killing_player = killing_unit:GetPlayerOwnerID()
		if killing_player ~= -1 and killed_player ~= -1 then
			if not HasLabel(killed_unit, "SummonUnit") then
				self:IncrementKills()
			end
		end
	end

	if killed_unit ~= nil then
		if self:IsSolider(killed_unit) then
			self:RemoveSolider(killed_unit)
		end
		if self:IsMercenary(killed_unit) then
			self:RemoveMercenary(killed_unit)
		end
	end
end
--更新NetTable
function PlayerData:UpdateNetTable()
	local t = {}

	t.PlayerPosition = self.PlayerPosition
	t.FrontEnemyPosition = self.FrontEnemyPosition

	t.Gold = self.Gold
	t.BaseIncome = self.BaseIncome
	t.Income = self.Income

	t.Crystal = self.Crystal
	t.CrystalTech = self.CrystalTech
	t.FarmerNum = self.FarmerNum
	t.Farmers = {}
	for k,v in pairs(self.Farmers) do
		t.Farmers[k] = v:entindex()
	end

	t.CurFood = self.CurFood
	t.FullFood = self.FullFood

	t.Tech = self.Tech

	t.Score = self.Score

	t.ArmsValue = self.ArmsValue

	t.MercenaryRoad = self.MercenaryRoad
	t.Mercenaries = self.Mercenaries
	t.NewMercenaries = self.NewMercenaries

	t.BuildingTypeList = self.BuildingTypeList
	t.RemovedBuildingType = self.RemovedBuildingType

	if self.TechBuilding ~= nil then t.TechBuilding = self.TechBuilding:entindex() end
	if self.FoodBuilding ~= nil then t.FoodBuilding = self.FoodBuilding:entindex() end
	if self.BannerBuilding ~= nil then t.BannerBuilding = self.BannerBuilding:entindex() end
	t.Buildings = self.Buildings
	t.NewBuildings = self.NewBuildings

	t.Soliders = self.Soliders

	t.Adherence = self.Adherence

	t.ADLevel = self.ADLevel
	t.HLevel = self.HLevel
	t.HRLevel = self.HRLevel

	t.SteamID = tostring(self.SteamID)
	t.RankingScore = self.RankingScore
	t.RankingRank = self.RankingRank
	t.RankingTotal = self.RankingTotal
	t.RankingPer = self.RankingPer
	t.RankingLevel = self.RankingLevel
	t.RankingAppellation = self.RankingAppellation

	t.MVP_DamageToKing = self.MVP_DamageToKing
	t.MVP_BreakGold = self.MVP_BreakGold
	t.MVP_Kills = self.MVP_Kills
	t.MVP_TotalCrystal = self.MVP_TotalCrystal
	t.MVP_TotalGold = self.MVP_TotalGold

	t.IsAbandonState = self.IsAbandonState
	t.AbandonRound = self.AbandonRound

	t.ShowDamageMessage = self.ShowDamageMessage

	CustomNetTables:SetTableValue("PlayerData", "Player_"..self.PlayerID, t)
end