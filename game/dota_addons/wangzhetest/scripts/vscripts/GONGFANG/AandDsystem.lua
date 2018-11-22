--攻击丢失效果
function AttackFailed( keys )
	local caster = keys.attacker
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_MISS, caster, 0, nil)
end
function FangZhiFaDai(keys)
	local attacker = keys.attacker
	local target = keys.target
	if target:IsAttacking()==false then
		local newOrder = {
			UnitIndex = target:entindex(), 
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = attacker:entindex(), --Optional.  Only used when targeting units
			AbilityIndex = 0, --Optional.  Only used when casting abilities
			Position = nil, --Optional.  Only used when targeting the ground
			Queue = 0 --Optional.  Used for queueing up abilities
		}
		ExecuteOrderFromTable(newOrder)
	end
end
--多重箭
function DuoChongGongJiDamage( keys )

	local caster = keys.caster --攻击者
	local target = keys.target --目标

	if target:HasAbility("AandD") then
		DamageManager:CustonDamage(caster, target, UnitManager:GetAttackTypeFromName(caster:GetUnitName()), caster:GetAttackDamage(), false)
	end
end
function DuoChongGongJi( keys )

	local caster = keys.caster
	local target = keys.target
--只对远程有效
	if caster:IsRangedAttacker() then
		--获取攻击范围
		local radius = caster:Script_GetAttackRange() +100
		local teams = DOTA_UNIT_TARGET_TEAM_ENEMY
		local types = DOTA_UNIT_TARGET_BASIC+DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BUILDING
		local flags = DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE+DOTA_UNIT_TARGET_FLAG_NO_INVIS
		--获取周围的单位
		local group = FindUnitsInRadius(caster:GetTeamNumber(),caster:GetOrigin(),nil,radius,teams,types,flags,FIND_CLOSEST,true)
		--获取箭的数量
		local attack_count = keys.attack_count or 0
		--获取箭的特效
		local attack_effect = keys.attack_effect or "particles/econ/items/keeper_of_the_light/kotl_weapon_arcane_staff/keeper_base_attack_arcane_staff.vpcf"
		local attack_unit = {}

	--筛选离英雄最近的敌人
		for i,unit in pairs(group) do
			if (#attack_unit)==attack_count then
				break
			end

			if unit~=target then
				if unit:IsAlive() then
					table.insert(attack_unit,unit)
				end
			end
		end

		for i,unit in pairs(attack_unit) do
			local info =
						{
							Target = unit,
							Source = caster,
							Ability = keys.ability,
							EffectName = attack_effect,
							bDodgeable = true,
							iMoveSpeed = 1800,
							bProvidesVision = false,
							iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
						}
			projectile = ProjectileManager:CreateTrackingProjectile(info)

		end
	end
end