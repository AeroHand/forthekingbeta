leftController = leftController or -1
rightController = rightController or -1
function SetBossControllable(playerID)
	local king
	if PlayerResource:GetTeam(playerID) == DOTA_TEAM_GOODGUYS then
		king = Game:GetLeftKing()
		leftController = playerID
	elseif PlayerResource:GetTeam(playerID) == DOTA_TEAM_BADGUYS then
		king = Game:GetRightKing()
		rightController = playerID
	end

	king:SetControllableByPlayer(playerID, true)
	CustomGameEventManager:Send_ServerToAllClients("updatebosscontrollable", {left=leftController,right=rightController})
end
function IsControllableByPlayer(playerID)
	if PlayerResource:GetTeam(playerID) == DOTA_TEAM_BADGUYS then
		return playerID == rightController
	end
	return playerID == leftController
end
function SetBossControllableEvent(index, keys)
	local playerID = keys.PlayerID
	if not IsControllableByPlayer(playerID) then
		SetBossControllable(playerID)
	end
end