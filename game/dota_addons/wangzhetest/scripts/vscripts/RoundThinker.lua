RoundThinker_i =0
RoundThinker_wave = 0
RoundThinker_next = 0
RoundThinker_lumber_i = 0
RoundThinker_Period = 38
RoundThinker_Last_time1 = 0
RoundThinker_Last_time2 = 0
function GetRound()
	return RoundThinker_wave
end
function SetLastTime(time,mode)
	if mode == 1 then
		RoundThinker_Last_time1 = time
	elseif mode == 2 then
		RoundThinker_Last_time2 = time
	end
end
function RoundThinker(now)
	--------------------------采集--周期7秒----------------------------------------
	if now - RoundThinker_Last_time2 >= 7 then
		RoundThinker_Last_time2 = now
		for _, PlayerPosition in pairs( AllPlayers ) do
			local Lumber = PlayerS[PlayerPosition].Lumber
			local Tech = PlayerS[PlayerPosition].Tech
			local Farmer = PlayerS[PlayerPosition].FarmerNum
			if Lumber and Tech and Farmer then
				PlayerS[PlayerPosition].Lumber  =  Lumber + Farmer*(2+Tech)
				PlayerS[PlayerPosition].MVP_TotalLumer  =  PlayerS[PlayerPosition].MVP_TotalLumer + Farmer*(2+Tech)
				for __,farmer in pairs (PlayerS[PlayerPosition].Farmer) do
					PopupHealing(farmer, 2+Tech)
				end
			end
		end
	end
	---------------------------回合开始------------------------------------
	if now - RoundThinker_Last_time1  >= RoundThinker_Period then
		RoundThinker_Last_time1 = now
		RoundThinker_wave = RoundThinker_wave + 1
		if RoundThinker_wave == 10 then
			AbilityManager:AddAndSet(king_left,"jn_king_10")
			AbilityManager:AddAndSet(king_right,"jn_king_10")
		end
		if RoundThinker_wave == 20 then
			AbilityManager:AddAndSet(king_left,"jn_king_20_left")
			AbilityManager:AddAndSet(king_right,"jn_king_20_right")
		end
		if RoundThinker_wave == 30 then
			AbilityManager:AddAndSet(king_left,"jn_king_30_left")
			AbilityManager:AddAndSet(king_right,"jn_king_30_right")
		end
		if RoundThinker_wave == 40 then
			AbilityManager:AddAndSet(king_left,"jn_king_40")
			AbilityManager:AddAndSet(king_right,"jn_king_40")
		end
		if RoundThinker_wave == 50 then
			AbilityManager:AddAndSet(king_left,"jn_king_50")
			AbilityManager:AddAndSet(king_right,"jn_king_50")
		end
		if RoundThinker_wave == 60 then
			AbilityManager:AddAndSet(king_left,"jn_king_60")
			AbilityManager:AddAndSet(king_right,"jn_king_60")
		end
		if RoundThinker_wave == 70 then
			AbilityManager:AddAndSet(king_left,"jn_king_70_left")
			AbilityManager:AddAndSet(king_right,"jn_king_70_right")
		end
		for _, PlayerPosition in pairs( AllPlayers ) do
			--print("Now make a round of player " .. tostring(pid))
			local pid = PlayerCalc:GetPlayerIDByPosition(PlayerPosition)
			local Gold = PlayerResource:GetGold(pid) 
			local Lumber = PlayerS[PlayerPosition].Lumber
			local CurFood = PlayerS[PlayerPosition].CurFood
			local FullFood = PlayerS[PlayerPosition].FullFood
			local Tech = PlayerS[PlayerPosition].Tech
			local Farmer = PlayerS[PlayerPosition].FarmerNum
			local Score = PlayerS[PlayerPosition].Score
			local BaseIncome = PlayerS[PlayerPosition].BaseIncome
			local Income = PlayerS[PlayerPosition].Income
			local Portal_point = PlayerS[PlayerPosition].StartPoint
			-----------------------设置售价为半价----------------------------------
			for __, newb in pairs( PlayerS[PlayerPosition].NewBuild ) do
					--print(newb.Sale)
				if IsValidEntity(newb) then
					if newb:IsAlive()  then
						newb:SetContextNum("Sale", newb:GetContext("Score")/2 , 0)
						for i=0,5,1 do
							local item = newb:GetItemInSlot(i)
							if item then
								if item:GetName() == "item_Sale_Build" then
									item:SetLevel(2)
								end
							end
						end
					end
				end
			end
			PlayerS[PlayerPosition].NewBuild={}
			--------------------------收入------------------------------------------
			PlayerResource:SetGold(pid,Gold + BaseIncome + Income, false)
			PlayerS[PlayerPosition].MVP_TotalGold = PlayerS[PlayerPosition].MVP_TotalGold + BaseIncome + Income
			PopupGoldGain(PlayerS[PlayerPosition].Hero,BaseIncome)
			if Income ~= 0 then
				PopupGoldGain(PlayerS[PlayerPosition].Hero,Income)
			end
			PlayerS[PlayerPosition].BaseIncome = BaseIncome + 3
			--------------------------收入------------------------------------------
			if PlayerS[PlayerPosition].Abandon then
				local gold = PlayerResource:GetGold(pid)
				local lumber = PlayerS[PlayerPosition].Lumber
				local pps = {}
				for _, OtherPlayerPosition in pairs( AllPlayers ) do
					if PlayerCalc:GetPlayerIDByPosition(OtherPlayerPosition) ~= pid and not PlayerS[OtherPlayerPosition].Abandon then
						if PlayerResource:GetTeam(PlayerCalc:GetPlayerIDByPosition(OtherPlayerPosition)) == PlayerResource:GetTeam(pid) then
							table.insert(pps,OtherPlayerPosition)
						end
					end
				end
				if #pps > 0 then
					gold = gold - (gold % #pps)
					lumber = lumber - (lumber % #pps)
					PlayerResource:SetGold(pid, PlayerResource:GetGold(pid) - gold, false)
					PlayerS[PlayerPosition].Lumber = PlayerS[PlayerPosition].Lumber - lumber
					for v,OtherPlayerPosition in pairs(pps) do
						local Otherpid = PlayerCalc:GetPlayerIDByPosition(OtherPlayerPosition)
						PlayerResource:SetGold(Otherpid, PlayerResource:GetGold(Otherpid) + (lumber/#pps), false)
						PlayerS[OtherPlayerPosition].Lumber = PlayerS[OtherPlayerPosition].Lumber + (lumber/#pps)
					end
				end
			end
			--------------------------佣兵------------------------------------------

			local last_time = GameRules:GetGameTime()
			GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("HireUnit"),
				function()
					local now = GameRules:GetGameTime()
					if now - last_time >= 1 then
						for __, newh in pairs( PlayerS[PlayerPosition].NewHire ) do
							FindClearSpaceForUnit(newh, Portal_point, true)  --完成传送
							newh:RemoveAbility( "kexuanmajia" )
							newh:RemoveModifierByName("modifier_kexuanmajia")
							local OrderPoint
							if PlayerPosition <= 4 then
								OrderPoint=Vector(8500,0,0)+Portal_point
							else
								OrderPoint=Vector(-8500,0,0)+Portal_point
							end
							OrderPoint.x = math.min(OrderPoint.x,5120)
							OrderPoint.x = math.max(OrderPoint.x,-5120)

							--trigger.activator:MoveToPositionAggressive(point2)
							local newOrder = {                                        --发送攻击指令
								UnitIndex = newh:entindex(), 
								OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
								TargetIndex = nil, --Optional.  Only used when targeting units
								AbilityIndex = 0, --Optional.  Only used when casting abilities
								Position = OrderPoint, --Optional.  Only used when targeting the ground
								Queue = 0 --Optional.  Used for queueing up abilities
							}

							ExecuteOrderFromTable(newOrder)
						end
						PlayerS[PlayerPosition].NewHire={}
						return nil
					end
					return 0
				end
			, 0)

			--------------------------冲锋------------------------------------------
			EmitGlobalSound("legion_commander_legcom_attack_15")
			EmitGlobalSound("Loot_Drop_Stinger_Ancient")--播放音效

			local build_table = Entities:FindAllByClassnameWithin("npc_dota_creature", Portal_point , 3000)
			for _,build in pairs(build_table) do
				if IsValidEntity(build) then
					if build:IsAlive() == true and build:GetUnitName() ~= "npc_unit_Q3_2z" and build:GetUnitName() ~= "npc_unit_R8_00_RT" and build:GetUnitName() ~= "npc_unit_R8_10_RT" then
						if build:HasAbility("build_base") and build:GetPlayerOwnerID() == pid then
							local CFunit = UnitManager:CreateUnitByBuilding( build )
						end
					end
				end
			end
		end
		--------------------------护卫队------------------------------------------
		if RoundThinker_wave <= 100 then
			for left = 1,9 do --左边护卫队
				local leftHwd = CreateUnitByName("npc_unit_huweidui_left_BZ",Vector(-4160,20,265),false,nil,nil,DOTA_TEAM_GOODGUYS)
				AandDSystem(leftHwd)
				--随着时间强化
				leftHwd:SetBaseDamageMin(RoundThinker_wave+5)
				leftHwd:SetBaseDamageMax(RoundThinker_wave+5)
				leftHwd:SetBaseMaxHealth(100+10*RoundThinker_wave)
	    		--leftHwd:SetHealth(100+10*RoundThinker_wave)
				local Order = 
				{                                        --发送攻击指令
					UnitIndex = leftHwd:entindex(), 
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					TargetIndex = nil, 
					AbilityIndex = 0, 
					Position = Vector(4160,22.8232,265), 
					Queue = 0 
				}
				leftHwd:SetContextThink(DoUniqueString("order_later"), function() ExecuteOrderFromTable(Order) end, 0)
				leftHwd:AddNewModifier(nil, nil, "modifier_phased", {duration=0.1})
			end
			for right = 1,9 do --右边护卫队
				local rightHwd = CreateUnitByName("npc_unit_huweidui_right_BZ",Vector(4160,20,265),false,nil,nil,DOTA_TEAM_BADGUYS)
				AandDSystem(rightHwd)
				--随着时间强化
				rightHwd:SetBaseDamageMin(RoundThinker_wave+5)
				rightHwd:SetBaseDamageMax(RoundThinker_wave+5)
				rightHwd:SetBaseMaxHealth(100+10*RoundThinker_wave)
				--print("hp is "..100+10*RoundThinker_wave)
				local Order = 
				{                                        --发送攻击指令
					UnitIndex = rightHwd:entindex(), 
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					TargetIndex = nil, 
					AbilityIndex = 0, 
					Position = Vector(-4172.98,22.8232,265), 
					Queue = 0 
				}							            
				rightHwd:SetContextThink(DoUniqueString("order_later"), function() ExecuteOrderFromTable(Order) end, 0)
				rightHwd:AddNewModifier(nil, nil, "modifier_phased", {duration=0.1})
			end
		end
	end
end