boss_left_controllable = -1
boss_right_controllable = -1
function SetBossControllable(PlayerPosition)
	local pid = PlayerCalc:GetPlayerIDByPosition(PlayerPosition)
	local boss
	if PlayerPosition <= 4 then
		boss = king_left
		boss_left_controllable = pid
	else
		boss = king_right
		boss_right_controllable = pid
	end
	boss:SetControllableByPlayer(pid, true)
	CustomGameEventManager:Send_ServerToAllClients("updatebosscontrollable",{player=pid,team=PlayerResource:GetTeam(pid)})
end

function SetBossControllableEvent(index,keys)
	local PlayerPosition = PlayerCalc:GetPlayerPositionByID(keys.PlayerID)
	local boss
	if PlayerPosition <= 4 then
		boss = king_left
	else
		boss = king_right
	end
	PlayerResource:SetCameraTarget(keys.PlayerID, boss)
	SetBossControllable(PlayerPosition)
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("camera_later"), function() PlayerResource:SetCameraTarget(keys.PlayerID, nil)  end, 0.2)
end