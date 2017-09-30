--[[Demon制作]]
--生命达到临界值事件动作表
HealthChangeEventAction={
	jn_Q1_20_passive=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						local count = math.floor((100-caster:GetHealthPercent())/10)
						if count > 0 then
							if not caster:HasModifier("modifier_jn_Q1_20_passive") then
								ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_Q1_20_passive",nil)
							end
							caster:SetModifierStackCount("modifier_jn_Q1_20_passive",caster,count)
						else
							caster:RemoveModifierByName("modifier_jn_Q1_20_passive")
						end
					end
	,
	jn_Q1_21b		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
							caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
							ab:StartCooldown(99999)
						end
					end
	,
	jn_Q4_10_1		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if caster:HasModifier("modifier_jn_Q4_10_buff2") then
							caster:RemoveModifierByName("modifier_jn_Q4_10_buff2")
						end
						if not caster:HasModifier("modifier_jn_Q4_10_buff1") then
							ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_Q4_10_buff1",nil)
						end
					end
	,
	jn_Q4_10_2		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if caster:HasModifier("modifier_jn_Q4_10_buff1") then
							caster:RemoveModifierByName("modifier_jn_Q4_10_buff1")
						end
						if not caster:HasModifier("modifier_jn_Q4_10_buff2") then
							ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_Q4_10_buff2",nil)
						end
					end
	,
	jn_Q4_20_1		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if caster:HasModifier("modifier_jn_Q4_20_buff2") then
							caster:RemoveModifierByName("modifier_jn_Q4_20_buff2")
						end
						if not caster:HasModifier("modifier_jn_Q4_20_buff1") then
							ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_Q4_20_buff1",nil)
						end
					end
	,
	jn_Q4_20_2		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if caster:HasModifier("modifier_jn_Q4_20_buff1") then
							caster:RemoveModifierByName("modifier_jn_Q4_20_buff1")
						end
						if not caster:HasModifier("modifier_jn_Q4_20_buff2") then
							ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_Q4_20_buff2",nil)
						end
					end
	,
	jn_D2_10b		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
							caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
							ab:StartCooldown(99999)
						end
					end
	,
	jn_X2_00b		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
							caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
						end
					end
	,
	jn_D8_00_1		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if not caster:HasModifier("modifier_jn_D8_00_buff") then
							ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_D8_00_buff",nil)
						end
					end
	,
	jn_D8_00_2		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if caster:HasModifier("modifier_jn_D8_00_buff") then
							caster:RemoveModifierByName("modifier_jn_D8_00_buff")
						end
					end
	,
	jn_D8_10_1		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if not caster:HasModifier("modifier_jn_D8_10_buff") then
							ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_D8_10_buff",nil)
						end
					end
	,
	jn_D8_10_2		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if caster:HasModifier("modifier_jn_D8_10_buff") then
							caster:RemoveModifierByName("modifier_jn_D8_10_buff")
						end
					end
	,
	jn_Q8_10_1		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if caster:HasModifier("modifier_jn_Q8_10_buff") then
							caster:RemoveModifierByName("modifier_jn_Q8_10_buff")
						end
					end
	,
	jn_Q8_10_2		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if not caster:HasModifier("modifier_jn_Q8_10_buff") then
							ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_Q8_10_buff",nil)
						end
					end
	,
	jn_Q8_20_1		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if caster:HasModifier("modifier_jn_Q8_20_buff") then
							caster:RemoveModifierByName("modifier_jn_Q8_20_buff")
						end
					end
	,
	jn_Q8_20_2		=function(keys)
						local caster = keys.caster
						local ab = keys.ability
						if not caster:HasModifier("modifier_jn_Q8_20_buff") then
							ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_Q8_20_buff",nil)
						end
					end
	,
}

--一些函数
	function Kill(keys)
		local target
		if keys.Target == "CASTER" then
			target = keys.caster
		elseif keys.Target == "TARGET" then
			target = keys.target
		elseif keys.Target == "UNIT" then
			target = keys.unit
		elseif keys.Target == "ATTACKER" then
			target = keys.attacker
		else
			target = keys.caster
		end
		local attacker
		if keys.Attacker == "CASTER" then
			attacker = keys.caster
		elseif keys.Attacker == "TARGET" then
			attacker = keys.target
		elseif keys.Attacker == "UNIT" then
			attacker = keys.unit
		elseif keys.Attacker == "ATTACKER" then
			attacker = keys.attacker
		else
			attacker = target
		end
		if attacker == target then
			target:ForceKill(true)
		end
	end
	function SpellDamage(keys)
		local u_caster = keys.caster
		local u_target
		if keys.Target == "CASTER" then
			u_target = keys.caster
		elseif keys.Target == "TARGET" then
			u_target = keys.target
		elseif keys.Target == "UNIT" then
			u_target = keys.unit
		elseif keys.Target == "ATTACKER" then
			u_target = keys.attacker
		else
			u_target = keys.caster
		end
		if u_caster and u_target then
			DamageManager:SpellDamage(u_caster,u_target,keys.Damage)
		end
	end
	function CreateIllusionByUnit(hunit,ability,vposition,fincomingdamage,foutgoingdamage,fduration)
		local unitName = hunit:GetUnitName()
		local unitAngles = hunit:GetAngles()
		local illusion = UnitManager:CreateUnitByName(unitName, vposition, true, hunit:GetPlayerOwnerID(), hunit:GetTeamNumber())
		illusion:SetControllableByPlayer(-1, true)
		illusion:SetAngles( unitAngles.x, unitAngles.y, unitAngles.z )
		CreateAandDSystem(illusion,UnitManager:GetAttackTypeFromName( unitName ),UnitManager:GetDefendTypeFromName( unitName ))
		illusion:AddNewModifier(hunit, ability, "modifier_illusion", { duration = fduration, outgoing_damage = foutgoingdamage, incoming_damage = fincomingdamage })
		illusion:MakeIllusion()
		illusion:SetHealth(hunit:GetHealth())
		illusion:SetMaximumGoldBounty(0)
		illusion:SetMinimumGoldBounty(0)
		AddLabel(illusion,"SummonUnit")
		AttackOrder({caster=illusion})
		return illusion
	end
	--设置无碰撞
	NoCollisionAbility = "ability_nocollision"
	function SetUnitNoCollision(hTarget,bFlag)
		if bFlag then
			hTarget:AddAbility(NoCollisionAbility)
			local ab = hTarget:FindAbilityByName(NoCollisionAbility)
			ab:SetLevel(1)
			ab:ApplyDataDrivenModifier(hTarget,hTarget,"modifier_"..NoCollisionAbility, nil)
			hTarget:RemoveAbility(NoCollisionAbility)
		else
			hTarget:RemoveModifierByName("modifier_"..NoCollisionAbility)
		end
		return
	end
	--击退函数：击退者，被击退者，方向，距离，持续时间，落地高度，最高高度，是否破坏树，破坏树的范围
	function KnockBackFunction(t,sheight,mheight,eheight,T)
		return (2*eheight+2*sheight-4*mheight)/(T*T)*(t*t)+(4*mheight-eheight-3*sheight)/T*t+sheight
	end
	function KnockBack(hCaster,hTarget,vAngle,fDistance,fDuration,fHeight,fMaxHeight,bKilltree,fKilltreeRange,hFunction)
		local period = 0.03125
		local g = -9.8
		local vVectorStart = hTarget:GetAbsOrigin()
		local vVectorEnd = vVectorStart+vAngle*fDistance
		fHeight = GetGroundPosition(vVectorEnd,hTarget).z + fHeight
		fMaxHeight = vVectorStart.z + fMaxHeight
		local Velocity = (vVectorEnd - vVectorStart) / fDuration * period
		local time = 0.
		local TVector = hTarget:GetAbsOrigin()
		local last_time = GameRules:GetGameTime()-period
		if fDuration > 0 then
			SetUnitNoCollision(hTarget,true)
			hTarget:SetContextThink("KnckBack",
				function()
					local now = GameRules:GetGameTime()
					if now - last_time >= period then
						last_time = now
						time = time + period
						TVector = TVector + Velocity
						TVector.z = KnockBackFunction(time,vVectorStart.z,fMaxHeight,fHeight,fDuration)
						hTarget:SetAbsOrigin(TVector)
						if bKilltree then
							GridNav:DestroyTreesAroundPoint( TVector, fKilltreeRange, false)
						end
						if time > fDuration then
							hTarget:SetAbsOrigin(vVectorEnd)
							SetUnitNoCollision(hTarget,false)
							if hFunction then
								hFunction()
							end
							return nil
						end
					end
					return 0
				end
			, 0)
		end
	end
	--print数据函数 用来Debug
	function Print(event)
		local caster = event.caster 
		local target = event.target
		local unit = event.unit
		local attacker = event.attacker
		local ability = event.ability

		-- Tables
		local target_points = event.target_points
		local target_entities = event.target_entities

		-- Extra parameter
		local EventName = event.EventName
		local Damage = event.Damage

		print("**"..EventName.."**")
		print("~~~")
		if caster then print("CASTER: "..caster:GetUnitName()) end
		if target then print("TARGET: "..target:GetUnitName()) end
		if unit then print("UNIT: "..unit:GetUnitName()) end
		if attacker then print("ATTACKER: "..attacker:GetUnitName()) end
		if Damage then print("DAMAGE: "..Damage) end

		if target_points then
			for k,v in pairs(target_points) do
				print("POINT",k,v)
			end
		end

		-- Multiple Targets
		if target_entities then
			for k,v in pairs(target_entities) do
				print("TARGET "..k..": "..v:GetUnitName())
			end
		end
		--DeepPrintTable(event)
		print("~~~")
	end
	--闪电链
	function Lightning(caster,old,target,damage,period,radius,count,count_const,_group)
		if IsValidEntity(old) and IsValidEntity(target) then
			local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf",PATTACH_ABSORIGIN, old)
			ParticleManager:SetParticleControlEnt(particleId,0,old,PATTACH_POINT_FOLLOW,"attach_hitloc",old:GetOrigin(),true)
			ParticleManager:SetParticleControlEnt(particleId,1,target,PATTACH_POINT_FOLLOW,"attach_hitloc",target:GetOrigin(),true)
			ParticleManager:ReleaseParticleIndex(particleId)
			target:EmitSound("Hero_Zuus.ArcLightning.Cast")
			DamageManager:SpellDamage(caster,target,damage)
			if count < count_const then
				table.insert(_group,target)
				local last_time = GameRules:GetGameTime()
				caster:SetContextThink(DoUniqueString("Lightning"),
					function()
						local now = GameRules:GetGameTime()
						if now - last_time >= period then
							local targets = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, true)
							for i,unit in pairs(targets) do
								for n,u in pairs(_group) do
									if unit == u then
										table.remove(targets,i)
									end
								end
							end
							local new
							if #targets > 0 then
								new = targets[1]
							end
							if new then
								Lightning(caster,target,new,damage,period,radius,count+1,count_const,_group)
							end
							return nil
						end
						return 0
					end
				,0)
			end
		end
	end
	--增加血上限
	function AddHealth(keys)
		local u_unit
		if keys.TargetUnit == "CASTER" then
			u_unit = keys.caster
		elseif keys.TargetUnit == "TARGET" then
			u_unit = keys.target
		elseif keys.TargetUnit == "UNIT" then
			u_unit = keys.unit
		elseif keys.TargetUnit == "ATTACKER" then
			u_unit = keys.attacker
		else
			u_unit = keys.caster
		end
		if u_unit then
			u_unit:SetBaseMaxHealth(u_unit:GetBaseMaxHealth()+keys.ExtraHealth)
		end
	end
	--召唤单位动作
	function Spawn(keys)
		local caster = keys.caster
		local spawnunit = keys.target
		UnitManager:SummonUnit(caster,spawnunit)
	end
	--生命到达临界值事件
	function HealthChangeEvent( keys )
		local caster = keys.caster
		local health
		if keys.IsPercent == 1 then
			health = caster:GetHealthPercent()
		end
		if keys.IsPercent == 2 then
			health = caster:GetHealth()
		end
		if health >= keys.Value then
			if keys.Action1 ~= "" then
				HealthChangeEventAction[keys.Action1](keys)
			end
		else
			if keys.Action2 ~= "" then
				HealthChangeEventAction[keys.Action2](keys)
			end
		end
	end
	--发布攻击命令（用来让释放技能过后的单位继续攻击的命令）
	function AttackOrder(keys)
		local u_unit
		if keys.TargetUnit == "CASTER" then
			u_unit = keys.caster
		elseif keys.TargetUnit == "TARGET" then
			u_unit = keys.target
		elseif keys.TargetUnit == "UNIT" then
			u_unit = keys.unit
		elseif keys.TargetUnit == "ATTACKER" then
			u_unit = keys.attacker
		else
			u_unit = keys.caster
		end
		local v_order
		if PlayerResource:GetTeam(u_unit:GetPlayerOwnerID()) == DOTA_TEAM_GOODGUYS then
			v_order = Vector( 8500, 0, 0 )+u_unit:GetOrigin()
		end
		if PlayerResource:GetTeam(u_unit:GetPlayerOwnerID()) == DOTA_TEAM_BADGUYS then
			v_order = Vector( -8500, 0, 0 )+u_unit:GetOrigin()
		end
		v_order.x = math.min(v_order.x,6400)
		v_order.x = math.max(v_order.x,-6400)
		local t_order = 
			{
				UnitIndex = u_unit:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
				TargetIndex = nil,
				AbilityIndex = 0,
				Position = v_order,
				Queue = 0
			}
		u_unit:SetContextThink(DoUniqueString("order_later"), function() ExecuteOrderFromTable(t_order) end, 0.1)
	end
	--标记单位
	function AddLabel(u_unit,Label)
		if u_unit == nil then
			return nil
		end
		local ab = u_unit:FindAbilityByName("ability_dummy")
		ab:ApplyDataDrivenModifier(u_unit, u_unit, "label_"..Label, nil)
	end
	function HasLabel(u_unit,Label)
		if u_unit == nil then
			return false
		end
		if u_unit:HasModifier("label_"..Label) then
			return true
		end
		return false
	end
	function RemoveLabel(u_unit,Label)
		if u_unit == nil then
			return nil
		end
		if HasLabel(u_unit,Label) then
			u_unit:RemoveModifierByName("label_"..Label)
		end
	end
	function UnitLabel(keys)
		local u_unit
		if keys.TargetUnit == "CASTER" then
			u_unit = keys.caster
		elseif keys.TargetUnit == "TARGET" then
			u_unit = keys.target
		elseif keys.TargetUnit == "UNIT" then
			u_unit = keys.unit
		elseif keys.TargetUnit == "ATTACKER" then
			u_unit = keys.attacker
		else
			u_unit = keys.caster
		end
		if keys.Label then
			SetLabel(u_unit,keys.Label)
		end
	end
	--打断动作
	function InterruptUnit(keys)
		local u_unit = keys.caster
		u_unit:Interrupt()
	end
--王技能
function jn_king_30_effect(keys)
	local caster = keys.caster
	local target = keys.target
	local particleId = ParticleManager:CreateParticle(keys.EffectName, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlOrientation(particleId, 1, (target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized(), Vector(0,0,0), Vector(0,0,0))
	ParticleManager:SetParticleControl(particleId, 1, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particleId)
end
function jn_king_70(keys)
	local caster = keys.caster
	local target = keys.target
	local ab = keys.ability
	target:Kill(ab, caster)
end
--兵种技能
function jn_Q1_20(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		if caster:GetHealthPercent() <= 35 then
			caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_Q1_21a(keys)
	local caster = keys.caster
	local ab = keys.ability
	local radius = ab:GetSpecialValueFor("radius")
	local chance = ab:GetSpecialValueFor("chance")
	local damage = ab:GetSpecialValueFor("damage")
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		if RandomInt(0, 100) <= chance and caster:GetHealthPercent() <= 35 then
			local particleId = ParticleManager:CreateParticle("particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_aftershock_egset.vpcf", PATTACH_WORLDORIGIN, caster)
			ParticleManager:SetParticleControl(particleId, 0, caster:GetOrigin())
			ParticleManager:SetParticleControl(particleId, 1, Vector(radius,radius,radius))
			ParticleManager:ReleaseParticleIndex(particleId)
			caster:EmitSound("Hero_EarthShaker.Totem")
			local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, 0, 0, true)
			for i,target in pairs(targets) do
				DamageManager:SpellDamage(caster,target,damage)
			end
			ab:StartCooldown(ab:GetCooldown(ab:GetLevel()))
		end
	end
end
function jn_Q2_10(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
		ab:StartCooldown(99999)
	end
end
function jn_Q2_20a(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
		ab:StartCooldown(99999)
	end
end
function jn_Q2_20b(keys)
	local caster = keys.caster
	local target = keys.target
	local ab = caster:FindAbilityByName("jn_Q2_20b")
	if target:GetUnitName() == keys.Name1 and not target:HasAbility("build_base") then
		ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_Q2_20b_buff1", nil)
	end
	if target:GetUnitName() == keys.Name2 and not target:HasAbility("build_base") then
		ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_Q2_20b_buff2", nil)
	end
	if target:GetUnitName() == keys.Name3 and not target:HasAbility("build_base") then
		ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_Q2_20b_buff3", nil)
	end
	if target:GetUnitName() == keys.Name4 and not target:HasAbility("build_base") then
		ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_Q2_20b_buff4", nil)
	end
	if target:GetUnitName() == keys.Name5 and not target:HasAbility("build_base") then
		ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_Q2_20b_buff5", nil)
	end
end
function jn_Q2_21b_1(keys)
	local caster = keys.caster
	local ab = keys.ability
	local perattackdamage = ab:GetSpecialValueFor("perattackdamage")
	local maxattackdamage = ab:GetSpecialValueFor("maxattackdamage")
	local count = math.min(caster:GetModifierStackCount("modifier_jn_Q2_21b",caster)+perattackdamage,maxattackdamage)
	caster:SetModifierStackCount("modifier_jn_Q2_21b",caster,count)
	local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, 0, 0, true)
	for i,target in pairs(targets) do
		if target:HasModifier("modifier_jn_Q2_21b_aura") and not target:HasAbility("build_base") then
			if not target:HasModifier("modifier_jn_Q2_21b_buff") then
				ab:ApplyDataDrivenModifier(caster,target, "modifier_jn_Q2_21b_buff",nil)
			end
			target:SetModifierStackCount("modifier_jn_Q2_21b_buff",caster,count)
		end
	end
end
function jn_Q2_21b_2(keys)
	local caster = keys.caster
	local target = keys.target
	local ab = caster:FindAbilityByName("jn_Q2_21b")
	local count = caster:GetModifierStackCount("modifier_jn_Q2_21b",caster)
	if count > 0 and not target:HasAbility("build_base") then
		if not target:HasModifier("modifier_jn_Q2_21b_buff") then
			ab:ApplyDataDrivenModifier(caster,target, "modifier_jn_Q2_21b_buff",nil)
		end
		target:SetModifierStackCount("modifier_jn_Q2_21b_buff",caster,count)
	end
end
function jn_Q3_00(keys)
	local caster = keys.caster
	local target = keys.target
	local ab = caster:FindAbilityByName("jn_Q3_00")
	local attackspeed1 = ab:GetSpecialValueFor("attackspeed1")
	local attackspeed2 = ab:GetSpecialValueFor("attackspeed2")
	local maxattackspeed = ab:GetSpecialValueFor("maxattackspeed")
	if caster.jn_Q3_00_count == nil then
		caster.jn_Q3_00_count = 0
	end
	if not target:HasAbility("build_base") then
		if keys.Mode == 1 then
			if target:GetUnitName() == keys.Name1 then
				caster.jn_Q3_00_count = caster.jn_Q3_00_count + attackspeed1
			end
			if target:GetUnitName() == keys.Name2 then
				caster.jn_Q3_00_count = caster.jn_Q3_00_count + attackspeed2
			end
		end
		if keys.Mode == 2 then
			if target:GetUnitName() == keys.Name1 then
				caster.jn_Q3_00_count = caster.jn_Q3_00_count - attackspeed1
			end
			if target:GetUnitName() == keys.Name2 then
				caster.jn_Q3_00_count = caster.jn_Q3_00_count - attackspeed2
			end
		end
		if caster.jn_Q3_00_count > 0  then
			if not caster:HasModifier("modifier_jn_Q3_00_buff") then
				ab:ApplyDataDrivenModifier(caster,caster, "modifier_jn_Q3_00_buff",nil)
			end
			caster:SetModifierStackCount("modifier_jn_Q3_00_buff",caster,math.min(caster.jn_Q3_00_count,maxattackspeed))
		else
			if caster:HasModifier("modifier_jn_Q3_00_buff") then
				caster:RemoveModifierByName("modifier_jn_Q3_00_buff")
			end
		end
	end
end

function jn_Q3_20b(keys)
	local caster = keys.unit
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) and not caster:HasModifier("modifier_jn_Q3_20b_buff") then
		caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
		ab:StartCooldown(ab:GetCooldown(ab:GetLevel()))
	end
end

function jn_Q3_20z(keys)
	local caster = keys.caster
	local duration = keys.Duration
	local playerData = PlayerData:GetPlayerData(caster:GetPlayerOwnerID())
	if playerData:Load("hex_Q3") == true then
		local last_time = GameRules:GetGameTime()
		local crazy = CreateUnitByName(caster:GetUnitName(), caster:GetOrigin(), true, caster, caster, caster:GetTeamNumber())
		UnitManager:SummonUnit(caster,crazy)
		crazy:RemoveModifierByName("modifier_jn_Q3_20z")
		crazy:FindAbilityByName("jn_Q3_20z"):ApplyDataDrivenModifier(crazy, crazy, "modifier_jn_Q3_20b_buff", {Duration=duration})
	end
end

function jn_Q5_10(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		if caster:GetHealthPercent() <= 15 then
			caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
			ab:StartCooldown(99999)
		end
	end
end
function jn_Q5_20(keys)
	local caster = keys.caster
	local ab = keys.ability
	local health = ab:GetSpecialValueFor("health")
	if not caster:HasModifier("modifier_jn_Q5_20_buff") then
		ab:ApplyDataDrivenModifier(caster,caster, "modifier_jn_Q5_20_buff",nil)
	end
	caster:SetModifierStackCount("modifier_jn_Q5_20_buff",caster,caster:GetModifierStackCount("modifier_jn_Q5_20_buff",caster)+1)
	caster:SetBaseMaxHealth(caster:GetBaseMaxHealth()+ab:GetSpecialValueFor("health"))
	caster:SetMaxHealth(caster:GetMaxHealth()+ab:GetSpecialValueFor("health"))
	caster:Heal(ab:GetSpecialValueFor("heal"), caster)
	caster:SetContextThink(DoUniqueString("jn_Q5_20"),
		function()
			local count = caster:GetModifierStackCount("modifier_jn_Q5_20_buff",caster)-1
			caster:SetModifierStackCount("modifier_jn_Q5_20_buff",caster,count)
			if count == 0 then
				caster:RemoveModifierByName("modifier_jn_Q5_20_buff")
			end
			caster:SetBaseMaxHealth(caster:GetBaseMaxHealth()-ab:GetSpecialValueFor("health"))
			caster:SetMaxHealth(caster:GetMaxHealth()-ab:GetSpecialValueFor("health"))
		end
	, ab:GetSpecialValueFor("duration"))
end
function jn_Q5_21a(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		if caster:GetHealthPercent() <= 15 then
			caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_Q6_00_1(caster,ab,target,damage,reducedamage,count,maxcount,group,effectname)
	count = count + 1
	table.insert(group,target)
	local targets = FindUnitsInRadius(caster:GetTeamNumber(),target:GetAbsOrigin(),nil,ab:GetSpecialValueFor("radius"),DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,FIND_CLOSEST,true)
	for i=#targets,1,-1 do
		local v = targets[i]
		for n,u in pairs(group) do
			if u == v then
				table.remove(targets,i)
			end
		end
	end
	local target_other = targets[1]
	if target_other then
		local projectile_info = 
		{
			Ability = ab,
			Source = target,
			Target = target_other,
			EffectName = effectname,
			iMoveSpeed = 900,
			vSourceLoc = target:GetAbsOrigin(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_HITLOCATION,
			bProvidesVision = false,
			bDodgeable = true,
			bIsAttack = true,
			bReplaceExisting = false,
		}
		ProjectileManager:CreateTrackingProjectile(projectile_info)

		local last_time = GameRules:GetGameTime()
		local time = (target_other:GetAbsOrigin()-target:GetAbsOrigin()):Length2D() / 900
		target_other:SetContextThink(DoUniqueString("jn_Q6_00"),
			function()
				local now = GameRules:GetGameTime()
				if now - last_time >= time then
					damage = damage * (1-reducedamage)
					DamageManager:CustonDamage(caster,target_other,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage,false)
					target_other:EmitSound("Hero_Luna.MoonGlaive.Impact")
					if count < maxcount then
						jn_Q6_00_1(caster,ab,target_other,damage,reducedamage,count,maxcount,group,effectname)
					end
					return nil
				end
				return 0
			end
		,0)
	end
end
function jn_Q6_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	local damage = keys.Damage
	jn_Q6_00_1(caster,ab,target,damage,ab:GetSpecialValueFor("reducedamage")*0.01,0,ab:GetSpecialValueFor("count"),{},keys.EffectName)
end
function jn_Q6_20b(keys)
	local caster = keys.caster
	local ab = keys.ability
	local targets = Entities:FindAllByName(caster:GetName())
	local count = 0
	for i,unit in pairs(targets) do
		if unit:GetUnitName() == caster:GetUnitName() and unit:HasAbility("build_base") and caster:GetPlayerOwnerID() == unit:GetPlayerOwnerID() then
			count = count + 1
		end
	end
	if count >= ab:GetSpecialValueFor("count") then
		if not caster:HasModifier("modifier_jn_Q6_20b_buff") then
			ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_Q6_20b_buff", nil)
		end
		local extracount = math.min(count - ab:GetSpecialValueFor("count"),ab:GetSpecialValueFor("extracount"))
		if extracount > 0 then
			if not caster:HasModifier("modifier_jn_Q6_20b_buff_hidden") then
				ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_Q6_20b_buff_hidden", nil)
			end
			caster:SetModifierStackCount("modifier_jn_Q6_20b_buff_hidden", caster, extracount)
		end
	else
		caster:RemoveModifierByName("modifier_jn_Q6_20b_buff")
		caster:RemoveModifierByName("modifier_jn_Q6_20b_buff_hidden")
	end
end
function jn_Q6_21(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		if caster:GetHealthPercent() <= 80 then
			caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_W1_11(keys)
	local caster = keys.caster
	local target = keys.target
	local damage = keys.Damage
	local ab = keys.ability
	local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf", PATTACH_ABSORIGIN, target)
	ParticleManager:SetParticleControlEnt(particleId,0,target,PATTACH_POINT,"attach_hitloc",target:GetOrigin(),true)
	ParticleManager:ReleaseParticleIndex(particleId)
	local targets = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
	for i,unit in pairs(targets) do
		if unit ~= target then
			DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage*ab:GetSpecialValueFor("damagepercent")*0.01,false)
		end
	end
end
function jn_W2_10a_1(keys)
	local caster = keys.caster
	local ab = keys.ability
	if caster:GetHealthPercent() >= 50 then
		ab:ApplyDataDrivenModifier(caster, caster, keys.ModiferName, nil)
		caster:SetRangedProjectileName("particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf")
	else
		caster:SetRangedProjectileName("particles/units/heroes/hero_huskar/huskar_base_attack.vpcf")
	end
end
function jn_W2_10a_2(keys)
	local caster = keys.caster
	local target = keys.target
	local ab = keys.ability
	caster:SetHealth(math.max(caster:GetHealth()-ab:GetSpecialValueFor("damage"),1))
	local damageTable={
		victim=target,
		attacker=caster,
		damage=ab:GetSpecialValueFor("damage"),
		damage_type=DAMAGE_TYPE_PURE
		}
	ApplyDamage(damageTable)
end
function jn_W2_10b(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		GetAandDSystem(caster):AddAttacktypeResistance("magic",ab:GetSpecialValueFor("resistance")*0.01,ab:GetAbilityName())
	end
	if keys.Mode == 2 then
		GetAandDSystem(caster):RemoveAttacktypeResistance("magic",ab:GetAbilityName())
	end
end
function jn_W3_10(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		ab:ToggleAutoCast()
	end
	if keys.Mode == 2 then
		local target = keys.target
		local damage = keys.Damage
		DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage,true)
	end
end
function jn_W4_10(keys)
	local caster = keys.caster
	local target = keys.target
	local ab = keys.ability
	local damage = keys.Damage
	local targets = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
	for i=#targets,1,-1 do
		local unit = targets[i]
		if unit == target then
			table.remove(targets,i)
		end
	end
	if #targets > 0 then
		local target_other = targets[RandomInt(1,#targets)]
		local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf",PATTACH_CUSTOMORIGIN,nil)
		ParticleManager:SetParticleControlEnt(particleId,0,target,PATTACH_POINT_FOLLOW,"attach_hitloc",target:GetOrigin(),true)
		ParticleManager:SetParticleControlEnt(particleId,1,target_other,PATTACH_POINT_FOLLOW,"attach_hitloc",target_other:GetOrigin(),true)
		ParticleManager:ReleaseParticleIndex(particleId)
		target_other:EmitSound("Hero_TemplarAssassin.PsiBlade")
		DamageManager:CustonDamage(caster,target_other,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage*ab:GetSpecialValueFor("damagepercent")*0.01,false)
	end
end
function jn_W5_10(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO+DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, true)
		for i=#targets,1,-1 do
			local unit = targets[i]
			if HasLabel(unit,"jn_W5_10") or unit:HasModifier(keys.ModifierName) or HasLabel(unit,"SummonUnit") then
				table.remove(targets,i)
			end
		end
		if #targets > 0 then
			local target = targets[1]
			AddLabel(target,"jn_W5_10")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_W5_10_channelfinish(keys)
	local target = keys.target
	target:StopSound("Hero_ShadowShaman.Shackles")
	RemoveLabel(target,"jn_W5_10")
end
function jn_W6_10(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 1 then
		if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
	if keys.Mode == 2 then
		local particleId = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf", PATTACH_CUSTOMORIGIN, target)
		ParticleManager:SetParticleControlEnt(particleId, 0, target, PATTACH_POINT, nil, target:GetOrigin(), true)
		ParticleManager:SetParticleControlEnt(particleId, 1, target, PATTACH_POINT, nil, target:GetOrigin(), true)
		ParticleManager:SetParticleControlOrientation(particleId, 1, (target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized(), Vector(0,0,0), Vector(0,0,0))
		ParticleManager:ReleaseParticleIndex(particleId)
		local damage = ab:GetSpecialValueFor("crit")*0.01*caster:GetAttackDamage()
		PopupCriticalDamage(target,math.floor(damage))
		DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage,true)
	end
end
function jn_W6_21a(keys)
	local caster = keys.attacker
	local target = keys.target
	local particleId = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControlEnt(particleId, 0, target, PATTACH_POINT, nil, target:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 1, target, PATTACH_POINT, nil, target:GetOrigin(), true)
	ParticleManager:SetParticleControlOrientation(particleId, 1, (target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized(), Vector(0,0,0), Vector(0,0,0))
	ParticleManager:ReleaseParticleIndex(particleId)
end
function jn_W6_21b(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		if not caster:HasModifier("modifier_jn_W6_21b_buff") then
			ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_W6_21b_buff", nil)
		end
		caster:SetModifierStackCount("modifier_jn_W6_21b_buff", caster, keys.Count)
	end
	if keys.Mode == 2 then
		caster:SetModifierStackCount("modifier_jn_W6_21b_buff", caster, caster:GetModifierStackCount("modifier_jn_W6_21b_buff", caster)-1)
		if caster:GetModifierStackCount("modifier_jn_W6_21b_buff", caster) == 0 then
			caster:RemoveModifierByName("modifier_jn_W6_21b_buff")
		end
	end
end
function jn_W7_10(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,caster:GetTeamNumber()) == UF_SUCCESS then
		local damagepercent = ab:GetSpecialValueFor("damagepercent")*0.01
		local maxdamage = ab:GetSpecialValueFor("maxdamage")
		local damage = math.min((target:GetMaxHealth() - target:GetHealth())*damagepercent,maxdamage)
		if damage > 0 then
			DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage,false)

			local number = math.floor(damage)
			local presymbol = 0
			local pidx = ParticleManager:CreateParticle("particles/msg_fx/msg_crit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)

			local digits = 0
			if number ~= nil then
				digits = #tostring(number)
			end
			if presymbol ~= nil then
				digits = digits + 1
			end

			ParticleManager:SetParticleControl(pidx, 1, Vector(presymbol, tonumber(number), 0))
			ParticleManager:SetParticleControl(pidx, 2, Vector(1, digits, 0))
			ParticleManager:SetParticleControl(pidx, 3, Vector(191,0,191))
		end
	end
end
function jn_E1_10a(keys)
	local caster = keys.target
	local ab = keys.ability
	local target = keys.attacker
	if not target:IsRangedAttacker() then
		if RandomInt(0, 100) <= ab:GetSpecialValueFor("chance") then
			local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_tiny/tiny_craggy_hit.vpcf",PATTACH_ABSORIGIN,caster)
			ParticleManager:SetParticleControlEnt(particleId,0,caster,PATTACH_POINT_FOLLOW,"attach_hitloc",caster:GetOrigin(),true)
			ParticleManager:SetParticleControlOrientation(particleId, 1, (target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized(), Vector(0,0,0), Vector(0,0,0))
			ParticleManager:ReleaseParticleIndex(particleId)
			ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_E1_10a_buff", nil)
		end
	end
end
function jn_E2_10a(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		local hero = PlayerData:GetPlayerData(caster:GetPlayerOwnerID()):GetHero()
		hero.jn_E2_10a_Vector=caster:GetOrigin()
		keys.ability:ApplyDataDrivenModifier(hero, hero, "modifier_jn_E2_10a", nil)
	end
	if keys.Mode == 2 then
		local hero = caster
		local target = keys.target
		UnitManager:SummonUnit(hero,target)
		FindClearSpaceForUnit(target, hero.jn_E2_10a_Vector, true)
	end
end
function jn_E3_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	GetAandDSystem(caster):AddAttacktypeResistance("pierce",ab:GetSpecialValueFor("resistance")*0.01,ab:GetAbilityName())
end
function jn_E3_11a(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),ab:GetSpecialValueFor("damage"),false)
end
function jn_E3_11b(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if not caster:HasModifier("modifier_jn_E3_11b_buff") then
		ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_E3_11b_buff", nil)
	end
	if caster:GetModifierStackCount("modifier_jn_E3_11b_buff", caster) < ab:GetSpecialValueFor("maxattackspeed") then
		caster:SetModifierStackCount("modifier_jn_E3_11b_buff", caster, caster:GetModifierStackCount("modifier_jn_E3_11b_buff", caster)+ab:GetSpecialValueFor("attackspeed"))
	end
end
function jn_E4_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	GetAandDSystem(caster):AddAttacktypeResistance("magic",ab:GetSpecialValueFor("resistance")*0.01,ab:GetAbilityName())
end
function jn_E4_10(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		caster.jn_E4_10_particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_shredder/shredder_armor_lyr.vpcf", PATTACH_ABSORIGIN, caster)
		ParticleManager:SetParticleControlEnt(caster.jn_E4_10_particleId,0,caster,PATTACH_POINT_FOLLOW,"attach_armor",caster:GetOrigin(),true)
		ParticleManager:SetParticleControlEnt(caster.jn_E4_10_particleId,4,caster,PATTACH_POINT_FOLLOW,"attach_chimmney",caster:GetOrigin(),true)
		ParticleManager:SetParticleControl(caster.jn_E4_10_particleId,2,Vector(0,0,0))
	end
	if keys.Mode == 2 then
		if caster.jn_E4_10_attackedcount == nil then
			caster.jn_E4_10_attackedcount = 0
		end
		caster.jn_E4_10_attackedcount = caster.jn_E4_10_attackedcount + 1
		if caster.jn_E4_10_attackedcount >= ab:GetSpecialValueFor("attackedcount") then
			if caster.jn_E4_10_count == nil then
				caster.jn_E4_10_count = 0
			end
			caster.jn_E4_10_attackedcount = 0
			local maxcount = ab:GetSpecialValueFor("maxcount")
			caster.jn_E4_10_count = math.min(caster.jn_E4_10_count + 1,maxcount)
			ParticleManager:SetParticleControl(caster.jn_E4_10_particleId,2,Vector(4/maxcount*caster.jn_E4_10_count,0,0))
			if not caster:HasModifier("modifier_jn_E4_10_buff") then
				ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_E4_10_buff", nil)
			end
			caster:SetModifierStackCount("modifier_jn_E4_10_buff",caster,caster.jn_E4_10_count)
		end
	end
end
function jn_G2_11(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.unit
	if not HasLabel(target,"SummonUnit") then
		local hero = PlayerData:GetPlayerData(caster:GetPlayerOwnerID()):GetHero()
		local egg = CreateUnitByName("npc_unit_G2_1b_MC", caster:GetOrigin(), true, caster, caster, caster:GetTeamNumber())
		egg:AddNewModifier(nil, nil, "modifier_phased", {})
		local last_time = GameRules:GetGameTime()
		egg:SetContextThink(DoUniqueString("jn_G2_11"),
			function()
				local now = GameRules:GetGameTime()
				if now - last_time >= 5 then
					if egg:IsAlive() then
						local spider = CreateUnitByName("npc_unit_G2_1a_MC", egg:GetOrigin(), true, caster, caster, caster:GetTeamNumber())
						UnitManager:SummonUnit(hero,spider)
						if RandomInt(0, 100) <= ab:GetSpecialValueFor("chance") then
							spider = CreateUnitByName("npc_unit_G2_1a_MC", egg:GetOrigin(), true, caster, caster, caster:GetTeamNumber())
							UnitManager:SummonUnit(hero,spider)
						end
						--egg:ForceKill(true)
						egg:RemoveSelf() 
					end
					return nil
				end
				return 0
			end
		, 0)
	end
end
function jn_E7_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab.count == nil then
		ab.count = 0
	end
	ab.count = ab.count + 1
	if ab.count == ab:GetSpecialValueFor("attackcount") then
		ab.count = 0
		local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", PATTACH_ABSORIGIN, caster)
		ParticleManager:ReleaseParticleIndex(particleId)
		caster:Heal(caster:GetMaxHealth()*ab:GetSpecialValueFor("healthregenpercent")*0.01, caster)
	end
end
function jn_E7_11b(keys)
	local caster = keys.caster
	local ab = keys.ability
	local targets = Entities:FindAllByName(caster:GetName())
	local count = 0
	for i,unit in pairs(targets) do
		if unit:GetUnitName() == caster:GetUnitName() and unit:HasAbility("build_base") and caster:GetPlayerOwnerID() == unit:GetPlayerOwnerID() then
			count = count + 1
		end
	end
	count = math.min(count,ab:GetSpecialValueFor("maxcount"))
	if count > 0 then
		if not caster:HasModifier("modifier_jn_E7_11b_buff") then
			ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_E7_11b_buff", nil)
		end
		caster:SetModifierStackCount("modifier_jn_E7_11b_buff", caster, count)
	else
		caster:RemoveModifierByName("modifier_jn_E7_11b_buff")
	end
end
function jn_D1_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		ab:ToggleAutoCast()
	end
	if keys.Mode == 2 then
		local target = keys.target
		local damage = keys.Damage
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
		for i,unit in pairs(targets) do
			if unit ~= target then
				if caster:HasAbility("jn_D1_10b") and HasLabel(unit,"SummonUnit") then
					local ability = caster:FindAbilityByName("jn_D1_10b")
					DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),(damage+ab:GetSpecialValueFor("damage"))*ab:GetSpecialValueFor("damagepercent")*0.01+ability:GetSpecialValueFor("damage"),false)
					caster:GiveMana(ability:GetSpecialValueFor("mana"))
				else
					DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),(damage+ab:GetSpecialValueFor("damage"))*ab:GetSpecialValueFor("damagepercent")*0.01,false)
				end
			else
				DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),ab:GetSpecialValueFor("damage"),true)
			end
		end
		local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf", PATTACH_WORLDORIGIN, caster)
		ParticleManager:SetParticleControl(particleId, 0, target:GetOrigin())
		ParticleManager:ReleaseParticleIndex(particleId)
	end
end
function jn_D1_10b(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if HasLabel(target,"SummonUnit") then
		DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),ab:GetSpecialValueFor("damage"),false)
		caster:GiveMana(ab:GetSpecialValueFor("mana"))
	end
end
function jn_D2_10b_buff(keys)
	local caster = keys.target
	local ab = keys.ability
	local AandD = GetAandDSystem(caster)
	if keys.Mode == 1 then
		AandD:AddAttacktypeResistance("magic",1,ab:GetAbilityName())
	end
	if keys.Mode == 2 then
		AandD:RemoveAttacktypeResistance("magic",ab:GetAbilityName())
	end
end

function jn_D3_00( keys )
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	caster.jn_D3_00_attackcount = (caster.jn_D3_00_attackcount or 0) + 1
	if caster.jn_D3_00_attackcount>=ab:GetSpecialValueFor("attackcount") then
		caster.jn_D3_00_attackcount = 0
		Lightning(caster,caster,target,ab:GetSpecialValueFor("damage"),0.2,ab:GetSpecialValueFor("radius"),1,ab:GetSpecialValueFor("count"),{})
	end
end
function jn_D3_10( keys )
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	caster.jn_D3_10_attackcount = (caster.jn_D3_10_attackcount or 0) + 1
	if caster.jn_D3_10_attackcount>=ab:GetSpecialValueFor("attackcount") then
		caster.jn_D3_10_attackcount = 0
		Lightning(caster,caster,target,ab:GetSpecialValueFor("damage"),0.2,ab:GetSpecialValueFor("radius"),1,ab:GetSpecialValueFor("count"),{})
	end
end
function jn_D4_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 1 then
		if not target:HasFlyMovementCapability() then
			if not target:HasModifier(keys.OModifierName) then
				ab:ApplyDataDrivenModifier(caster, target, keys.ModifierName, nil)
			end
		end
	end
	if keys.Mode == 2 then
		target:RemoveModifierByName(keys.ModifierName)
	end
end
function jn_D4_10a(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 1 then
		if not target:HasModifier(keys.OModifierName) then
			ab:ApplyDataDrivenModifier(caster, target, keys.ModifierName, nil)
		end
	end
	if keys.Mode == 2 then
		target:RemoveModifierByName(keys.ModifierName)
	end
end
function jn_D4_10c(keys)
	local caster = keys.caster
	local ab = keys.ability
	GetAandDSystem(caster):AddAttacktypeResistance("magic",ab:GetSpecialValueFor("resistance")*0.01,ab:GetAbilityName())
	GetAandDSystem(caster):AddAttacktypeResistance("pierce",ab:GetSpecialValueFor("resistance")*0.01,ab:GetAbilityName())
end
function jn_D5_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		ab:ToggleAutoCast()
	end
	if keys.Mode == 2 then
		local target = keys.target
		local count = ab:GetSpecialValueFor("count")-1
		local targets = FindUnitsInRadius(caster:GetTeamNumber(),caster:GetAbsOrigin(),nil,ab:GetSpecialValueFor("radius"),DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,FIND_CLOSEST,true)
		for i,unit in pairs(targets) do
			if unit ~= target then
				local projectile_info = 
				{
					Ability = ab,
					Source = caster,
					Target = unit,
					EffectName = "particles/units/heroes/hero_medusa/medusa_base_attack.vpcf",
					iMoveSpeed = 900,
					vSourceLoc = caster:GetAbsOrigin(),
					iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
					bProvidesVision = false,
					bDodgeable = true,
					bIsAttack = true,
					bReplaceExisting = false,
				}
				ProjectileManager:CreateTrackingProjectile(projectile_info)
				count = count - 1
			end
			if count == 0 then break end
		end
	end
	if keys.Mode == 3 then
		local target = keys.target
		DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),caster:GetAttackDamage(),false)
	end
end
function jn_D5_10b(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
	end
end
function jn_D6_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO+DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_CLOSEST, true)
		for i=#targets,1,-1 do
			local unit = targets[i]
			if HasLabel(unit,"jn_D6_00") or unit:HasModifier(keys.ModifierName) then
				table.remove(targets,i)
			end
		end
		if #targets > 0 then
			local target = targets[1]
			AddLabel(target,"jn_D6_00")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_D6_00_removelabel(keys)
	local target = keys.target
	RemoveLabel(target,"jn_D6_00")
end
function jn_D6_10a(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		ab:ToggleAutoCast()
	end
	if keys.Mode == 2 then
		local target = keys.target
		local count = ab:GetSpecialValueFor("count")-1
		local targets = FindUnitsInRadius(caster:GetTeamNumber(),caster:GetAbsOrigin(),nil,ab:GetSpecialValueFor("radius"),DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,FIND_CLOSEST,true)
		local attackeffect = "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
		for i,unit in pairs(targets) do
			if unit ~= target then
				local projectile_info = 
				{
					Ability = ab,
					Source = caster,
					Target = unit,
					EffectName = attackeffect,
					iMoveSpeed = 900,
					vSourceLoc = caster:GetAbsOrigin(),
					iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
					bProvidesVision = false,
					bDodgeable = true,
					bIsAttack = true,
					bReplaceExisting = false,
				}
				ProjectileManager:CreateTrackingProjectile(projectile_info)
				count = count - 1
			end
			if count == 0 then break end
		end
	end
	if keys.Mode == 3 then
		local target = keys.target
		DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),caster:GetAttackDamage(),false)
		if caster:HasAbility("jn_D6_10b") then
			if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,caster:GetTeamNumber()) == UF_SUCCESS then
				local ab = caster:FindAbilityByName("jn_D6_10b")
				ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_D6_10b_buff",{duration=ab:GetSpecialValueFor("duration")})
			end
		end
	end
end
function jn_D6_10b(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,caster:GetTeamNumber()) == UF_SUCCESS then
		ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_D6_10b_buff",{duration=ab:GetSpecialValueFor("duration")})
	end
end
function jn_D6_11a(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, true)
		if #targets > 0 then
			local target = targets[1]
			caster:CastAbilityOnPosition(target:GetOrigin(), ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_D7_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,caster:GetTeamNumber()) == UF_SUCCESS then
		if not target:HasModifier(keys.ModifierName) then
			if RandomInt(0, 100) <= ab:GetSpecialValueFor("chance") then
				if keys.ModifierName == "modifier_jn_D7_10_buff" then
					target:RemoveModifierByName("modifier_jn_D7_00_buff")
				end
				ab:ApplyDataDrivenModifier(caster, target, keys.ModifierName, {duration=ab:GetSpecialValueFor("duration")})
			end
		end
	end
end
function jn_D7_00_particle(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 1 then
		ab.particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_tusk/tusk_frozen_sigil.vpcf", PATTACH_ABSORIGIN, target)
		ParticleManager:SetParticleControlEnt(ab.particleId, 0, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetOrigin(), true)
		ParticleManager:SetParticleControlEnt(ab.particleId, 2, caster, PATTACH_ABSORIGIN_FOLLOW, nil, caster:GetOrigin(), true)
		target:EmitSound("Hero_Tusk.WalrusPunch.Cast")
	end
	if keys.Mode == 2 then
		ParticleManager:DestroyParticle(ab.particleId, true)
		target:StopSound("Hero_Tusk.WalrusPunch.Cast")
	end
end
function jn_D7_11(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,caster:GetTeamNumber()) == UF_SUCCESS then
		if target:IsAlive() then
			if target:GetHealth() <= ab:GetSpecialValueFor("health") then
				ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_D7_11_buff", nil)
				KnockBack(caster,target,(target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized(),0,0.5,0,500,false,0,
					function()
						if target:IsAlive() then
							target:Kill(ab, caster)
						end
					end)
			end
		end
	end
end
function jn_F1_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
		local target
		local hppercent = 100
		for i=#targets,1,-1 do
			local unit = targets[i]
			if IsCommander(unit) or HasLabel(unit,"jn_F1_00") or HasLabel(unit,"SummonUnit") or unit == caster or unit:HasModifier(keys.ModifierName) or unit:HasAbility("build_base") or unit:HasAbility("kexuanmajia") then
        		table.remove(targets,i)
			else
				if hppercent > unit:GetHealthPercent() and unit:GetHealthPercent() > 5 then
					target = unit
					hppercent = unit:GetHealthPercent()
				end
			end
		end
		if target then
			AddLabel(target,"jn_F1_00")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		else
			if #targets > 0 then
				target = targets[RandomInt(1, #targets)]
				AddLabel(target,"jn_F1_00")
				caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
			elseif not HasLabel(caster,"jn_F1_00") and not caster:HasModifier(keys.ModifierName) then
				target = caster
				AddLabel(target,"jn_F1_00")
				caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
			end
		end
	end
end
function jn_F1_00_removelabel(keys)
	local target = keys.target
	RemoveLabel(target,"jn_F1_00")
end
function jn_F2_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MELEE_ONLY, FIND_CLOSEST, true)
		local target
		local hppercent = 100
		for i=#targets,1,-1 do
			local unit = targets[i]
			if IsCommander(unit) or HasLabel(unit,"jn_F2_00") or HasLabel(unit,"SummonUnit") or unit == caster or unit:HasModifier(keys.ModifierName) or unit:HasAbility("build_base") or unit:HasAbility("kexuanmajia") then
				table.remove(targets,i)
			else
				if hppercent > unit:GetHealthPercent() and unit:GetHealthPercent() > 5 then
					target = unit
					hppercent = unit:GetHealthPercent()
				end
			end
		end
		if target then
			AddLabel(target,"jn_F2_00")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		else
			if #targets > 0 then
				target = targets[RandomInt(1, #targets)]
				AddLabel(target,"jn_F2_00")
				caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
			end
		end
	end
end
function jn_F2_00_removelabel(keys)
	local target = keys.target
	if target.jn_F2_00_particle then
		ParticleManager:DestroyParticle(target.jn_F2_00_particle, true)
	end
	RemoveLabel(target,"jn_F2_00")
end
function jn_F2_00_particle(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	target.jn_F2_00_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_frost_armor.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
	ParticleManager:SetParticleControl(target.jn_F2_00_particle, 1, Vector(target:GetHullRadius(),0,0))
	ParticleManager:SetParticleControlEnt(target.jn_F2_00_particle, 2, target, PATTACH_CUSTOMORIGIN_FOLLOW, "attach_hitloc", target:GetOrigin(), true)
end
function jn_F2_10b(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab.count == nil then
		ab.count = 0
	end
	ab.count = ab.count + 1
	if ab.count == ab:GetSpecialValueFor("attackcount") then
		ab.count = 0
		local target = keys.target
		local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_frost_nova.vpcf",PATTACH_ABSORIGIN,caster)
		ParticleManager:SetParticleControlEnt(particleId,0,target,PATTACH_POINT_FOLLOW,"attach_hitloc",target:GetOrigin(),true)
		ParticleManager:ReleaseParticleIndex(particleId)
		target:EmitSound("Ability.FrostNova")
		DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),ab:GetSpecialValueFor("damage"),false)
	end
end
function jn_F3_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
		for i=#targets,1,-1 do
			local unit = targets[i]
			if IsCommander(unit) or HasLabel(unit,"jn_F3_00") or HasLabel(unit,"SummonUnit") or unit == caster or unit:HasModifier(keys.ModifierName) or unit:HasAbility("build_base") or unit:HasAbility("kexuanmajia") then
				table.remove(targets,i)
			end
		end
		if #targets > 0 then
			local target = targets[RandomInt(1, #targets)]
			AddLabel(target,"jn_F3_00")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		elseif not HasLabel(caster,"jn_F3_00") and not caster:HasModifier(keys.ModifierName) then
			local target = caster
			AddLabel(target,"jn_F3_00")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_F3_00_removelabel(keys)
	local target = keys.target
	RemoveLabel(target,"jn_F3_00")
end
function jn_F3_11(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityOnPosition(caster:GetAbsOrigin()+(target:GetAbsOrigin()-caster:GetAbsOrigin()):Normalized()*300, ab, caster:GetPlayerOwnerID())
	end
end
function jn_F3_11_heal(keys)
	local caster = keys.caster
	local target = keys.target
	if target:GetUnitName() ~= "npc_unit_F3_11a_BB" then
		target:Heal(keys.HealAmount, caster)
	end
end
function npc_unit_F4_1a_BZ_spawn(keys) --召唤死灵战士
	local u_unit
	if keys.TargetUnit == "CASTER" then
		u_unit = keys.caster
	elseif keys.TargetUnit == "TARGET" then
		u_unit = keys.target
	elseif keys.TargetUnit == "UNIT" then
		u_unit = keys.unit
	elseif keys.TargetUnit == "ATTACKER" then
		u_unit = keys.attacker
	else
		u_unit = keys.caster
	end
	u_unit:AddAbility("ability_dummy")
	local ab = u_unit:FindAbilityByName("ability_dummy")
	local modifiername = "npc_unit_F4_1a_BZ_spawn"
	local targets = FindUnitsInRadius(u_unit:GetTeamNumber(), u_unit:GetOrigin(), nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
	for i=#targets,1,-1 do
		local target = targets[i]
		if not target:HasAbility("jn_F4_11b") then
			table.remove(targets,i)
		end
	end
	if #targets > 0 then
		local count = math.min(#targets,4)
		modifiername = "npc_unit_F4_1a_BZ_spawn_"..count
	end
	for i=1,keys.UnitCount do
		ab:ApplyDataDrivenModifier(u_unit, u_unit, modifiername, nil)
	end
	u_unit:RemoveAbility("ability_dummy")
end
function npc_unit_F4_10_PZ_death(keys)
	local caster = keys.caster
	if caster then
		if caster.jn_F4_11a_count ~= nil then
			caster.jn_F4_11a_count = caster.jn_F4_11a_count - 1
		end
	end
end
function jn_F4_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
	end
end
function jn_F4_11a(keys)
	local caster = keys.caster
	local unit = keys.unit
	if unit:GetUnitName() == "npc_unit_F4_10_PZ" then
		if caster.jn_F4_11a_count == nil then
			caster.jn_F4_11a_count = 0
		end
		if caster.jn_F4_11a_count < 3 then
			caster.jn_F4_11a_count = caster.jn_F4_11a_count + 1
			keys.TargetUnit=caster
			keys.UnitCount=1
			npc_unit_F4_1a_BZ_spawn(keys)
		end
	end
end
function jn_F5_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MELEE_ONLY, FIND_CLOSEST, true)
		for i=#targets,1,-1 do
			local unit = targets[i]
			if IsCommander(unit) or HasLabel(unit,"jn_F5_00") or HasLabel(unit,"SummonUnit") or unit == caster or unit:HasModifier(keys.ModifierName) or unit:HasAbility("build_base") or unit:HasAbility("kexuanmajia") then
				table.remove(targets,i)
			end
		end
		if #targets > 0 then
			local target = targets[RandomInt(1, #targets)]
			AddLabel(target,"jn_F5_00")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_F5_00_removelabel(keys)
	local target = keys.target
	RemoveLabel(target,"jn_F5_00")
end
function jn_F6_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MELEE_ONLY, FIND_CLOSEST, true)
		local target
		local hppercent = 100
		for i=#targets,1,-1 do
			local unit = targets[i]
			if IsCommander(unit) or HasLabel(unit,"jn_F6_00") or HasLabel(unit,"SummonUnit") or unit == caster or unit:HasModifier(keys.ModifierName) or unit:HasAbility("build_base") or unit:HasAbility("kexuanmajia") then
				table.remove(targets,i)
			else
				if hppercent > unit:GetHealthPercent() and unit:GetHealthPercent() > 5 then
					target = unit
					hppercent = unit:GetHealthPercent()
				end
			end
		end
		if target then
			AddLabel(target,"jn_F6_00")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		else
			if #targets > 0 then
				target = targets[RandomInt(1, #targets)]
				AddLabel(target,"jn_F6_00")
				caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
			end
		end
	end
end
function jn_F6_00_removelabel(keys)
	local target = keys.target
	RemoveLabel(target,"jn_F6_00")
	target.jn_F6_00_absorb = 0
end
function jn_F6_00_buff(keys)
	local caster = keys.unit
	local damage = keys.Damage
	local absorb = caster.jn_F6_00_absorb or 0
	absorb = absorb + damage
	if absorb >= keys.DamageAbsorb then
		caster:RemoveModifierByName("modifier_jn_F6_00_buff")
	else
		caster.jn_F6_00_absorb = absorb
	end
end
function jn_F7_00(keys)
	local caster = keys.attacker
	local target = keys.unit
	if target:GetUnitName() ~= "npc_unit_huweidui_left_BZ" and target:GetUnitName() ~= "npc_unit_huweidui_right_BZ" then
		local bounty = target:GetGoldBounty()
		if bounty ~= 0 then
			local playerData = PlayerData:GetPlayerData(caster:GetPlayerOwnerID())

			playerData:ModifyGold(bounty, DOTA_ModifyGold_CreepKill)

			local particleId = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_alchemist/alchemist_lasthit_msg_gold.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, caster:GetTeam())
			local presymbol = 0
			local digits = 0

			if bounty ~= nil then
				digits = #tostring(bounty)
			end
			if presymbol ~= nil then
				digits = digits + 1
			end

			ParticleManager:SetParticleControl(particleId, 1, Vector(presymbol, tonumber(bounty), 0))
			ParticleManager:SetParticleControl(particleId, 2, Vector(1, digits, 0))
			ParticleManager:SetParticleControl(particleId, 3, Vector(255,204,0))
		end
	end
end
function jn_F7_10(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if target:GetHealthPercent() <= 30 then
		ab:ApplyDataDrivenModifier(caster, caster, "modifier_jn_F7_10_buff", {Duration=ab:GetSpecialValueFor("duration")})
	end
end
function jn_F8_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
		for i=#targets,1,-1 do
			local unit = targets[i]
			if HasLabel(unit,"jn_F8_00") or HasLabel(unit,"SummonUnit") or unit:HasModifier(keys.ModifierName) then
				table.remove(targets,i)
			end
		end
		if #targets > 0 then
			local target = targets[1]
			AddLabel(target,"jn_F8_00")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_F8_00_removelabel(keys)
	local target = keys.target
	RemoveLabel(target,"jn_F8_00")
end
function jn_F8_10a(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
		for i=#targets,1,-1 do
			local unit = targets[i]
			if HasLabel(unit,"jn_F8_10a") or HasLabel(unit,"SummonUnit") or unit:HasModifier(keys.ModifierName) then
				table.remove(targets,i)
			end
		end
		if #targets > 0 then
			local target = targets[1]
			AddLabel(target,"jn_F8_10a")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_F8_10a_removelabel(keys)
	local target = keys.target
	RemoveLabel(target,"jn_F8_10a")
end
function jn_F9_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
		if #targets > 0 then
			local target = targets[RandomInt(1, #targets)]
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_F9_10_aura(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 1 then
		if target:GetUnitName() == "npc_unit_F9_00_MW" then
			ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_F9_10_buff", nil)
		end
	end
	if keys.Mode == 2 then
		target:RemoveModifierByNameAndCaster("modifier_jn_F9_10_buff", caster)
	end
end
function jn_F9_10(keys)
	if keys.Mode == 1 or keys.Mode == 2 then
		local caster = keys.unit
		local ab = keys.ability
		local event_ab = keys.event_ability
		local target = keys.target
		if event_ab and event_ab:GetAbilityName() == "jn_F9_00" then
			local multicast_2_times = ab:GetSpecialValueFor("multicast_2_times_extra")
			local multicast_3_times = ab:GetSpecialValueFor("multicast_3_times_extra")
			if keys.Mode == 2 then
				multicast_2_times = ab:GetSpecialValueFor("multicast_2_times")
				multicast_3_times = ab:GetSpecialValueFor("multicast_3_times")
			end
			local multicast_delay = event_ab:GetSpecialValueFor("multicast_delay")
			if RandomInt(0, 100) <= multicast_3_times then
				local times = 1
				local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
				ParticleManager:SetParticleControl(particleId, 1, Vector(times,2,0))
				EmitSoundOn("Hero_OgreMagi.Fireblast.x2", caster)
				local last_time = GameRules:GetGameTime()
				GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("jn_F9_10"),
					function()
						local now = GameRules:GetGameTime()
						if now - last_time >= multicast_delay then
							last_time = now
							times = times + 1
							local duration = event_ab:GetSpecialValueFor("stuntime")
							if target:IsConsideredHero() then
								duration = event_ab:GetSpecialValueFor("stuntime_to_king")
							end
							target:RemoveModifierByName("modifier_jn_F9_00_buff")
							event_ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_F9_00_buff", {Duration=duration})
							ParticleManager:DestroyParticle(particleId, true)
							particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
							if times == 3 then
								ParticleManager:SetParticleControl(particleId, 1, Vector(times,1,multicast_delay*times))
								return nil
							else
								ParticleManager:SetParticleControl(particleId, 1, Vector(times,2,0))
							end
						end
						return 1/30
					end
				,1/30)
			elseif RandomInt(0, 100) <= multicast_2_times then
				local times = 1
				local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
				ParticleManager:SetParticleControl(particleId, 1, Vector(times,2,0))
				EmitSoundOn("Hero_OgreMagi.Fireblast.x1", caster)
				local last_time = GameRules:GetGameTime()
				GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("jn_F9_10"),
					function()
						local now = GameRules:GetGameTime()
						if now - last_time >= multicast_delay then
							last_time = now
							times = times + 1
							local duration = event_ab:GetSpecialValueFor("stuntime")
							if target:IsConsideredHero() then
								duration = event_ab:GetSpecialValueFor("stuntime_to_king")
							end
							target:RemoveModifierByName("modifier_jn_F9_00_buff")
							event_ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_F9_00_buff", {Duration=duration})
							ParticleManager:DestroyParticle(particleId, true)
							particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
							if times == 2 then
								ParticleManager:SetParticleControl(particleId, 1, Vector(times,1,multicast_delay*times))
								return nil
							else
								ParticleManager:SetParticleControl(particleId, 1, Vector(times,2,0))
							end
						end
						return 1/30
					end
				,1/30)
			end
		end
	end
	if keys.Mode == 3 then
		local caster = keys.attacker
		local ab = keys.ability
		caster:GiveMana(ab:GetSpecialValueFor("mana"))
	end
end
function jn_F9_11(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_BASIC,0,caster:GetTeamNumber()) == UF_SUCCESS then
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_G3_11(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.unit
	local duration = keys.Duration
	if not HasLabel(target,"SummonUnit") then
		local spawnunit = CreateUnitByName(target:GetUnitName(), target:GetOrigin(), true, caster, caster, caster:GetTeamNumber())
		UnitManager:SummonUnit(caster,spawnunit)
		ab:ApplyDataDrivenModifier(caster, spawnunit, "modifier_jn_G3_11_buff", nil)
		local last_time = GameRules:GetGameTime()
		spawnunit:SetContextThink(DoUniqueString("jn_G3_11"),
			function()
				local now = GameRules:GetGameTime()
				if now - last_time >= duration then
					spawnunit:RemoveSelf()
					-- if spawnunit:IsAlive() then
					-- 	spawnunit:ForceKill(false)
					-- end
					return nil
				end
				return 0
			end
		,0)
	end
end
function jn_G4_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityNoTarget(ab, caster:GetPlayerOwnerID())
	end
end
function jn_G4_11(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
		local target
		local hppercent = 100
		for i=#targets,1,-1 do
			local unit = targets[i]
			if IsCommander(unit) or HasLabel(unit,"jn_G4_11") or HasLabel(unit,"SummonUnit") or unit:HasModifier(keys.ModifierName) or unit:HasAbility("build_base") or unit:HasAbility("kexuanmajia") then
				table.remove(targets,i)
			else
				if hppercent > unit:GetHealthPercent() and unit:GetHealthPercent() > 5 and unit:GetHealthPercent() <= 80 then
					target = unit
					hppercent = unit:GetHealthPercent()
				end
			end
		end
		if target then
			AddLabel(target,"jn_G4_11")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_G4_11_removelabel(keys)
	local target = keys.target
	RemoveLabel(target,"jn_G4_11")
end
function jn_G5_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
		ab:StartCooldown(99999)
	end
end
function jn_G5_10b(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityNoTarget(ab, caster:GetPlayerOwnerID())
	end
end
function jn_G6_11a(keys)
	local damage = keys.Damage
	local target = keys.target
	local number = math.floor(damage)
	local presymbol = 0
	local pidx = ParticleManager:CreateParticle("particles/msg_fx/msg_crit.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)

	local digits = 0
	if number ~= nil then
		digits = #tostring(number)
	end
	if presymbol ~= nil then
		digits = digits + 1
	end

	ParticleManager:SetParticleControl(pidx, 1, Vector(presymbol, tonumber(number), 0))
	ParticleManager:SetParticleControl(pidx, 2, Vector(1, digits, 0))
	ParticleManager:SetParticleControl(pidx, 3, Vector(191,0,191))
end
function jn_G6_11b(keys)
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 1 then
		local AandD = GetAandDSystem(target)
		if AandD then
			AandD:AddAttacktypeResistance("magic",ab:GetSpecialValueFor("resistance")*0.01,ab:GetAbilityName())
		end
	end
	if keys.Mode == 2 then
		local AandD = GetAandDSystem(target)
		if AandD then
			AandD:RemoveAttacktypeResistance("magic",ab:GetAbilityName())
		end
	end
end
function jn_G7_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,caster:GetTeamNumber()) == UF_SUCCESS then
		EmitSoundOn("Hero_Antimage.ManaBreak", target)
		local particleId = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf",PATTACH_ABSORIGIN_FOLLOW,target)
		ParticleManager:ReleaseParticleIndex(particleId)
		target:ReduceMana(ab:GetSpecialValueFor("manaburn"))
		DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),(target:GetMaxMana()-target:GetMana())*ab:GetSpecialValueFor("coefficient"),true)
	end
end
function jn_G7_11b(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local unit = keys.unit
	local targets = FindUnitsInRadius(caster:GetTeamNumber(),unit:GetAbsOrigin(),nil,ab:GetSpecialValueFor("radius"),DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,false)
	for n,target in pairs(targets) do
		target:ReduceMana(ab:GetSpecialValueFor("manaburn"))
		DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),(unit:GetMaxMana()-unit:GetMana())*ab:GetSpecialValueFor("coefficient"),true)
	end
	local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_antimage/antimage_manavoid.vpcf",PATTACH_ABSORIGIN_FOLLOW,unit)
	ParticleManager:SetParticleControl(particleId,1,Vector(ab:GetSpecialValueFor("radius"),0,0))
	ParticleManager:ReleaseParticleIndex(particleId)
end
function jn_G8_10b(keys)
	local caster = keys.attacker
	if caster:IsIllusion() then return end
	local ab = keys.ability
	local illusion = CreateIllusionByUnit(caster,ab,caster:GetAbsOrigin()+RandomVector(50),-100,ab:GetSpecialValueFor("illusion_damage")-100,ab:GetSpecialValueFor("illusion_duration"))
	ab:ApplyDataDrivenModifier(caster,illusion,"modifier_jn_G8_10b_illusion",{})
	local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_lancer/phantom_lancer_spawn.vpcf",PATTACH_ABSORIGIN_FOLLOW,illusion)
	ParticleManager:SetParticleControlEnt(particleId,1,illusion,PATTACH_ABSORIGIN_FOLLOW,nil,illusion:GetAbsOrigin(),true)
	ParticleManager:ReleaseParticleIndex(particleId)
end
function jn_G8_11a(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if HasLabel(target,"SummonUnit") or target:IsIllusion() then
		ab:ApplyDataDrivenModifier(caster,caster,"modifier_jn_G8_11a_crit",{})
	else
		caster:RemoveModifierByName("modifier_jn_G8_11a_crit")
	end
end
function jn_R1_10(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO+DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, true)
		for i=#targets,1,-1 do
			local unit = targets[i]
			if HasLabel(unit,"jn_R1_10") or unit:HasModifier(keys.ModifierName) or not unit:HasFlyMovementCapability() then
				table.remove(targets,i)
			end
		end
		if #targets > 0 then
			local target = targets[1]
			AddLabel(target,"jn_R1_10")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_R1_10_finish(keys)
	local target = keys.target
	target:StopSound("Hero_Puck.Dream_Coil")
	RemoveLabel(target,"jn_R1_10")
end
function jn_R1_11b(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityImmediately(ab, caster:GetPlayerOwnerID())
	end
end
function jn_R2_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	target:RemoveModifierByNameAndCaster(keys.ModifierName, caster)
	ab:ApplyDataDrivenModifier(caster, target, keys.ModifierName, {duration=keys.Duration})
end
function jn_R2_11(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		caster.jn_R2_11_attackcount = caster.jn_R2_11_attackcount or ab:GetSpecialValueFor("maxsoulcount")
		caster:SetModifierStackCount("modifier_jn_R2_11", caster, caster.jn_R2_11_attackcount)
	end
	if keys.Mode == 2 then
		caster.jn_R2_11_attackcount = caster.jn_R2_11_attackcount + 1
		caster:SetModifierStackCount("modifier_jn_R2_11", caster, caster.jn_R2_11_attackcount)
	end
	if keys.Mode == 3 then
		if caster.jn_R2_11_attackcount == ab:GetSpecialValueFor("maxsoulcount") then
			local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, true)
			if #targets > 0 then
				local target = targets[RandomInt(1, #targets)]
				caster.jn_R2_11_attackcount = 0
				caster:SetModifierStackCount("modifier_jn_R2_11", caster, caster.jn_R2_11_attackcount)
				local projectile_info = 
				{
					Ability = ab,
					Source = caster,
					Target = target,
					EffectName = "particles/units/heroes/hero_visage/visage_soul_assumption_bolt6.vpcf",
					iMoveSpeed = 900,
					vSourceLoc = caster:GetAbsOrigin(),
					iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
					bProvidesVision = false,
					bDodgeable = true,
					bIsAttack = false,
					bReplaceExisting = false,
				}
				ProjectileManager:CreateTrackingProjectile(projectile_info)
				caster:EmitSound("Hero_Visage.SoulAssumption.Cast")
			end
		end
	end
end
function jn_R3_00(keys)
	local caster = keys.caster
	local target = keys.target
	local damage = keys.Damage
	local ab = keys.ability
	local targets1 = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius1"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
	local targets2 = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius2"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
	for i=#targets2,1,-1 do
		local v = targets2[i]
		for n,u in pairs(targets1) do
			if u == v then
				table.remove(targets2,i)
			end
		end
	end
	for i,unit in pairs(targets1) do
		if unit ~= target then
			DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage*ab:GetSpecialValueFor("damagepercent1")*0.01,false)
		end
	end
	for i,unit in pairs(targets2) do
		if unit ~= target then
			DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage*ab:GetSpecialValueFor("damagepercent2")*0.01,false)
		end
	end
end
function jn_R3_10(keys)
	local caster = keys.caster
	local target = keys.target
	local ab = keys.ability
	DamageManager:SpellDamage(caster,target,ab:GetSpecialValueFor("damage")*0.01*target:GetMaxHealth()*0.5)
end
function jn_R4_00(keys)
	local caster = keys.attacker
	local target = keys.target
	local damage = keys.Damage
	local ab = keys.ability
	local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf", PATTACH_ABSORIGIN, target)
	ParticleManager:SetParticleControlEnt(particleId,0,target,PATTACH_POINT,"attach_hitloc",target:GetOrigin(),true)
	ParticleManager:SetParticleControl(particleId, 1, Vector(ab:GetSpecialValueFor("radius1"),1,1))
	ParticleManager:ReleaseParticleIndex(particleId)
	local targets1 = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius1"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
	local targets2 = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius2"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
	for i=#targets2,1,-1 do
		local v = targets2[i]
		for n,u in pairs(targets1) do
			if u == v then
				table.remove(targets2,i)
			end
		end
	end
	for i,unit in pairs(targets1) do
		if unit ~= target then
			DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage*ab:GetSpecialValueFor("damagepercent1")*0.01,false)
		end
	end
	for i,unit in pairs(targets2) do
		if unit ~= target then
			DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage*ab:GetSpecialValueFor("damagepercent2")*0.01,false)
		end
	end
end
function jn_R4_11(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 1 then
		if ab:IsCooldownReady() then
			local projectile_info = 
				{
					Ability = ab,
					Source = caster,
					Target = target,
					EffectName = "particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf",
					iMoveSpeed = 900,
					vSourceLoc = caster:GetAbsOrigin(),
					iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
					bProvidesVision = false,
					bDodgeable = true,
					bIsAttack = true,
					bReplaceExisting = false,
				}
			ProjectileManager:CreateTrackingProjectile(projectile_info)
			ab:StartCooldown(ab:GetCooldown(ab:GetLevel()))
		end
	end
	if keys.Mode == 2 then
		DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),caster:GetAttackDamage(),true)
	end
end
function jn_R5_00(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,caster:GetTeamNumber()) == UF_SUCCESS then
		DamageManager:CustonDamage(caster,target,"P",target:GetMaxHealth()*ab:GetSpecialValueFor("damage")*0.01,false)
	end
end
function jn_R5_10(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,caster:GetTeamNumber()) == UF_SUCCESS then
		if target:HasFlyMovementCapability() then
			DamageManager:CustonDamage(caster,target,"P",target:GetMaxHealth()*ab:GetSpecialValueFor("damage2")*0.01,false)
		else
			DamageManager:CustonDamage(caster,target,"P",target:GetMaxHealth()*ab:GetSpecialValueFor("damage1")*0.01,false)
		end
	end
end
function jn_R6_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
			caster:CastAbilityNoTarget(ab, caster:GetPlayerOwnerID())
		end
	end
	if keys.Mode == 2 then
		local target = keys.target
		local count = ab:GetSpecialValueFor("count")-1
		local targets = FindUnitsInRadius(caster:GetTeamNumber(),caster:GetAbsOrigin(),nil,ab:GetSpecialValueFor("radius"),DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,FIND_CLOSEST,true)
		for i,unit in pairs(targets) do
			if unit ~= target then
				local randomtable = {DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,DOTA_PROJECTILE_ATTACHMENT_ATTACK_2}
				local projectile_info = 
				{
					Ability = ab,
					Source = caster,
					Target = unit,
					EffectName = "particles/units/heroes/hero_gyrocopter/gyro_base_attack.vpcf",
					iMoveSpeed = 1900,
					vSourceLoc = caster:GetAbsOrigin(),
					iSourceAttachment = randomtable[RandomInt(1, #randomtable)],
					bProvidesVision = false,
					bDodgeable = true,
					bIsAttack = true,
					bReplaceExisting = false,
				}
				ProjectileManager:CreateTrackingProjectile(projectile_info)
				count = count - 1
			end
			if count == 0 then break end
		end
	end
	if keys.Mode == 3 then
		local target = keys.target
		DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),caster:GetAttackDamage(),false)
	end
end
function jn_R6_11b(keys)
	local ab = keys.ability
	ab.group = ab.group or {}
	ab.particlegroup = ab.particlegroup or {}
	if keys.Mode == 1 then
		local caster = keys.attacker
		local target = keys.target
		if UnitFilter(target,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,caster:GetTeamNumber()) == UF_SUCCESS then
			local boolean = true
			for i,unit in pairs(ab.group) do
				if unit == target then
					boolean = false
					break
				end
			end
			if boolean then
				local particleId = ParticleManager:CreateParticle("particles/gyro_calldown_first.vpcf", PATTACH_POINT, caster)
				local randomtable = {"attach_rocket1","attach_rocket2"}
				ParticleManager:SetParticleControlEnt(particleId, 0, caster, PATTACH_POINT, randomtable[RandomInt(1, #randomtable)], caster:GetOrigin(), true)
				ParticleManager:SetParticleControlEnt(particleId, 1, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetOrigin(), true)
				ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_R6_11b_buff", {Duration=ab:GetSpecialValueFor("wait_time")})
				table.insert(ab.group,target)
				table.insert(ab.particlegroup,particleId)
			end
		end
	end
	if keys.Mode == 2 then
		local caster = keys.caster
		local target = keys.target
		for i,unit in pairs(ab.group) do
			if unit == target then
				if ab.particlegroup[i] then
					local targets = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
					for i,emun in pairs(targets) do
						if emun ~= target then
							DamageManager:CustonDamage(caster,emun,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),ab:GetSpecialValueFor("other_damage"),false)
						end
					end
					if target:IsAlive() then
						if target:GetHealth() <= ab:GetSpecialValueFor("kill_health") then
							target:Kill(ab, caster)
						else
							DamageManager:CustonDamage(caster,target,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),ab:GetSpecialValueFor("damage"),false)
						end
					end
					EmitSoundOnLocationWithCaster(target:GetAbsOrigin(), "Hero_Gyrocopter.CallDown.Damage", caster)
					ParticleManager:ReleaseParticleIndex(ab.particlegroup[i])
				end
				if not target:HasModifier("modifier_jn_R6_11b_buff") then
					target:RemoveModifierByName("modifier_jn_R6_11b_buff_hidden")
				end
				table.remove(ab.group,i)
				table.remove(ab.particlegroup,i)
				break
			end
		end
	end
	if keys.Mode == 3 then
		local caster = keys.caster
		for i=#ab.group,1,-1 do
			local target = ab.group[i]
			if ab.particlegroup[i] then
				ParticleManager:DestroyParticle(ab.particlegroup[i], true)
				ab.particlegroup[i] = nil
			end
			if target:HasModifier("modifier_jn_R6_11b_buff") then
				target:RemoveModifierByNameAndCaster("modifier_jn_R6_11b_buff", caster)
			end
		end
		ab.particlegroup = nil
		ab.group = nil
	end
end
function jn_R7_00(keys)
	local caster = keys.caster
	local target = keys.target
	local damage = keys.Damage
	local ab = keys.ability
	local targets1 = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius1"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
	local targets2 = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius2"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
	for i=#targets2,1,-1 do
		local v = targets2[i]
		for n,u in pairs(targets1) do
			if u == v then
				table.remove(targets2,i)
			end
		end
	end
	for i,unit in pairs(targets1) do
		if unit ~= target then
			DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage*ab:GetSpecialValueFor("damagepercent1")*0.01,false)
		end
	end
	for i,unit in pairs(targets2) do
		if unit ~= target then
			DamageManager:CustonDamage(caster,unit,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage*ab:GetSpecialValueFor("damagepercent2")*0.01,false)
		end
	end
end
function jn_R7_10(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 1 then
		if target:HasFlyMovementCapability() and target:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
			ab:ApplyDataDrivenModifier(caster, target, "modifier_jn_R7_10_buff", nil)
		end
	end
	if keys.Mode == 2 then
		target:RemoveModifierByNameAndCaster("modifier_jn_R7_10_buff",caster)
	end
end
function jn_X1_00a(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityNoTarget(ab, caster:GetPlayerOwnerID())
	end
end
function jn_X3_00c(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) and not caster:IsIllusion() then
			caster:CastAbilityNoTarget(ab, caster:GetPlayerOwnerID())
		end
	end
	if keys.Mode == 2 then
		local origin = caster:GetAbsOrigin()
		local angle = caster:GetAngles()
		local radius = 75
		local vRandomSpawnPos = {
			Vector(origin.x+math.cos(math.rad(angle.y+90))*radius,origin.y+math.sin(math.rad(angle.y+90))*radius,origin.z),
			Vector(origin.x-math.cos(math.rad(angle.y+90))*radius,origin.y-math.sin(math.rad(angle.y+90))*radius,origin.z),
		}
		FindClearSpaceForUnit(caster, table.remove(vRandomSpawnPos,RandomInt(1,#vRandomSpawnPos)), true)
		CreateIllusionByUnit(caster,ab,table.remove(vRandomSpawnPos,RandomInt(1,#vRandomSpawnPos)),ab:GetSpecialValueFor("incoming_damage"),ab:GetSpecialValueFor("outgoing_damage"),ab:GetSpecialValueFor("duration"))
	end
end
function jn_X3_10c(keys)
	local caster = keys.caster
	local ab = keys.ability
	if keys.Mode == 1 then
		if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) and not caster:IsIllusion() then
			caster:CastAbilityNoTarget(ab, caster:GetPlayerOwnerID())
		end
	end
	if keys.Mode == 2 then
		local origin = caster:GetAbsOrigin()
		local angle = caster:GetAngles()
		local radius = 100
		local vRandomSpawnPos = {
			Vector(origin.x-math.cos(math.rad(angle.y))*radius,origin.y-math.sin(math.rad(angle.y))*radius,origin.z),
			Vector(origin.x,origin.y,origin.z),
		}
		FindClearSpaceForUnit(caster, table.remove(vRandomSpawnPos,1), true)
		CreateIllusionByUnit(caster,ab,table.remove(vRandomSpawnPos,1),ab:GetSpecialValueFor("incoming_damage"),ab:GetSpecialValueFor("outgoing_damage"),ab:GetSpecialValueFor("duration"))
	end
end
function jn_X4_00a(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
		local target
		local hppercent = 100
		local count = 0
		for i=#targets,1,-1 do
			local unit = targets[i]
			if IsCommander(unit) or unit:HasAbility("build_base") or unit:HasAbility("kexuanmajia") then
				table.remove(targets,i)
			else
				if unit:GetHealthPercent() > 5 and unit:GetHealthPercent() <= 70 then
					count = count + 1
					if hppercent > unit:GetHealthPercent() then
						target = unit
						hppercent = unit:GetHealthPercent()
					end
				end
			end
		end
		if target and count >= 1 then
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_X4_00a_heal(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	local heal = ab:GetSpecialValueFor("heal")
	local healreduce = ab:GetSpecialValueFor("healreduce")*0.01
	local maxcount = ab:GetSpecialValueFor("count")
	local count = 0
	local group = {}
	local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_furion/furion_wrath_of_nature_old.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControlEnt(particleId, 0, caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particleId)
	target:EmitSound("Hero_Enchantress.EnchantCast")
	local last_time = GameRules:GetGameTime()
	GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("jn_X4_00a"),
		function ()
			local now = GameRules:GetGameTime()
			if now - last_time >= 0.2 then
				last_time = now

				target:Heal(heal, caster)
				table.insert(group,target)
				if count < maxcount then
					local targets = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
					for i=#targets,1,-1 do
						local unit = targets[i]
						for n,u in pairs(group) do
							if unit == u then
								table.remove(targets,i)
							end
						end
					end
					local newtarget
					local hppercent = 100
					for i=#targets,1,-1 do
						local unit = targets[i]
						if IsCommander(unit) or unit:HasAbility("build_base") or unit:HasAbility("kexuanmajia") then
							table.remove(targets,i)
						else
							if hppercent >= unit:GetHealthPercent() then
								newtarget = unit
								hppercent = unit:GetHealthPercent()
							end
						end
					end
					if newtarget then
						local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_furion/furion_wrath_of_nature_old.vpcf", PATTACH_CUSTOMORIGIN, newtarget)
						ParticleManager:SetParticleControlEnt(particleId, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
						ParticleManager:SetParticleControlEnt(particleId, 1, newtarget, PATTACH_POINT_FOLLOW, "attach_hitloc", newtarget:GetAbsOrigin(), true)
						ParticleManager:ReleaseParticleIndex(particleId)
						newtarget:EmitSound("Hero_Enchantress.EnchantCast")

						target = newtarget
						heal = heal * (1-healreduce)
						count = count + 1
					else
						return nil
					end
				else
					return nil
				end
			end
			return 0
		end
	, 0)
end
function jn_X4_00b_1(caster,ab,target,damage,reducedamage,count,maxcount,group,effectname)
	count = count + 1
	table.insert(group,target)
	local targets = FindUnitsInRadius(caster:GetTeamNumber(),target:GetAbsOrigin(),nil,ab:GetSpecialValueFor("radius"),DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,FIND_CLOSEST,true)
	for i=#targets,1,-1 do
		local v = targets[i]
		for n,u in pairs(group) do
			if u == v then
				table.remove(targets,i)
			end
		end
	end
	local target_other = targets[1]
	if target_other then
		local projectile_info = 
		{
			Ability = ab,
			Source = target,
			Target = target_other,
			EffectName = effectname,
			iMoveSpeed = 900,
			vSourceLoc = target:GetAbsOrigin(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_HITLOCATION,
			bProvidesVision = false,
			bDodgeable = true,
			bIsAttack = true,
			bReplaceExisting = false,
		}
		ProjectileManager:CreateTrackingProjectile(projectile_info)

		local last_time = GameRules:GetGameTime()
		local time = (target_other:GetAbsOrigin()-target:GetAbsOrigin()):Length2D() / 900
		target_other:SetContextThink(DoUniqueString("jn_X4_00b"),
			function()
				local now = GameRules:GetGameTime()
				if now - last_time >= time then
					damage = damage * (1-reducedamage)
					DamageManager:CustonDamage(caster,target_other,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage,false)
					target_other:EmitSound("n_creep_Ranged.ProjectileImpact")
					if count < maxcount then
						jn_X4_00b_1(caster,ab,target_other,damage,reducedamage,count,maxcount,group,effectname)
					end
					return nil
				end
				return 0
			end
		,0)
	end
end
function jn_X4_00b(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	local damage = keys.Damage
	jn_X4_00b_1(caster,ab,target,damage,ab:GetSpecialValueFor("reducedamage")*0.01,0,ab:GetSpecialValueFor("count"),{},keys.EffectName)
end
function jn_X5_00a(keys)
	local ab = keys.ability
	if keys.Mode == 1 then
		local caster = keys.attacker
		local target = keys.target
		if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
	if keys.Mode == 2 then
		local caster = keys.caster
		local target = keys.target
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), target:GetOrigin(), nil, ab:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, true)
		local damage = ab:GetSpecialValueFor("damage")
		local maxcount = ab:GetSpecialValueFor("count")
		local count = 0
		for i,unit in pairs(targets) do
			if count < maxcount then
				count = count + 1
				local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf", PATTACH_CUSTOMORIGIN, target)
				ParticleManager:SetParticleControlEnt(particleId, 0, caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetOrigin(), true)
				ParticleManager:SetParticleControlEnt(particleId, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetOrigin(), true)
				ParticleManager:SetParticleControlEnt(particleId, 2, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetOrigin(), true)
				ParticleManager:ReleaseParticleIndex(particleId)
				DamageManager:SpellDamage(caster,unit,damage)
			end
		end
	end
end
function jn_X5_00b(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	target:Purge(true, false, false, false, false)
	if HasLabel(target,"SummonUnit") then
		DamageManager:SpellDamage(caster,target,ab:GetSpecialValueFor("damage"))
	end
end
function jn_X5_00c(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	ab:ApplyDataDrivenModifier(caster, target, keys.ModifierName, nil)
	target:SetContextNum("jn_X5_00c_absorb", ab:GetSpecialValueFor("absorb"), 0)
end
function jn_X5_10c(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	ab:ApplyDataDrivenModifier(caster, target, keys.ModifierName, nil)
	target:SetContextNum("jn_X5_10c_absorb", ab:GetSpecialValueFor("absorb"), 0)
end
function jn_X6_00b(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityNoTarget(ab, caster:GetPlayerOwnerID())
	end
end
function jn_X8_00b(keys)
	local caster = keys.attacker
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:CastAbilityNoTarget(ab, caster:GetPlayerOwnerID())
	end
end
function Devour(keys)
	local caster = keys.caster
	local target = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		500,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		true)
	local ab = keys.ability
	if (target[1]) then
		for i=0,15 do	
			local target_ab=target[1]:GetAbilityByIndex(i)
			if (target_ab) then
				local abname=target_ab:GetAbilityName()
				if string.find(abname, "jn") then
					AbilityManager:AddAndSet( caster, abname)
				end
			end
		end
		target[1]:Kill(ab,caster)
	end
	
end
function jn_R8_00(keys)
	local caster = keys.caster
	local ab = keys.ability
	print("judging!")
	if ab:IsCooldownReady() then
		caster:CastAbilityNoTarget(ab, caster:GetPlayerOwnerID())
	end
end

function jn_X7_00b(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.attacker
	local damage = keys.Damage
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		caster:SpendMana(ab:GetManaCost(ab:GetLevel()), ab)
		print(damage*ab:GetSpecialValueFor("cleave_damage")*0.01)
		DoCleaveAttack(caster, target, ab, damage*ab:GetSpecialValueFor("cleave_damage")*0.01,150,400, 600,"particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf")
	end
end
--雇佣兵技能
function jn_hire_8_1(caster,ab,target,damage,reducedamage,count,maxcount,group)
	count = count + 1
	table.insert(group,target)
	local targets = FindUnitsInRadius(caster:GetTeamNumber(),target:GetAbsOrigin(),nil,ab:GetSpecialValueFor("radius"),DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_NO_INVIS+DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,FIND_CLOSEST,true)
	for i=#targets,1,-1 do
		local v = targets[i]
		for n,u in pairs(group) do
			if u == v then
				table.remove(targets,i)
			end
		end
	end
	local target_other = targets[1]
	if target_other then
		local projectile_info = 
		{
			Ability = ab,
			Source = target,
			Target = target_other,
			EffectName = "particles/base_attacks/ranged_siege_bad.vpcf",
			iMoveSpeed = 900,
			vSourceLoc = target:GetAbsOrigin(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_HITLOCATION,
			bProvidesVision = false,
			bDodgeable = true,
			bIsAttack = true,
			bReplaceExisting = false,
		}
		ProjectileManager:CreateTrackingProjectile(projectile_info)

		local last_time = GameRules:GetGameTime()
		local time = (target_other:GetAbsOrigin()-target:GetAbsOrigin()):Length2D() / 900
		target_other:SetContextThink(DoUniqueString("jn_hire_8"),
			function()
				local now = GameRules:GetGameTime()
				if now - last_time >= time then
					damage = damage * (1-reducedamage)
					DamageManager:CustonDamage(caster,target_other,UnitManager:GetAttackTypeFromName(caster:GetUnitName()),damage,false)
					if count < maxcount then
						jn_hire_8_1(caster,ab,target_other,damage,reducedamage,count,maxcount,group)
					end
					return nil
				end
				return 0
			end
		,0)
	end
end
function jn_hire_8(keys)
	local caster = keys.attacker
	local ab = keys.ability
	local target = keys.target
	local damage = keys.Damage
	jn_hire_8_1(caster,ab,target,damage,ab:GetSpecialValueFor("reducedamage")*0.01,0,ab:GetSpecialValueFor("count"),{})
end
function jn_hire_12c(keys)
	local caster = keys.caster
	local ab = keys.ability
	if ab:IsCooldownReady() and caster:GetMana() >= ab:GetManaCost(ab:GetLevel()) then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, ab:GetCastRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, true)
		for i=#targets,1,-1 do
			local unit = targets[i]
			if HasLabel(unit,"jn_hire_12c") or unit:HasModifier(keys.ModifierName) then
				table.remove(targets,i)
			end
		end
		if #targets > 0 then
			local target = targets[1]
			AddLabel(target,"jn_hire_12c")
			caster:CastAbilityOnTarget(target, ab, caster:GetPlayerOwnerID())
		end
	end
end
function jn_hire_12c_removelabel(keys)
	local target = keys.target
	target:StopSound("Hero_DoomBringer.Doom")
	RemoveLabel(target,"jn_hire_12c")
end
--军备
function FilterTarget(keys)
	local caster
	if keys.Caster == "CASTER" then
		caster = keys.caster
	elseif keys.Caster == "TARGET" then
		caster = keys.target
	elseif keys.Caster == "UNIT" then
		caster = keys.unit
	elseif keys.Caster == "ATTACKER" then
		caster = keys.attacker
	else
		caster = keys.caster
	end
	local target
	if keys.TargetUnit == "CASTER" then
		target = keys.caster
	elseif keys.TargetUnit == "TARGET" then
		target = keys.target
	elseif keys.TargetUnit == "UNIT" then
		target = keys.unit
	elseif keys.TargetUnit == "ATTACKER" then
		target = keys.attacker
	else
		target = keys.caster
	end
	if target then
		local ab = keys.ability
		if target:HasAbility("build_base") or target:HasAbility("kexuanmajia") then
			if caster then
				caster:Interrupt()
				BTFGeneral:ShowError(caster:GetPlayerOwnerID(),"#CantTarget","General.NoGold")
			end
		end
	end
end


function item_armament_4(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 0 then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
		for i,unit in pairs(targets) do
			if unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
				if unit:HasModifier("modifier_armament_4_aura") then
					unit:RemoveModifierByName("modifier_armament_4_aura")
				end
			end
		end
	end
	if keys.Mode == 1 then
		if target:GetPlayerOwnerID() then
			if caster:GetPlayerOwnerID() == target:GetPlayerOwnerID() then
				ab:ApplyDataDrivenModifier(caster, target, "modifier_armament_4_buff", nil)
			end
		end
	end
	if keys.Mode == 2 then
		if target:HasModifier("modifier_armament_4_buff") then
			target:RemoveModifierByName("modifier_armament_4_buff")
		end
	end
end
function item_armament_5(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 1 then
		target:SetModelScale(target:GetModelScale()+0.25)
		local healthpercent = target:GetHealthPercent()*0.01
		local health = ab:GetSpecialValueFor("health")
		target:SetBaseMaxHealth(target:GetBaseMaxHealth()+ab:GetSpecialValueFor("health"))
		target:SetMaxHealth(target:GetMaxHealth()+ab:GetSpecialValueFor("health"))
		target:SetHealth(target:GetMaxHealth()*healthpercent)
		target:SetContextNum("item_armament_5_health", health, 0)
	end
	if keys.Mode == 2 then
		target:SetModelScale(target:GetModelScale()-0.25)
		local healthpercent = target:GetHealthPercent()*0.01
		local health = target:GetContext("item_armament_5_health")
		target:SetBaseMaxHealth(target:GetBaseMaxHealth()-health)
		target:SetMaxHealth(target:GetMaxHealth()-health)
		target:SetHealth(target:GetMaxHealth()*healthpercent)
	end
end
function item_armament_10(keys)
	local target = keys.target
	target:StopSound("Hero_Alchemist.AcidSpray")
end
function item_armament_13(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if not ab then
		for i=0,5,1 do
			if caster:GetItemInSlot(i):GetName() == "item_armament_13_level2" then
				ab = caster:GetItemInSlot(i)
			end
		end
		if not ab then
			for i=0,5,1 do
				if caster:GetItemInSlot(i):GetName() == "item_armament_13_level3" then
					ab = caster:GetItemInSlot(i)
				end
			end
		end
	end
	if keys.Mode == 1 then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, ab:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, true)
		if #targets > 0 then
			local target_other = targets[RandomInt(1,#targets)]
			local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_razor_reduced_flash/razor_unstable_current_reduced_flash.vpcf", PATTACH_ABSORIGIN, target_other)
			ParticleManager:SetParticleControl(particleId, 0, target:GetAbsOrigin()+Vector(0,0,512))
			ParticleManager:SetParticleControlEnt(particleId, 1, target_other, PATTACH_POINT_FOLLOW, "attach_hitloc", target_other:GetAbsOrigin(), true)
			DamageManager:SpellDamage(caster,target_other,ab:GetSpecialValueFor("damage"))
			target:EmitSound("Hero_razor.lightning")
		end
	end
	if keys.Mode == 2 then
		target:StopSound("Hero_Razor.Storm.Loop")
	end
end
function item_armament_16(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 0 then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
		for i,unit in pairs(targets) do
			if unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
				if unit:HasModifier("modifier_armament_16_aura") then
					unit:RemoveModifierByName("modifier_armament_16_aura")
				end
			end
		end
	end
	if keys.Mode == 1 then
		if target:GetPlayerOwnerID() then
			if caster:GetPlayerOwnerID() == target:GetPlayerOwnerID() then
				ab:ApplyDataDrivenModifier(caster, target, "modifier_armament_16_buff", nil)
			end
		end
	end
	if keys.Mode == 2 then
		if target:HasModifier("modifier_armament_16_buff") then
			target:RemoveModifierByName("modifier_armament_16_buff")
		end
	end
end
function item_armament_19(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 0 then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE+DOTA_UNIT_TARGET_FLAG_RANGED_ONLY, 0, true)
		for i,unit in pairs(targets) do
			if unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
				if unit:HasModifier("modifier_armament_19_aura") then
					unit:RemoveModifierByName("modifier_armament_19_aura")
				end
			end
		end
	end
	if keys.Mode == 1 then
		if target:GetPlayerOwnerID() then
			if caster:GetPlayerOwnerID() == target:GetPlayerOwnerID() then
				ab:ApplyDataDrivenModifier(caster, target, "modifier_armament_19_buff", nil)
			end
		end
	end
	if keys.Mode == 2 then
		if target:HasModifier("modifier_armament_19_buff") then
			target:RemoveModifierByName("modifier_armament_19_buff")
		end
	end
end
function item_armament_20(keys)
	local target = keys.target
	target:StopSound("Hero_Phoenix.SunRay.Loop")
end
function item_armament_23(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 0 then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
		for i,unit in pairs(targets) do
			if unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
				if unit:HasModifier("modifier_armament_23_aura") then
					unit:RemoveModifierByName("modifier_armament_23_aura")
				end
			end
		end
	end
	if keys.Mode == 1 then
		if target:GetPlayerOwnerID() then
			if caster:GetPlayerOwnerID() == target:GetPlayerOwnerID() then
				ab:ApplyDataDrivenModifier(caster, target, "modifier_armament_23_buff", nil)
			end
		end
	end
	if keys.Mode == 2 then
		if target:HasModifier("modifier_armament_23_buff") then
			target:RemoveModifierByName("modifier_armament_23_buff")
		end
	end
end
function item_armament_24(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 0 then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
		for i,unit in pairs(targets) do
			if unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
				if unit:HasModifier("modifier_armament_24_aura") then
					unit:RemoveModifierByName("modifier_armament_24_aura")
				end
			end
		end
	end
	if keys.Mode == 1 then
		if target:GetPlayerOwnerID() then
			if caster:GetPlayerOwnerID() == target:GetPlayerOwnerID() then
				ab:ApplyDataDrivenModifier(caster, target, "modifier_armament_24_buff", nil)
			end
		end
	end
	if keys.Mode == 2 then
		if target:HasModifier("modifier_armament_24_buff") then
			target:RemoveModifierByName("modifier_armament_24_buff")
		end
	end
end
function item_armament_25(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 0 then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
		for i,unit in pairs(targets) do
			if unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
				if unit:HasModifier("modifier_armament_25_aura") then
					unit:RemoveModifierByName("modifier_armament_25_aura")
				end
			end
		end
	end
	if keys.Mode == 1 then
		if target:GetPlayerOwnerID() then
			if caster:GetPlayerOwnerID() == target:GetPlayerOwnerID() then
				ab:ApplyDataDrivenModifier(caster, target, "modifier_armament_25_buff", nil)
			end
		end
	end
	if keys.Mode == 2 then
		if target:HasModifier("modifier_armament_25_buff") then
			target:RemoveModifierByName("modifier_armament_25_buff")
		end
	end
end
function item_armament_26(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 0 then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
		for i,unit in pairs(targets) do
			if unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
				if unit:HasModifier("modifier_armament_26_aura") then
					unit:RemoveModifierByName("modifier_armament_26_aura")
				end
			end
		end
	end
	if keys.Mode == 1 then
		if target:GetPlayerOwnerID() then
			if caster:GetPlayerOwnerID() == target:GetPlayerOwnerID() then
				ab:ApplyDataDrivenModifier(caster, target, "modifier_armament_26_buff", nil)
			end
		end
	end
	if keys.Mode == 2 then
		if target:HasModifier("modifier_armament_26_buff") then
			target:RemoveModifierByName("modifier_armament_26_buff")
		end
	end
end
function item_armament_31(keys)
	local target = keys.target
	target:StopSound("Hero_Juggernaut.BladeFuryStart")
end
function item_armament_33(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	if keys.Mode == 0 then
		local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, 99999, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 0, true)
		for i,unit in pairs(targets) do
			if unit:GetPlayerOwnerID() == caster:GetPlayerOwnerID() then
				if unit:HasModifier("modifier_armament_33_aura") then
					unit:RemoveModifierByName("modifier_armament_33_aura")
				end
			end
		end
	end
	if keys.Mode == 1 then
		if target:GetPlayerOwnerID() then
			if caster:GetPlayerOwnerID() == target:GetPlayerOwnerID() then
				ab:ApplyDataDrivenModifier(caster, target, "modifier_armament_33_buff", nil)
			end
		end
	end
	if keys.Mode == 2 then
		if target:HasModifier("modifier_armament_33_buff") then
			target:RemoveModifierByName("modifier_armament_33_buff")
		end
	end
end
function item_armament_34(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	local bounty = target:GetGoldBounty() + ab:GetSpecialValueFor("extra_gold")
	if target:GetHealth() < ab:GetSpecialValueFor("health_value") then
		target:SetMaximumGoldBounty(bounty)
		target:SetMinimumGoldBounty(bounty)
		local particleId = ParticleManager:CreateParticle("particles/items2_fx/hand_of_midas.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(particleId, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc",caster:GetOrigin(), true)
		target:EmitSound("DOTA_Item.Hand_Of_Midas")
		target:Kill(ab,caster)
	end
end

function item_armament_35(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	local mana = ab:GetSpecialValueFor("mana")

	for i=0, 15, 1 do
		local current_ability = target:GetAbilityByIndex(i)
		if current_ability then
			current_ability:EndCooldown()
		end
	end
    target:SetMana(60)
end

function item_armament_37(keys)
	local caster = keys.caster
	local ab = keys.ability
	local target = keys.target
	target:SetMana(0)
	target:Purge(true, false, false, false, false)
	if HasLabel(target,"SummonUnit") then
		target:Kill(ab,caster)
	end
end

pudgesfood=nil;
function item_armament_39(keys)
	local caster = keys.caster
	local target = keys.target
		if (caster:HasItemInInventory("item_armament_39")) then
			for item_index = 0,5,1 do
				local item = caster:GetItemInSlot(item_index)
				if item then
					if item:GetName() == "item_armament_39" then
						caster:RemoveItem(item)
						local item = CreateItem("item_armament_40", nil, nil)
						caster:AddItem(item)
						--target:AddEffect(EF_NODRAW)
						--target:SetAbsOrigin(target:GetAbsOrigin()+Vector(0, 0,1000))
						pudgesfood=target
						break
					end					
				end
			end
		end
	
end
function item_armament_40(keys)
	local caster = keys.caster
	local point = keys.target_points[1]
	if (caster:HasItemInInventory("item_armament_40")) then
		for item_index = 0,5,1 do
			local item = caster:GetItemInSlot(item_index)
			if item then
				if item:GetName() == "item_armament_40" then
					--pudgesfood:RemoveEffect(EF_NODRAW)
					pudgesfood:SetAbsOrigin(point)
					i_teamnumber=pudgesfood:GetTeam()
					if i_teamnumber == DOTA_TEAM_GOODGUYS then
						v_order = Vector( 8500, 0, 0 )+point
					end
					if i_teamnumber == DOTA_TEAM_BADGUYS then
						v_order = Vector( -8500, 0, 0 )+point
					end
					v_order.x = math.min(v_order.x,6400)
					v_order.x = math.max(v_order.x,-6400)

					local newOrder = {                                        --发送攻击指令
						UnitIndex = pudgesfood:entindex(), 
						OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
						TargetIndex = nil, --Optional.  Only used when targeting units
						AbilityIndex = 0, --Optional.  Only used when casting abilities
						Position = v_order, --Optional.  Only used when targeting the ground
						Queue = 0 --Optional.  Used for queueing up abilities
			 		}
 
					ExecuteOrderFromTable(newOrder)

					caster:RemoveItem(item)
					local item = CreateItem("item_armament_39", nil, nil)
					caster:AddItem(item)
					
					break
				end					
			end
		end
	end
end


--单位特效
function particle_G3(keys)
	local caster = keys.target
	local color = Vector(keys.Red,keys.Green,keys.Blue)
	local particleId = ParticleManager:CreateParticle("particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_ambient_eyes_arcana_horns.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControlEnt(particleId, 0, caster, PATTACH_POINT_FOLLOW, "attach_eye_l", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 1, caster, PATTACH_POINT_FOLLOW, "attach_eye_r", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 2, caster, PATTACH_POINT_FOLLOW, "attach_mouth", caster:GetOrigin(), true)
	ParticleManager:SetParticleControl(particleId, 15, color)
	ParticleManager:SetParticleControl(particleId, 16, Vector(1,0,0))
	particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControlEnt(particleId, 0, caster, PATTACH_ABSORIGIN_FOLLOW, nil, caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 2, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 3, caster, PATTACH_POINT_FOLLOW, "attach_wing_l1", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 4, caster, PATTACH_POINT_FOLLOW, "attach_wing_l2", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 5, caster, PATTACH_POINT_FOLLOW, "attach_wing_l3", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 6, caster, PATTACH_POINT_FOLLOW, "attach_wing_r1", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 7, caster, PATTACH_POINT_FOLLOW, "attach_wing_r2", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 8, caster, PATTACH_POINT_FOLLOW, "attach_wing_r3", caster:GetOrigin(), true)
	ParticleManager:SetParticleControl(particleId, 15, color)
	ParticleManager:SetParticleControl(particleId, 16, Vector(1,0,0))
	ParticleManager:SetParticleControl(particleId, 1, Vector(1,0,0))
end
function particle_R6(keys)
	local caster = keys.target
	local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_gyrocopter/gyro_ambient.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControlEnt(particleId, 1, caster, PATTACH_POINT_FOLLOW, "attach_prop1", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 2, caster, PATTACH_POINT_FOLLOW, "attach_prop2", caster:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particleId, 3, caster, PATTACH_POINT_FOLLOW, "attach_exhaust", caster:GetOrigin(), true)
	caster:StartGesture(ACT_DOTA_CONSTANT_LAYER)
end