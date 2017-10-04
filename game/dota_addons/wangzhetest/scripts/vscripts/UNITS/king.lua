

function Ability_holylight_Created(keys) 


    keys.caster:SetModifierStackCount('modifier_never_dead',keys.ability,GameRules.LeftLife)
    -- print("set king's life number "..GameRules.LeftLife.."  done")

end

function Ability_holylight(keys)
    local health = keys.caster:GetHealth()
    --print(health)
    local life = keys.caster:GetModifierStackCount('modifier_never_dead',keys.ability)
    if health < life+2 then
    	life = life - 1 
    	if life < 0 then
    		keys.caster:RemoveModifierByName('modifier_never_dead')
            keys.caster:ForceKill(false)
    	else
    		keys.caster:SetHealth(keys.caster:GetHealth()+10000)
            if keys.caster:GetTeamNumber() == 2 then
                EmitGlobalSound("chen_chen_ability_handgod_01")  --上帝之手的音效
                EmitGlobalSound("Hero_Chen.HandOfGodHealHero")
                local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_holy_persuasion.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, keys.caster)
                ParticleManager:SetParticleControl(particleId, 0, keys.caster:GetOrigin())
                ParticleManager:SetParticleControl(particleId, 1, keys.caster:GetOrigin())
                ParticleManager:SetParticleControl(particleId, 2, Vector(0.2,0,0))
                ParticleManager:ReleaseParticleIndex(particleId)
            else
                EmitGlobalSound("abaddon_abad_deathcoil_10")  --上帝之手的音效
                EmitGlobalSound("Hero_Abaddon.BorrowedTime")
                local particleId = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, keys.caster)
                keys.caster:SetContextThink(DoUniqueString("Ability_holylight"), function() ParticleManager:DestroyParticle(particleId, false) end, 1)
            end
    		keys.caster:SetModifierStackCount('modifier_never_dead',keys.ability,life)
		end
        if keys.caster:GetTeamNumber() == 2 then
            if life > 0 then
                GameRules.LeftLife = life
            else
                GameRules.LeftLife = 0
            end
            --rawset(_G, 'LeftLife', life)
            -- print("LeftLife is "..GameRules.LeftLife)
            CustomGameEventManager:Send_ServerToAllClients("SetBossLifeCount", {boss=keys.caster:entindex(),lifecount=GameRules.LeftLife})
        else
            if life > 0 then
                GameRules.RightLife = life
            else
                GameRules.RightLife = 0
            end            
            --rawset(_G, 'RightLife', life)
            print("RightLife is "..GameRules.RightLife)
            CustomGameEventManager:Send_ServerToAllClients("SetBossLifeCount", {boss=keys.caster:entindex(),lifecount=GameRules.RightLife})
        end


	end
end
