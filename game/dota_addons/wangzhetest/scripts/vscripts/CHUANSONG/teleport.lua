function BreakGold(unit)
	local playerID = unit:GetPlayerOwnerID()
	local playerData = PlayerData:GetPlayerData(playerID)
	local player = PlayerResource:GetPlayer(playerID)

	if not playerData:IsAdherence() then
		local bounty = unit:GetGoldBounty()*2
		if bounty > 0 and not UnitManager:IsHire(unit) and not HasLabel(unit, "SummonUnit") then
			playerData:ModifyGold(bounty)
			playerData:IncrementBreakGold(bounty)

			local enemyPlayerPosition = playerData:GetFrontEnemyPlayerPosition()
			local enemyPlayerData = PlayerData:GetPlayerDataByPosition(enemyPlayerPosition)
			local portal = playerstarts:GetPortal(enemyPlayerPosition)
			if enemyPlayerData ~= nil then
				local enemyPlayerID = enemyPlayerData:GetPlayerID()
				if enemyPlayerData:IsAdherence() then
					enemyPlayerData:ModifyGold(bounty)
					SendOverheadEventMessage(PlayerResource:GetPlayer(enemyPlayerID), OVERHEAD_ALERT_GOLD, portal, bounty, player)
				end
			end

			SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, portal, bounty, player)
		end
	else
		unit:SetHealth(unit:GetHealth()*0.05)
	end

	if Game:GetFirstBloodPlayerID() == -1 and not UnitManager:IsHire(unit) and not HasLabel(unit, "SummonUnit") then
		Game:SetFirstBloodPlayerID(playerID)
		EmitGlobalSound("announcer_killing_spree_announcer_1stblood_01")

		local bounty = 28
		PlayerData:Look(
			function(_playerID, _playerData)
				if PlayerResource:GetTeam(playerID) == PlayerResource:GetTeam(_playerID) then
					_playerData:ModifyGold(bounty)
					SendOverheadEventMessage(PlayerResource:GetPlayer(_playerID), OVERHEAD_ALERT_GOLD, _playerData:GetHero(), bounty, player)
				end
			end
		)
		GameRules:SendCustomMessage("#firstblood_left", -1, 0)
	end
end

function OnStartLeft(trigger)
	local unit = trigger.activator

	if unit:GetTeam() ~= DOTA_TEAM_BADGUYS then return end

	BreakGold(unit)

	local ent = Entities:FindByName(nil, "r_portal"..tostring(RandomInt(1,7)))
	local point = ent:GetAbsOrigin()

	FindClearSpaceForUnit(unit, point, false)
	unit:EmitSound("Hero_KeeperOfTheLight.Recall.End")

	ExecuteOrderFromTable({
		UnitIndex = unit:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
		Position = Vector(point.x-8000, point.y, point.z),
	})
end

function OnStartRight(trigger)
	local unit = trigger.activator

	if unit:GetTeam() ~= DOTA_TEAM_GOODGUYS then return end

	BreakGold(unit)

	local ent = Entities:FindByName(nil, "l_portal"..tostring(RandomInt(1,7)))
	local point = ent:GetAbsOrigin()

	FindClearSpaceForUnit(unit, point, false)
	unit:EmitSound("Hero_KeeperOfTheLight.Recall.End")

	ExecuteOrderFromTable({
		UnitIndex = unit:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
		Position = Vector(point.x+8000, point.y, point.z),
	})
end

function StopHero(trigger)
	if trigger.activator:IsHero() then
		-- print("hero coming~~")
		local playerid = trigger.activator:GetPlayerOwnerID()
		local playerData = PlayerData:GetPlayerData(playerid)
		local hero = trigger.activator
		local player = hero:GetPlayerOwner()
		local startpoint = playerData:GetStartPoint()
		FindClearSpaceForUnit(hero, startpoint, true)--回到开始点
		BTFGeneral:ShowError("#StopHeroWarning", playerid) --警告信息
		hero:Stop()
	end
end
--]]



function order_portal_player(trigger)
	local nt=trigger.activator:GetTeamNumber()
	if nt == 2 then
		local unit = trigger.activator
		local playerData = PlayerData:GetPlayerDataByPosition(GetUnitLane(unit))
		if playerData then
			local OrderPoint = playerData:GetEndPoint()

			local newOrder = {                                        --发送攻击指令
					UnitIndex = unit:entindex(),
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					TargetIndex = nil, --Optional.  Only used when targeting units
					AbilityIndex = 0, --Optional.  Only used when casting abilities
					Position = OrderPoint, --Optional.  Only used when targeting the ground
					Queue = 0 --Optional.  Used for queueing up abilities
				}
			ExecuteOrderFromTable(newOrder)
		end
	end
end

function order_portal_player2 (trigger)
	local nt=trigger.activator:GetTeamNumber()
	if nt == 3 then
		local unit = trigger.activator
		local playerData = PlayerData:GetPlayerDataByPosition(GetUnitLane(unit)+4)
		if playerData then
			local OrderPoint = playerData:GetEndPoint()

			local newOrder = {                                        --发送攻击指令
					UnitIndex = unit:entindex(),
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					TargetIndex = nil, --Optional.  Only used when targeting units
					AbilityIndex = 0, --Optional.  Only used when casting abilities
					Position = OrderPoint, --Optional.  Only used when targeting the ground
					Queue = 0 --Optional.  Used for queueing up abilities
				}
			ExecuteOrderFromTable(newOrder)
		end
	end
end