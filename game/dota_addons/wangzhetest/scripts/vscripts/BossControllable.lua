function SetBossControllableEvent(index, keys)
	local playerID = keys.PlayerID
	local king = Game:GetLeftKing()
	if PlayerResource:GetTeam(playerID) == DOTA_TEAM_BADGUYS then
		king = Game:GetRightKing()
	end
	king:SetControllableByPlayer(playerID, true)
end