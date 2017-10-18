if playerstarts == nil then
	playerstarts = class({})
end

if AllPlayers == nil then
	AllPlayers={}
end

if PlayerS == nil then
	PlayerS={}
end

--可选兵种列表
AllTypes = {}
AllTypes["Q"] = { "Q1_00","Q2_00","Q3_00","Q4_00","Q5_00","Q6_00","Q7_00","Q8_00", }
AllTypes["W"] = { "W1_00","W2_00","W3_00","W4_00","W5_00","W6_00","W7_00", }
AllTypes["E"] = { "E1_00","E2_00","E3_00","E4_00","E5_00","E6_00","E7_00", }	--
AllTypes["D"] = { "D1_00","D2_00","D3_00","D4_00","D5_00","D6_00","D7_00","D8_00", }
AllTypes["F"] = { "F1_00","F2_00","F3_00","F5_00","F6_00","F7_00","F8_00","F9_00", } --,"F4_00"
AllTypes["G"] = { "G1_00","G2_00","G3_00","G4_00","G5_00","G6_00","G7_00","G8_00", }
AllTypes["R"] = { "R1_00","R2_00","R3_00","R4_00","R5_00","R6_00","R7_00", }         --"R8_00",
AllTypes["X"] = { "X1_00","X2_00","X3_00","X4_00","X5_00","X6_00","X7_00",} --"X8_00", 

--升级科技树
building_tech = {}
building_tech.t_tech = {}
building_tech.t_tech["Q1_00"] = {"Q1_10"}
building_tech.t_tech["Q1_10"] = {"Q1_20", "Q1_21"}
building_tech.t_tech["Q1_20"] = {}
building_tech.t_tech["Q1_21"] = {}

building_tech.t_tech["Q2_00"] = {"Q2_10"}
building_tech.t_tech["Q2_10"] = {"Q2_20", "Q2_21"}
building_tech.t_tech["Q2_20"] = {}
building_tech.t_tech["Q2_21"] = {}

building_tech.t_tech["Q3_00"] = {"Q3_10"}
building_tech.t_tech["Q3_10"] = {"Q3_20","Q3_2z"}
building_tech.t_tech["Q3_20"] = {}
building_tech.t_tech["Q3_2z"] = {}

building_tech.t_tech["Q4_00"] = {"Q4_10"}
building_tech.t_tech["Q4_10"] = {"Q4_20"}
building_tech.t_tech["Q4_20"] = {}

building_tech.t_tech["Q5_00"] = {"Q5_10"}
building_tech.t_tech["Q5_10"] = {"Q5_20","Q5_21"}
building_tech.t_tech["Q5_20"] = {}
building_tech.t_tech["Q5_21"] = {}

building_tech.t_tech["Q6_00"] = {"Q6_10"}
building_tech.t_tech["Q6_10"] = {"Q6_20","Q6_21"}
building_tech.t_tech["Q6_20"] = {}
building_tech.t_tech["Q6_21"] = {}

building_tech.t_tech["W1_00"] = {"W1_10", "W1_11"}
building_tech.t_tech["W1_10"] = {"W1_20"}
building_tech.t_tech["W1_20"] = {}
building_tech.t_tech["W1_11"] = {"W1_21"}
building_tech.t_tech["W1_21"] = {}

building_tech.t_tech["W2_00"] = {"W2_10",}
building_tech.t_tech["W2_10"] = {"W2_20",}
building_tech.t_tech["W2_20"] = {}

building_tech.t_tech["W3_00"] = {"W3_10",}
building_tech.t_tech["W3_10"] = {"W3_20",}
building_tech.t_tech["W3_20"] = {}

building_tech.t_tech["W4_00"] = {"W4_10",}
building_tech.t_tech["W4_10"] = {"W4_20",}
building_tech.t_tech["W4_20"] = {}

building_tech.t_tech["W5_00"] = {"W5_10",}
building_tech.t_tech["W5_10"] = {"W5_20","W5_21",}
building_tech.t_tech["W5_20"] = {}
building_tech.t_tech["W5_21"] = {}

building_tech.t_tech["E1_00"] = {"E1_10",}
building_tech.t_tech["E1_10"] = {}


building_tech.t_tech["E2_00"] = {"E2_10","E2_11"}
building_tech.t_tech["E2_10"] = {}
building_tech.t_tech["E2_11"] = {}

building_tech.t_tech["G1_00"] = {"G1_10",}
building_tech.t_tech["G1_10"] = {}

building_tech.t_tech["E4_00"] = {"E4_10",}
building_tech.t_tech["E4_10"] = {}

building_tech.t_tech["E5_00"] = {"E5_10","E5_11",}
building_tech.t_tech["E5_10"] = {}
building_tech.t_tech["E5_11"] = {}

building_tech.t_tech["G2_00"] = {"G2_10","G2_11",}
building_tech.t_tech["G2_10"] = {}
building_tech.t_tech["G2_11"] = {}

building_tech.t_tech["E7_00"] = {"E7_10","E7_11",}
building_tech.t_tech["E7_10"] = {}
building_tech.t_tech["E7_11"] = {}

building_tech.t_tech["D1_00"] = {"D1_10",}
building_tech.t_tech["D1_10"] = {}

building_tech.t_tech["D2_00"] = {"D2_10",}
building_tech.t_tech["D2_10"] = {}

building_tech.t_tech["D3_00"] = {"D3_10",}
building_tech.t_tech["D3_10"] = {}

building_tech.t_tech["D4_00"] = {"D4_10",}
building_tech.t_tech["D4_10"] = {}

building_tech.t_tech["D5_00"] = {"D5_10",}
building_tech.t_tech["D5_10"] = {}

building_tech.t_tech["D6_00"] = {"D6_10","D6_11",}
building_tech.t_tech["D6_10"] = {}
building_tech.t_tech["D6_11"] = {}

building_tech.t_tech["D7_00"] = {"D7_10","D7_11",}
building_tech.t_tech["D7_10"] = {}
building_tech.t_tech["D7_11"] = {}

building_tech.t_tech["F1_00"] = {"F1_10",}
building_tech.t_tech["F1_10"] = {"F1_20",}
building_tech.t_tech["F1_20"] = {}

building_tech.t_tech["F2_00"] = {"F2_10",}
building_tech.t_tech["F2_10"] = {}

building_tech.t_tech["F3_00"] = {"F3_10","F3_11",}
building_tech.t_tech["F3_10"] = {}
building_tech.t_tech["F3_11"] = {}

building_tech.t_tech["F4_00"] = {"F4_10","F4_11",}
building_tech.t_tech["F4_10"] = {}
building_tech.t_tech["F4_11"] = {}

building_tech.t_tech["F5_00"] = {"F5_10",}
building_tech.t_tech["F5_10"] = {}

building_tech.t_tech["F6_00"] = {"F6_10","F6_11"}
building_tech.t_tech["F6_10"] = {}
building_tech.t_tech["F6_11"] = {}

building_tech.t_tech["G3_00"] = {"G3_10","G3_11"}
building_tech.t_tech["G3_10"] = {}
building_tech.t_tech["G3_11"] = {}

building_tech.t_tech["R1_00"] = {"R1_10","R1_11",}
building_tech.t_tech["R1_10"] = {}
building_tech.t_tech["R1_11"] = {}

building_tech.t_tech["R2_00"] = {"R2_10","R2_11",}
building_tech.t_tech["R2_10"] = {}
building_tech.t_tech["R2_11"] = {}

building_tech.t_tech["R3_00"] = {"R3_10",}
building_tech.t_tech["R3_10"] = {}

building_tech.t_tech["R4_00"] = {"R4_10","R4_11",}
building_tech.t_tech["R4_10"] = {}
building_tech.t_tech["R4_11"] = {}

building_tech.t_tech["R5_00"] = {"R5_10",}
building_tech.t_tech["R5_10"] = {}

building_tech.t_tech["G4_00"] = {"G4_10","G4_11"}
building_tech.t_tech["G4_10"] = {}
building_tech.t_tech["G4_11"] = {}

building_tech.t_tech["G5_00"] = {"G5_10","G5_11"}
building_tech.t_tech["G5_10"] = {}
building_tech.t_tech["G5_11"] = {}

building_tech.t_tech["X1_00"] = {"X1_10",}
building_tech.t_tech["X2_00"] = {"X2_10",}
building_tech.t_tech["X3_00"] = {"X3_10",}
building_tech.t_tech["X4_00"] = {"X4_10",}
building_tech.t_tech["X5_00"] = {"X5_10",}
building_tech.t_tech["X6_00"] = {"X6_10",}
building_tech.t_tech["X7_00"] = {"X7_10",}
building_tech.t_tech["X8_00"] = {"X8_10",}

building_tech.t_tech["Q7_00"] = {"Q7_10"}
building_tech.t_tech["Q7_10"] = {"Q7_20","Q7_21"}
building_tech.t_tech["Q7_20"] = {}
building_tech.t_tech["Q7_21"] = {}

building_tech.t_tech["W6_00"] = {"W6_10"}
building_tech.t_tech["W6_10"] = {"W6_20","W6_21"}
building_tech.t_tech["W6_20"] = {}
building_tech.t_tech["W6_21"] = {}

building_tech.t_tech["W7_00"] = {"W7_10"}
building_tech.t_tech["W7_10"] = {"W7_20"}
building_tech.t_tech["W7_20"] = {}

building_tech.t_tech["E3_00"] = {"E3_10","E3_11"}
building_tech.t_tech["E3_10"] = {}
building_tech.t_tech["E3_11"] = {}

building_tech.t_tech["E6_00"] = {"E6_10",}
building_tech.t_tech["E6_10"] = {}

building_tech.t_tech["D8_00"] = {"D8_10",}
building_tech.t_tech["D8_10"] = {}

building_tech.t_tech["R6_00"] = {"R6_10","R6_11"}
building_tech.t_tech["R6_10"] = {}
building_tech.t_tech["R6_11"] = {}

building_tech.t_tech["Q8_00"] = {"Q8_10"}
building_tech.t_tech["Q8_10"] = {"Q8_20"}
building_tech.t_tech["Q8_20"] = {}

building_tech.t_tech["F7_00"] = {"F7_10"}
building_tech.t_tech["F7_10"] = {}

building_tech.t_tech["F8_00"] = {"F8_10"}
building_tech.t_tech["F8_10"] = {}

building_tech.t_tech["G6_00"] = {"G6_10","G6_11"}
building_tech.t_tech["G6_10"] = {}
building_tech.t_tech["G6_11"] = {}

building_tech.t_tech["R7_00"] = {"R7_10"}
building_tech.t_tech["R7_10"] = {}

building_tech.t_tech["R8_00"] = {"R8_10","R8_00_JN"}
building_tech.t_tech["R8_10"] = {"R8_10_JN"}

building_tech.t_tech["F9_00"] = {"F9_10","F9_11"}
building_tech.t_tech["F9_10"] = {}
building_tech.t_tech["F9_11"] = {}

building_tech.t_tech["G7_00"] = {"G7_10","G7_11"}
building_tech.t_tech["G7_10"] = {}
building_tech.t_tech["G7_11"] = {}

building_tech.t_tech["G8_00"] = {"G8_11"}
--building_tech.t_tech["G8_10"] = {}
building_tech.t_tech["G8_11"] = {}


function playerstarts:playertable()

	for i = 1,8,1 do
	--for _, i in pairs( AllPlayers ) do
		if PlayerS[i]== nil then
			PlayerS[i]={}
		end
		--设置传送门马甲
		if i <= 4 then
			local left_p = Entities:FindByName(nil,"portal"..tostring(i))
			local por_left = CreateUnitByName("npc_dummy_portal",left_p:GetAbsOrigin(),true, nil, nil,2)

			PlayerS[i].Portal=por_left
		end

		if i >= 5 then
			local right_p = Entities:FindByName(nil,"portal"..tostring(i))
			local por_right = CreateUnitByName("npc_dummy_portal",right_p:GetAbsOrigin(),true, nil, nil,3)
			PlayerS[i].Portal=por_right
		end

	end

end


function playerstarts:init(hero) --英雄登场之后准备开始运行的函数
		--print("fst playerID is "..i)i
				  --local player = PlayerResource:GetPlayer(i)  
		local playerID = hero:GetPlayerOwnerID()
		local PlayerPosition = PlayerCalc:GetPlayerPositionByID(playerID)
		if PlayerS[PlayerPosition].Initialize == nil then
			PlayerS[PlayerPosition].Initialize = true
			PlayerS[PlayerPosition].Gold = 700                    --定义初始金钱 700   
			PlayerS[PlayerPosition].MVP_TotalGold = PlayerS[PlayerPosition].MVP_TotalGold + PlayerS[PlayerPosition].Gold
			PlayerResource:SetGold(playerID,PlayerS[PlayerPosition].Gold, false) --设置初始金钱   

			--table.insert( AllPlayers, PlayerPosition)                                                         --加入全部玩家队伍       
			if hero:HasInventory() then
				for item_index = 1, 6 do
					local item = CreateItem("item_score_"..item_index, PlayerS[PlayerPosition].Hero,PlayerS[PlayerPosition].Hero)
					hero:AddItem(item)
				end
			end

			local ent =  Entities:FindAllByName("player"..tostring(PlayerPosition)) --这里返回一个表
			--print("Spawn BuildBase Done")
			PlayerS[PlayerPosition].BuildBase = {}                                                              --设置初始的地基
			--print("playerID is  "..player:GetPlayerID() )
			PlayerS[PlayerPosition].buildtype = {}
			for k,supertype in pairs(PlayerS[PlayerPosition].BuildTable) do
				PlayerS[PlayerPosition].buildtype[supertype] = RandomInt(1, #AllTypes[supertype])
			end
			--设置测试兵种
			if _G.test_mode then
				-- PlayerS[PlayerPosition].buildtype["Q"]=3
				PlayerS[PlayerPosition].buildtype["W"]=5
				-- PlayerS[PlayerPosition].buildtype["E"]=1
				-- PlayerS[PlayerPosition].buildtype["D"]=7
				PlayerS[PlayerPosition].buildtype["F"]=2
				-- PlayerS[PlayerPosition].buildtype["G"]=7
				-- PlayerS[PlayerPosition].buildtype["R"]=7
				-- PlayerS[PlayerPosition].buildtype["X"]=6
			end

			for x,v in pairs (ent) do

				local p = v:GetAbsOrigin()
				local buildbase = UnitManager:CreateUnitByName("npc_dummy_build_base", p, false, playerID,PlayerResource:GetTeam(playerID)) --地基单位
				print(buildbase)
				local min = GetGroundPosition(p,buildbase)
				table.insert(PlayerS[PlayerPosition].Build, buildbase)
				--buildbase:SetOwner(hero) 
				buildbase:SetControllableByPlayer(playerID, true)
				--print(buildbase:GetPlayerOwnerID() )

				--buildbase.Player = player --设置地基的player
				buildbase:SetContextNum("Score", 0, 0)
				buildbase:SetContextNum("Sale", 0, 0)
				buildbase:SetContextNum("Food", 0, 0)
				--local fake = CreateUnitByName("npc_dummy_build_fake", p, false, nil, nil,PlayerResource:GetTeam(playerID)) --假地基 装饰用
				--if PlayerResource:GetTeam(playerID) == DOTA_TEAM_GOODGUYS then
					--AbilityManager:AddAndSet( fake, "effect_build_left" )
				--else
					--AbilityManager:AddAndSet( fake, "effect_build_right" )
				--end

				buildbase:SetOrigin(Vector(min.x,min.y,min.z+ 25.15))
				--fake:SetOrigin(Vector(min.x,min.y,min.z+ 25.15))



				playerstarts:RollBuilds(buildbase) -- （地基单位；重选哪种兵种,nil为全选；是否reroll）
				hero:FindAbilityByName("legion_rerollbuilds"):ApplyDataDrivenModifier(hero, buildbase, "modifier_rerollbuilds", {Duration=35})

					
			end

			local farmer_ent = Entities:FindByName(nil, "player_"..tostring(PlayerPosition).."_farmer_1") 
			local farmer = UnitManager:CreateUnitByName("npc_dummy_farmer", farmer_ent:GetAbsOrigin() , false, playerID,PlayerResource:GetTeam(playerID)) 
			table.insert(PlayerS[PlayerPosition].Farmer, farmer)
		end
end

function playerstarts:PrintAll()
	print("Now start to test PlayerInstanceFromIndex: ")
	for k,v in pairs({0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}) do
		p_player = PlayerInstanceFromIndex(v)
		print("The player gotten from ID " .. tostring(v) .. " is " .. tostring(p_player))
	end

	print("Now start to test PlayerResource:GetPlayer: ")
	for k,v in pairs({0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}) do
		p_player = PlayerResource:GetPlayer(v)
		print("The player gotten from ID " .. tostring(v) .. " is " .. tostring(p_player))
	end
end


function playerstarts:RollBuilds(unit) --(单位，字符串，True/False)
	local player = unit:GetPlayerOwnerID()
	local PlayerPosition  = PlayerCalc:GetPlayerPositionByID(player)

	for k,supertype in pairs(PlayerS[PlayerPosition].BuildTable) do
		local type_string = AllTypes[supertype][PlayerS[PlayerPosition].buildtype[supertype]]
		AbilityManager:AddAndSet( unit, type_string )
	end

end
