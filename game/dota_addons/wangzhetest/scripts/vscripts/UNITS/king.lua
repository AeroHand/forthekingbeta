

function Ability_holylight_Created(keys)
	local caster = keys.caster
	local ability = keys.ability

	if caster:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
		caster:SetModifierStackCount("modifier_never_dead", ability, Game:GetLeftLife())
	elseif caster:GetTeamNumber() == DOTA_TEAM_BADGUYS then
		caster:SetModifierStackCount("modifier_never_dead", ability, Game:GetRightLife())
	end
end

function Ability_holylight(keys)
	local caster = keys.caster
	local ability = keys.ability

	local health = caster:GetHealth()

	local life = caster:GetModifierStackCount("modifier_never_dead", ability)
	if health < life+2 then
		life = life - 1
		if life < 0 then
			caster:RemoveModifierByName("modifier_never_dead")
			caster:ForceKill(false)
		else
			caster:SetHealth(caster:GetHealth() + 10000)
			if caster:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
				EmitGlobalSound("chen_chen_ability_handgod_01")
				EmitGlobalSound("Hero_Chen.HandOfGodHealHero")
				local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_holy_persuasion.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, caster)
				ParticleManager:SetParticleControl(particleId, 0, caster:GetOrigin())
				ParticleManager:SetParticleControl(particleId, 1, caster:GetOrigin())
				ParticleManager:SetParticleControl(particleId, 2, Vector(0.2,0,0))
				ParticleManager:ReleaseParticleIndex(particleId)
			elseif caster:GetTeamNumber() == DOTA_TEAM_BADGUYS then
				EmitGlobalSound("abaddon_abad_deathcoil_10")
				EmitGlobalSound("Hero_Abaddon.BorrowedTime")
				local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, caster)
				caster:SetContextThink(DoUniqueString("Ability_holylight"), function() ParticleManager:DestroyParticle(particleId, false) end, 1)
			end
			caster:SetModifierStackCount("modifier_never_dead", ability, life)
		end
		if caster:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
			Game:ModifyLeftLife(-1)
		elseif caster:GetTeamNumber() == DOTA_TEAM_BADGUYS then
			Game:ModifyRightLife(-1)
		end
	end
end
