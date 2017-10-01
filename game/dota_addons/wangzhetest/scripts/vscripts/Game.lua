if Game == nil then
	Game = {
		info = {
			playerCount = 0,
			rankMode = false,
			testMode = false,
			firstBloodPlayerID = -1,
			winnerTeam = DOTA_TEAM_NOTEAM,
			matchID = -1,

			leftPlayerCount = 0,
			leftKing = -1,
			leftScore = 0,
			leftLife = 0,
			leftADLevel = 0,
			leftHLevel = 0,
			leftHRLevel = 0,

			rightPlayerCount = 0,
			rightKing = -1,
			rightScore = 0,
			rightLife = 0,
			rightADLevel = 0,
			rightHLevel = 0,
			rightHRLevel = 0,

			round = 0,
			roundTime = 0,

			earnCrystalTime = 0,
		},
		time = {
			nextRoundTime = 0,
			nextEarnCrystalTime = 0,
		},
	}
end
--[[
	info
]]--
--playerCount
function Game:GetPlayerCount()
	return self.info.playerCount
end
--rankMode
function Game:RankMode(bFlag)
	self.info.rankMode = bFlag

	self:UpdateGame()
end
function Game:IsRankMode()
	return self.info.rankMode
end
--testMode
function Game:TestMode(bFlag)
	self.info.testMode = bFlag

	self:UpdateGame()
end
function Game:IsTestMode()
	return self.info.testMode
end
--firstBloodPlayerID
function Game:SetFirstBloodPlayerID(iPlayerID)
	self.info.firstBloodPlayerID = iPlayerID

	self:UpdateGame()
end
function Game:GetFirstBloodPlayerID()
	return self.info.firstBloodPlayerID
end
--winnerTeam
function Game:SetWinnerTeam(iTeam)
	self.info.winnerTeam = iTeam

	self:UpdateGame()
end
function Game:GetWinnerTeam()
	return self.info.winnerTeam
end
--matchID
function Game:SetMatchID(iID)
	self.info.winnerTeam = iTeam

	self:UpdateGame()
end
function Game:GetMatchID()
	return self.info.winnerTeam
end
--left
function Game:SetLeftPlayerCount(iCount)
	self.info.leftPlayerCount = iCount

	self:UpdateGame()
end
function Game:GetLeftPlayerCount()
	return self.info.leftPlayerCount
end
function Game:SetLeftKing(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC_Hero") end

	self.info.leftKing = hUnit:entindex()

	self:UpdateGame()
end
function Game:GetLeftKing()
	return EntIndexToHScript(self.info.leftKing)
end
function Game:ModifyLeftScore(iScoreChange)
	self.info.leftScore = self.info.leftScore + iScoreChange

	self:UpdateGame()
end
function Game:GetLeftScore()
	return self.info.leftScore
end
function Game:ModifyLeftLife(iLifeChange)
	self.info.leftLife = self.info.leftLife + iLifeChange

	self:UpdateGame()
end
function Game:GetLeftLife()
	return self.info.leftLife
end
function Game:SetLeftADLevel(iLevel)
	self.info.leftADLevel = iLevel

	self:UpdateGame()
end
function Game:GetLeftADLevel()
	return self.info.leftADLevel
end
function Game:SetLeftHLevel(iLevel)
	self.info.leftHLevel = iLevel

	self:UpdateGame()
end
function Game:GetLeftHLevel()
	return self.info.leftHLevel
end
function Game:SetLeftHRLevel(iLevel)
	self.info.leftHRLevel = iLevel

	self:UpdateGame()
end
function Game:GetLeftHRLevel()
	return self.info.leftHRLevel
end
--right
function Game:SetRightPlayerCount(iCount)
	self.info.rightPlayerCount = iCount

	self:UpdateGame()
end
function Game:GetRightPlayerCount()
	return self.info.rightPlayerCount
end
function Game:SetRightKing(hUnit)
	if hUnit == nil or not IsValidEntity(hUnit) then error("hUnit is missing or not a CDOTA_BaseNPC_Hero") end

	self.info.rightKing = hUnit:entindex()

	self:UpdateGame()
end
function Game:GetRightKing()
	return EntIndexToHScript(self.info.rightKing)
end
function Game:ModifyRightScore(iScoreChange)
	self.info.rightScore = self.info.rightScore + iScoreChange

	self:UpdateGame()
end
function Game:GetRightScore()
	return self.info.rightScore
end
function Game:ModifyRightLife(iLifeChange)
	self.info.rightLife = self.info.rightLife + iLifeChange

	self:UpdateGame()
end
function Game:GetRightLife()
	return self.info.rightLife
end
function Game:SetRightADLevel(iLevel)
	self.info.rightADLevel = iLevel

	self:UpdateGame()
end
function Game:GetRightADLevel()
	return self.info.rightADLevel
end
function Game:SetRightHLevel(iLevel)
	self.info.rightHLevel = iLevel

	self:UpdateGame()
end
function Game:GetRightHLevel()
	return self.info.rightHLevel
end
function Game:SetRightHRLevel(iLevel)
	self.info.rightHRLevel = iLevel

	self:UpdateGame()
end
function Game:GetRightHRLevel()
	return self.info.rightHRLevel
end
--round
function Game:SetRound(iRound)
	self.info.round = iRound

	self:UpdateGame()
end
function Game:GetRound()
	return self.info.round
end
--roundTime
function Game:SetRoundTime(fTime)
	self.info.roundTime = fTime

	self:UpdateGame()
end
function Game:GetRoundTime()
	return self.info.roundTime
end
--earnCrystalTime
function Game:SetEarnCrystalTime(fTime)
	self.info.earnCrystalTime = fTime

	self:UpdateGame()
end
function Game:GetEarnCrystalTime()
	return self.info.earnCrystalTime
end
--[[
	time
]]--
--nextRoundTime
function Game:SetNextRoundTime(fTime)
	self.time.nextRoundTime = fTime

	self:UpdateGame()
end
function Game:GetNextRoundTime()
	return self.time.nextRoundTime
end
--nextEarnCrystalTime
function Game:SetNextEarnCrystalTime(fTime)
	self.time.nextEarnCrystalTime = fTime

	self:UpdateGame()
end
function Game:GetNextEarnCrystalTime()
	return self.time.nextEarnCrystalTime
end
--UpdateGame
function Game:UpdateGame()
	self.info.playerCount = self.info.leftPlayerCount + self.info.rightPlayerCount

	CustomNetTables:SetTableValue("Game", "info", Game.info)
	CustomNetTables:SetTableValue("Game", "time", Game.time)
end