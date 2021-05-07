function OnStartLeft(trigger) --黑暗方突破

	local nt=trigger.activator:GetTeamNumber() 
	if not(nt==2) then --不对光明方生效
	local x  =RandomInt(1,7)
	local ent = Entities:FindByName(nil,    "r_portal"..tostring(x)) --随机一个right王身后传送点

	local point=ent:GetAbsOrigin()
	local pid = trigger.activator:GetPlayerOwnerID()
	local PlayerPosition = PlayerCalc:GetPlayerPositionByID(pid)
	local money = trigger.activator:GetGoldBounty()*2 or 0
	local portal_dummy =  PlayerS[PlayerPosition-4].Portal
			--给突破者钱
		if PlayerS[PlayerPosition].Abhere == false  then --判断固守状态
			if money > 0 and not UnitManager:IsHire(trigger.activator) and not HasLabel(trigger.activator,"SummonUnit") then
				PlayerS[PlayerPosition].MVP_BreakGold = PlayerS[PlayerPosition].MVP_BreakGold + money
				local Gold = PlayerResource:GetGold(pid) 
				PlayerResource:SetGold(pid,Gold+money, false)
				PlayerS[PlayerPosition].MVP_TotalGold = PlayerS[PlayerPosition].MVP_TotalGold + money
				PopupGoldGain(portal_dummy,money) --金钱特效
				if PlayerS[PlayerPosition-4].Abhere then
					local enemypid = PlayerCalc:GetPlayerIDByPosition(PlayerPosition-4)
					Gold = PlayerResource:GetGold(enemypid) 
					PlayerResource:SetGold(enemypid,Gold+money/2, false)
					PlayerS[PlayerPosition-4].MVP_TotalGold = PlayerS[PlayerPosition-4].MVP_TotalGold + money/2
				end
			end
		else
			trigger.activator:SetHealth(trigger.activator:GetHealth()*0.05)
		end   
			--trigger.activator:EmitSound("Portal.Hero_Disappear") 
			trigger.activator:AddNewModifier(nil, nil, "modifier_phased", {duration=0.3})
			FindClearSpaceForUnit(trigger.activator, point, true)  --完成传送
			trigger.activator:EmitSound("Hero_KeeperOfTheLight.Recall.End") 
			local OrderPoint=Vector(point.x-8000 , point.y,point.z)

			local newOrder = {                                        --发送攻击指令
					UnitIndex = trigger.activator:entindex(), 
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					TargetIndex = nil, --Optional.  Only used when targeting units
					AbilityIndex = 0, --Optional.  Only used when casting abilities
					Position = OrderPoint, --Optional.  Only used when targeting the ground
					Queue = 0 --Optional.  Used for queueing up abilities
			 }
 
			ExecuteOrderFromTable(newOrder)

	if _G.FirstBlood == false and not UnitManager:IsHire(trigger.activator) and not HasLabel(trigger.activator,"SummonUnit") then
		_G.FirstBlood = true
		EmitGlobalSound("announcer_killing_spree_announcer_1stblood_01")--音效sounds/vo/announcer/ann_custom_first_blood_05.vsnd
		for _, i in pairs( AllPlayers ) do
			local playerid = PlayerCalc:GetPlayerIDByPosition(i)
			if PlayerResource:GetTeam(playerid) == nt then
				PlayerResource:SetGold(playerid,PlayerResource:GetGold(playerid) +28, false)
				PlayerS[i].MVP_TotalGold = PlayerS[i].MVP_TotalGold + 28
				PopupGoldGain(PlayerS[i].Hero,28)
			end
		end
		GameRules:SendCustomMessage("#firstblood_right", -1, 0)
	end



	end
end

--



function OnStartRight(trigger)

	local nt=trigger.activator:GetTeamNumber() 
	if not(nt==3) then --不对黑暗方生效
		local x  =RandomInt(1,7)
		local ent = Entities:FindByName(nil,    "l_portal"..tostring(x)) --随机一个left王身后传送点

		local point=ent:GetAbsOrigin()                                  
		local pid = trigger.activator:GetPlayerOwnerID()
		local PlayerPosition = PlayerCalc:GetPlayerPositionByID(pid)
		local money = trigger.activator:GetGoldBounty()*2 or 0
		local portal_dummy =  PlayerS[PlayerPosition+4].Portal
				--给突破者钱
			if PlayerS[PlayerPosition].Abhere == false  then
				if money > 0 and not UnitManager:IsHire(trigger.activator) and not HasLabel(trigger.activator,"SummonUnit") then
					PlayerS[PlayerPosition].MVP_BreakGold = PlayerS[PlayerPosition].MVP_BreakGold + money
					local Gold = PlayerResource:GetGold(pid)
					PlayerResource:SetGold(pid,Gold+money, false)
					PlayerS[PlayerPosition].MVP_TotalGold = PlayerS[PlayerPosition].MVP_TotalGold + money
					PopupGoldGain(portal_dummy,money) --金钱特效
					if PlayerS[PlayerPosition+4].Abhere then
						local enemypid = PlayerCalc:GetPlayerIDByPosition(PlayerPosition+4)
						Gold = PlayerResource:GetGold(enemypid) 
						PlayerResource:SetGold(enemypid,Gold+money/2, false)
						PlayerS[PlayerPosition+4].MVP_TotalGold = PlayerS[PlayerPosition+4].MVP_TotalGold + money/2
					end
				end
			else
				trigger.activator:SetHealth(trigger.activator:GetHealth()*0.05)
			end

		FindClearSpaceForUnit(trigger.activator, point, true)  --完成传送
		local OrderPoint=Vector(point.x+8000 , point.y,point.z)
		local newOrder = {                                        --发送攻击指令
						UnitIndex = trigger.activator:entindex(), 
						OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
						TargetIndex = nil, --Optional.  Only used when targeting units
						AbilityIndex = 0, --Optional.  Only used when casting abilities
						Position = OrderPoint, --Optional.  Only used when targeting the ground
						Queue = 0 --Optional.  Used for queueing up abilities
						 }
	 
		ExecuteOrderFromTable(newOrder)

		if _G.FirstBlood == false and not UnitManager:IsHire(trigger.activator) and not HasLabel(trigger.activator,"SummonUnit") then  --第一滴血
			_G.FirstBlood = true
			EmitGlobalSound("announcer_killing_spree_announcer_1stblood_01")--音效sounds/vo/announcer/ann_custom_first_blood_05.vsnd
			for _, i in pairs( AllPlayers ) do
				local playerid = PlayerCalc:GetPlayerIDByPosition(i)
				if PlayerResource:GetTeam(playerid) == nt then
					PlayerResource:SetGold(playerid,PlayerResource:GetGold(playerid) +28, false)
					PlayerS[i].MVP_TotalGold = PlayerS[i].MVP_TotalGold + 28
					PopupGoldGain(PlayerS[i].Hero,28)
				end
			end
			GameRules:SendCustomMessage("#firstblood_left", -1, 0)
		end

	end
end

function StopHero(trigger)
	if trigger.activator:IsHero() then
		-- print("hero coming~~")
		local playerid = trigger.activator:GetPlayerOwnerID()
		local PlayerPosition = PlayerCalc:GetPlayerPositionByID(playerid)
		local hero = trigger.activator
		local player=hero:GetPlayerOwner() 
		local startpoint = PlayerS[PlayerPosition].StartPoint
		FindClearSpaceForUnit(hero, startpoint, true)--回到开始点
		BTFGeneral:ShowError("#StopHeroWarning", playerid) --警告信息
		hero:Stop()
	end
end
--]]



function order_portal_player (trigger)
	local nt=trigger.activator:GetTeamNumber() 
	if nt == 2 then
		local unit = trigger.activator
		local ent =  PlayerS[GetUnitLane(unit)+4].Portal
		if ent then 
			local OrderPoint = ent:GetAbsOrigin() 

			local newOrder = {                                        --发送攻击指令
					UnitIndex = unit:entindex(), 
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					TargetIndex = nil, --Optional.  Only used when targeting units
					AbilityIndex = 0, --Optional.  Only used when casting abilities
					Position = OrderPoint + Vector(100, 0, 0), --Optional.  Only used when targeting the ground
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
		local ent =  PlayerS[GetUnitLane(unit)].Portal
		if ent then 
			local OrderPoint = ent:GetAbsOrigin() 

			local newOrder = {                                        --发送攻击指令
					UnitIndex = unit:entindex(), 
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					TargetIndex = nil, --Optional.  Only used when targeting units
					AbilityIndex = 0, --Optional.  Only used when casting abilities
					Position = OrderPoint + Vector(-100, 0, 0), --Optional.  Only used when targeting the ground
					Queue = 0 --Optional.  Used for queueing up abilities
				}
			ExecuteOrderFromTable(newOrder)
		end
	end
end