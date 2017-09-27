PlayerData = PlayerData or class(
	{
		--非UI非特定的数据储存表，例如hex_Q3
		Special = {},
		--ID,位置
		PlayerID = -1,
		PlayerPosition = -1,
		StartPoint = nil,
		--英雄
		Hero = nil,
		--金钱，收入
		Gold = 0,
		BaseIncome = 0,
		Income = 0,
		--水晶，科技，农民
		Crystal = 0,
		CrystalTech = 0,
		FarmerNum = 0,
		Farmers = {},
		--食物
		CurFood = 0,
		FullFood = 0,
		--兵力
		Score = 0,
		--军备
		ArmsValue = 0,
		--雇佣兵
		MercenaryRoad = -1,
		Mercenaries = {},
		NewMercenaries = {},
		--兵种列表
		Q = "",
		W = "",
		E = "",
		D = "",
		F = "",
		G = "",
		R = "",
		X = "",
		List = {"Q","W","E","D","F","G","R","X"},
		--建筑
		Buildings = {},
		NewBuildings = {},
		--部队
		Soliders = {},
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
		--设置
		ShowDamageMessage = false,
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
	for playerID, data in pairs(PlayerData.t) do
		if fCallback(playerID, data) == true then
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
	local result = nil
	PlayerData:Look(
		function(playerID, data)
			if data.PlayerPosition == iPlayerPosition then
				result = data
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
	return PlayerData.t[iPlayerID]
end
--玩家位置
function PlayerData:SetPlayerPosition(iPlayerPosition)
	self.PlayerPosition = iPlayerPosition

	local startEnt = Entities:FindByName(nil, "portal"..tostring(self.PlayerPosition))
	if startEnt ~= nil then
		self.StartPoint = startEnt:GetAbsOrigin()
	end

	self:UpdateNetTable()
end
function PlayerData:GetPlayerPosition()
	return self.PlayerPosition
end
function PlayerData:GetStartPoint()
	return self.StartPoint
end
--金钱
function PlayerData:SetGold(iGold)
	self.Gold = iGold
	PlayerResource:SetGold(self.PlayerID, iGold, false)

	self:UpdateNetTable()
end
function PlayerData:ModifyGold(iGoldChange, nReason)
	self.Gold = self.Gold + iGoldChange
	PlayerData:ModifyGold(self.PlayerID, iGoldChange, false, nReason)

	self:UpdateNetTable()
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
	self.Crystal = self.Crystal + iCrystalChange

	self:UpdateNetTable()
end
function PlayerData:GetCrystal()
	return self.Crystal
end
--水晶科技
function PlayerData:SetCrystalTech(iCrystalTech)
	self.CrystalTech = iCrystalTech

	self:UpdateNetTable()
end
function PlayerData:ModifyCrystalTech(iCrystalTechChange)
	self.CrystalTech = self.CrystalTech + iCrystalTechChange

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
function PlayerData:GetFarmerNumber()
	return self.FarmerNum
end
--食物
function PlayerData:SetCurFood(iCurFood)
	self.CurFood = math.min(iCurFood, self.FullFood)

	self:UpdateNetTable()
end
function PlayerData:ModifyCurFood(iCurFoodChange)
	self.CurFood = math.min(self.CurFood + iCurFoodChange, self.FullFood)

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
--兵力
function PlayerData:SetScore(iScore)
	self.Score = iScore

	self:UpdateNetTable()
end
function PlayerData:ModifyScore(iScoreChange)
	self.Score = self.Score + iScoreChange

	self:UpdateNetTable()
end
function PlayerData:GetScore()
	return self.Score
end
--军备
function PlayerData:AddArms(hItem)
	if hItem == nil or not IsValidEntity(hItem) or not hItem:IsItem() then error("hItem is missing or not a CDOTA_Item") end

	self.ArmsValue = self.ArmsValue + hItem:GetCost()

	self:UpdateNetTable()
end
function PlayerData:RemoveArms(hItem)
	if hItem == nil or not IsValidEntity(hItem) or not hItem:IsItem() then error("hItem is missing or not a CDOTA_Item") end

	self.ArmsValue = self.ArmsValue - hItem:GetCost()

	self:UpdateNetTable()
end
function PlayerData:GetArmsValue()
	return self.ArmsValue
end
--雇佣兵
function PlayerData:AddNewMercenary(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	table.insert(self.NewMercenaries, hUnit)
	table.insert(self.Mercenaries, hUnit)

	self:UpdateNetTable()
end
function PlayerData:NewMercenariesCharge()
	self.NewMercenaries = {}

	self:UpdateNetTable()
end
function PlayerData:LookNewMercenaries(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.NewMercenaries) do
		if fCallback(k, v) == true then
			return true
		end
	end
	return
end
function PlayerData:LookMercenaries(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.Mercenaries) do
		if fCallback(k, v) == true then
			return true
		end
	end
	return
end
function PlayerData:RemoveMercenary(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	for i = #self.NewMercenaries, 1, -1 do
		if self.NewMercenaries[i] == hUnit then
			table.remove(self.NewMercenaries, i)
		end
	end
	for i = #self.Mercenaries, 1, -1 do
		if self.Mercenaries[i] == hUnit then
			table.remove(self.Mercenaries, i)
		end
	end

	self:UpdateNetTable()
end
function PlayerData:SetMercenaryRoad(iMercenaryRoad)
	self.MercenaryRoad = iMercenaryRoad

	self:UpdateNetTable()
end
function PlayerData:GetMercenaryRoad()
	return self.MercenaryRoad
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
--兵种列表
-- function PlayerData:
--建筑
function PlayerData:AddNewBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	table.insert(self.NewBuildings, hUnit)
	table.insert(self.Buildings, hUnit)

	self:UpdateNetTable()
end
function PlayerData:NewBuildingsCharge()
	self.NewBuildings = {}

	self:UpdateNetTable()
end
function PlayerData:LookNewBuildings(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.NewBuildings) do
		if fCallback(k, v) == true then
			return true
		end
	end
	return
end
function PlayerData:LookBuildings(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.Buildings) do
		if fCallback(k, v) == true then
			return true
		end
	end
	return
end
function PlayerData:RemoveBuilding(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	for i = #self.NewBuildings, 1, -1 do
		if self.NewBuildings[i] == hUnit then
			table.remove(self.NewBuildings, i)
		end
	end
	for i = #self.Buildings, 1, -1 do
		if self.Buildings[i] == hUnit then
			table.remove(self.Buildings, i)
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
--部队
function PlayerData:AddSolider(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	table.insert(self.Soliders, hUnit)

	self:UpdateNetTable()
end
function PlayerData:RemoveSolider(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC") end

	for i = #self.Soliders, 1, -1 do
		if self.Soliders[i] == hUnit then
			table.remove(self.Soliders, i)
		end
	end

	self:UpdateNetTable()
end
function PlayerData:LookSoliders(fCallback)
	if fCallback == nil or type(fCallback) ~= "function" then error("fCallback is missing or not a function") end

	for k, v in pairs(self.Soliders) do
		if fCallback(k, v) == true then
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
--MVP
function PlayerData:IncrementDamageToKing(iDTK)
	iDTK = iDTK or 0

	self.MVP_DamageToKing = self.MVP_DamageToKing + iDTK
end
function PlayerData:IncrementBreakGold(iBG)
	iBG = iBG or 0

	self.MVP_BreakGold = self.MVP_BreakGold + iBG
end
function PlayerData:IncrementKills()
	self.MVP_Kills = self.MVP_Kills + 1
end
function PlayerData:IncrementKillCount()
	self.MVP_Kills = self.MVP_Kills + 1
end
function PlayerData:IncrementTotalCrystal(iTC)
	iTC = iTC or 0

	self.MVP_TotalCrystal = self.MVP_TotalCrystal + iTC
end
function PlayerData:IncrementTotalGold(iTG)
	iTG = iTG or 0

	self.MVP_TotalGold = self.MVP_TotalGold + iTG
end
--设置
function PlayerData:ShowDamageMessage(bFlag)
	self.ShowDamageMessage = bFlag

	self:UpdateNetTable()
end
--事件
function PlayerData:OnEntityKilled(events)
	local killed_unit = EntIndexToHScript(events.entindex_killed)

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

	t.Score = self.Score

	t.ArmsValue = self.ArmsValue

	t.MercenaryRoad = self.MercenaryRoad
	t.Mercenaries = {}
	for k,v in pairs(self.Mercenaries) do
		t.Mercenaries[k] = v:entindex()
	end
	t.NewMercenaries = {}
	for k,v in pairs(self.NewMercenaries) do
		t.NewMercenaries[k] = v:entindex()
	end

	t.Buildings = {}
	for k,v in pairs(self.Buildings) do
		t.Buildings[k] = v:entindex()
	end
	t.NewBuildings = {}
	for k,v in pairs(self.NewBuildings) do
		t.NewBuildings[k] = v:entindex()
	end

	t.Soliders = {}
	for k,v in pairs(self.Soliders) do
		t.Soliders[k] = v:entindex()
	end

	t.ADLevel = self.ADLevel
	t.HLevel = self.HLevel
	t.HRLevel = self.HRLevel

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

	t.ShowDamageMessage = self.ShowDamageMessage

	CustomNetTables:SetTableValue("PlayerData", "Player_"..self.PlayerID, t)
end