function RoundThinker(now)
	--------------------------采集--周期7秒----------------------------------------
	if now >= Game:GetNextEarnCrystalTime() then
		Game:SetNextEarnCrystalTime(now + Game:GetEarnCrystalTime())

		PlayerData:Look(
			function(playerID, playerData)
				local earnCrystalPer = 2 + playerData:GetCrystalTech()
				local nFarmerNum = playerData:GetFarmerNumber()
				playerData:LookFarmer(
					function(n, farmer)
						SendOverheadEventMessage(PlayerResource:GetPlayer(playerID), OVERHEAD_ALERT_HEAL, farmer, earnCrystalPer, nil)
					end
				)
				playerData:ModifyCrystal(earnCrystalPer*nFarmerNum)
			end
		)
	end
	---------------------------回合开始------------------------------------
	if now >= Game:GetNextRoundTime() then
		Game:SetNextRoundTime(now + Game:GetRoundTime())

		local round = Game:GetRound() + 1
		Game:SetRound(round)

		EmitGlobalSound("Tutorial.Quest.complete_01")

		local rightKing = Game:GetRightKing()
		local leftKing = Game:GetLeftKing()

		--------------------------离线判断------------------------------------------
		local team1Win = true
		local team2Win = true
		local isAllAbandoned = true
		local playerCount = 0
		PlayerData:Look(
			function(playerID, playerData)
				if PlayerResource:GetConnectionState(playerID) == DOTA_CONNECTION_STATE_ABANDONED then
					if Game:GetRound() <= 10 then
						Game:RankMode(false)
					end
				else
					playerCount = playerCount + 1
					isAllAbandoned = false
					if PlayerResource:GetTeam(playerID) == DOTA_TEAM_GOODGUYS then
						team2Win = false
					end
					if PlayerResource:GetTeam(playerID) == DOTA_TEAM_BADGUYS then
						team1Win = false
					end
				end
			end
		)
		if Game:GetPlayerCount() == playerCount then
			team1Win = false
			team2Win = false
			isAllAbandoned = false
		end
		GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("abandon_game"),
			function()
				if isAllAbandoned then
					Game:RankMode(false)
				end
				if team1Win then
					rightKing:RemoveModifierByName('modifier_never_dead')
					rightKing:Kill(nil, rightKing)
				end
				if team2Win then
					leftKing:RemoveModifierByName('modifier_never_dead')
					leftKing:Kill(nil, leftKing)
				end
				return nil
			end
		, 15)
		--------------------------王的技能------------------------------------------
		if round == 10 then
			AbilityManager:AddAndSet(leftKing,"jn_king_10")
			AbilityManager:AddAndSet(rightKing,"jn_king_10")
		end
		if round == 20 then
			AbilityManager:AddAndSet(leftKing,"jn_king_20_left")
			AbilityManager:AddAndSet(rightKing,"jn_king_20_right")
		end
		if round == 30 then
			AbilityManager:AddAndSet(leftKing,"jn_king_30_left")
			AbilityManager:AddAndSet(rightKing,"jn_king_30_right")
		end
		if round == 40 then
			AbilityManager:AddAndSet(leftKing,"jn_king_40")
			AbilityManager:AddAndSet(rightKing,"jn_king_40")
		end
		if round == 50 then
			AbilityManager:AddAndSet(leftKing,"jn_king_50")
			AbilityManager:AddAndSet(rightKing,"jn_king_50")
		end
		if round == 60 then
			AbilityManager:AddAndSet(leftKing,"jn_king_60")
			AbilityManager:AddAndSet(rightKing,"jn_king_60")
		end
		if round == 70 then
			AbilityManager:AddAndSet(leftKing,"jn_king_70_left")
			AbilityManager:AddAndSet(rightKing,"jn_king_70_right")
		end
		--------------------------玩家------------------------------------------
		PlayerData:Look(
			function(playerID, playerData)
				local player = PlayerResource:GetPlayer(playerID)
				local startPoint = playerData:GetStartPoint()
				local endPoint = playerData:GetEndPoint()
				-----------------------设置售价为半价----------------------------------
				playerData:LookNewBuildings(
					function(n, newBuilding)
						newBuilding:SetContextNum("Sale", newBuilding:GetContext("Score")/2 , 0)
						for i = 0, 5, 1 do
							local item = newBuilding:GetItemInSlot(i)
							if item then
								if item:GetName() == "item_Sale_Build" then
									item:SetLevel(2)
								end
							end
						end
					end
				)
				playerData:NewBuildingsCharge()
				--------------------------收入----------------------------------------
				playerData:ModifyGold(playerData:GetAllIncome())
				SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, playerData:GetHero(), playerData:GetAllIncome(), player)
				playerData:ModifyIncome(3, true)
				--------------------------离开玩家收入---------------------------------
				if playerData:IsAbandon() then
					local otherPlayerDatas = {}
					PlayerData:Look(
						function(_playerID, _playerData)
							if not _playerData:IsAbandon() and playerID ~= _playerID and PlayerResource:GetTeam(playerID) == PlayerResource:GetTeam(_playerID) then
								table.insert(otherPlayerDatas, _playerData)
							end
						end
					)
					if #otherPlayerDatas > 0 then
						local gold = playerData:GetGold()
						local crystal = playerData:GetCrystal()
						gold = gold - (gold % #otherPlayerDatas)
						crystal = crystal - (crystal % #otherPlayerDatas)

						local goldPer = gold / #otherPlayerDatas
						local crystalPer = crystal / #otherPlayerDatas

						playerData:ModifyGold(-gold)
						playerData:ModifyCrystal(-crystal)

						for _,_playerData in pairs(otherPlayerDatas) do
							_playerData:ModifyGold(goldPer)
							_playerData:ModifyCrystal(crystalPer)
						end
					end
				end
				--------------------------佣兵----------------------------------------
				local next_time = GameRules:GetGameTime() + 1
				GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("MercenariesCharge"),
					function()
						if GameRules:GetGameTime() >= next_time then
							playerData:LookNewMercenaries(
								function(n, newMercenary)
									newMercenary:RemoveAbility("kexuanmajia")
									newMercenary:RemoveModifierByName("modifier_kexuanmajia")
									FindClearSpaceForUnit(newMercenary, startPoint, true)  --完成传送

									local OrderPoint = newMercenary:GetAbsOrigin()
									OrderPoint.x = endPoint.x
									ExecuteOrderFromTable({
										UnitIndex = newMercenary:entindex(), 
										OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
										Position = OrderPoint,
									})
								end
							)
							playerData:NewMercenariesCharge()
							return nil
						end
						return 0
					end
				, 0)
				--------------------------冲锋----------------------------------------
				EmitGlobalSound("legion_commander_legcom_attack_15")
				EmitGlobalSound("Loot_Drop_Stinger_Ancient")--播放音效
				playerData:LookBuildings(
					function(n, building)
						if building:HasAbility("build_base") and building:GetPlayerOwnerID() == playerID then
							if building:GetUnitName() ~= "npc_unit_Q3_2z" and building:GetUnitName() ~= "npc_unit_R8_00_RT" and building:GetUnitName() ~= "npc_unit_R8_10_RT" then
								local unit = UnitManager:CreateUnitByBuilding(building)
							end
						end
					end
				)
			end
		)
		--------------------------护卫队------------------------------------------
		if round <= 100 then
			for left = 1,9 do --左边护卫队
				local leftHwd = CreateUnitByName("npc_unit_huweidui_left_BZ",Vector(-4160,20,265),false,nil,nil,DOTA_TEAM_GOODGUYS)
				CreateAandDSystem(leftHwd,"B","Z")
				--随着时间强化
				leftHwd:SetBaseDamageMin(round+5)
				leftHwd:SetBaseDamageMax(round+5)
				leftHwd:SetBaseMaxHealth(100+10*round)
	    		--leftHwd:SetHealth(100+10*round)
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
				CreateAandDSystem(rightHwd,"B","Z")
				--随着时间强化
				rightHwd:SetBaseDamageMin(round+5)
				rightHwd:SetBaseDamageMax(round+5)
				rightHwd:SetBaseMaxHealth(100+10*round)
				--print("hp is "..100+10*round)
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