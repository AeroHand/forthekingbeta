"use strict";

var m_Ability = -1;
var m_QueryUnit = -1;
var m_bInLevelUp = false;

function SetAbility( ability, queryUnit, bInLevelUp )
{
	var bChanged = ( ability !== m_Ability || queryUnit !== m_QueryUnit );
	m_Ability = ability;
	m_QueryUnit = queryUnit;
	m_bInLevelUp = bInLevelUp;
	
	var canUpgradeRet = Abilities.CanAbilityBeUpgraded( m_Ability );
	var canUpgrade = ( canUpgradeRet == AbilityLearnResult_t.ABILITY_CAN_BE_UPGRADED );
	
	$.GetContextPanel().SetHasClass( "no_ability", ( ability == -1 ) );
	$.GetContextPanel().SetHasClass( "learnable_ability", bInLevelUp && canUpgrade );

	RebuildAbilityUI();
	UpdateAbility();
}

function AutoUpdateAbility()
{
	UpdateAbility();
	$.Schedule( 0.1, AutoUpdateAbility );
}

function UpdateAbility()
{
	var abilityButton = $( "#AbilityButton" );
	var abilityName = Abilities.GetAbilityName( m_Ability );

	var isControllable =  Entities.IsControllableByPlayer(m_QueryUnit, Players.GetLocalPlayer());
	var isEnemy = Entities.IsEnemy(m_QueryUnit);
	var noLevel =( 0 == Abilities.GetLevel( m_Ability ) || isEnemy);
	var isCastable = !Abilities.IsPassive( m_Ability ) && !noLevel && isControllable;
	var manaCost = Abilities.GetManaCost( m_Ability );
	var goldCost = Abilities.GetSpecialValueFor( m_Ability , "GoldCost");
	var hotkey = Abilities.GetKeybind( m_Ability, m_QueryUnit );
	var unitMana = Entities.GetMana( m_QueryUnit );

	$.GetContextPanel().SetHasClass( "no_level", noLevel );
	$.GetContextPanel().SetHasClass( "is_passive", !isCastable );
	$.GetContextPanel().SetHasClass( "no_mana_cost", ( 0 == manaCost || isEnemy) );
	$.GetContextPanel().SetHasClass( "no_gold_cost", ( 0 == goldCost || isEnemy) );
	$.GetContextPanel().SetHasClass( "insufficient_mana", !Abilities.IsOwnersManaEnough(m_Ability) );
	$.GetContextPanel().SetHasClass( "auto_cast_enabled", Abilities.GetAutoCastState(m_Ability) );
	$.GetContextPanel().SetHasClass( "toggle_enabled", Abilities.GetToggleState(m_Ability) );
	$.GetContextPanel().SetHasClass( "is_active", ( m_Ability == Abilities.GetLocalPlayerActiveAbility() ) );

	abilityButton.enabled = ( isCastable || m_bInLevelUp );
	
	$( "#HotkeyText" ).text = hotkey;
	if (hotkey != "")
	{
		$.GetContextPanel().SetHasClass("no_hotkey",false);
	}
	
	$( "#AbilityImage" ).abilityname = abilityName;
	$( "#AbilityImage" ).contextEntityIndex = m_Ability;
	
	$( "#ManaCost" ).text = manaCost;
	$( "#GoldCost" ).text = goldCost;
	
	if ( Abilities.IsCooldownReady( m_Ability ) )
	{
		$.GetContextPanel().SetHasClass( "cooldown_ready", true );
		$.GetContextPanel().SetHasClass( "in_cooldown", false );
	}
	else
	{
		$.GetContextPanel().SetHasClass( "cooldown_ready", false );
		$.GetContextPanel().SetHasClass( "in_cooldown", true );
		var cooldownLength = Abilities.GetCooldownLength( m_Ability );
		var cooldownRemaining = Abilities.GetCooldownTimeRemaining( m_Ability );
		var cooldownPercent = Math.ceil( 100 * cooldownRemaining / cooldownLength );
		$( "#CooldownTimer" ).text = Math.ceil( cooldownRemaining );
		$( "#CooldownOverlay" ).style.width = cooldownPercent+"%";
	}
	
}

function AbilityShowTooltip()
{
	var abilityButton = $( "#AbilityButton" );
	var abilityName = Abilities.GetAbilityName( m_Ability );
	if (Entities.IsEnemy(m_QueryUnit))
		// If you don't have an entity, you can still show a tooltip that doesn't account for the entity
		$.DispatchEvent( "DOTAShowAbilityTooltip", abilityButton, abilityName );
	else
		// If you have an entity index, this will let the tooltip show the correct level / upgrade information
		$.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", abilityButton, abilityName, m_QueryUnit );
}

function AbilityHideTooltip()
{
	var abilityButton = $( "#AbilityButton" );
	$.DispatchEvent( "DOTAHideAbilityTooltip", abilityButton );
}

function ActivateAbility()
{
	if ( m_bInLevelUp )
	{
		Abilities.AttemptToUpgrade( m_Ability );
		return;
	}
	Abilities.ExecuteAbility( m_Ability, m_QueryUnit, false );
}

function DoubleClickAbility()
{
	// Handle double-click like a normal click - ExecuteAbility will either double-tap (self cast) or normal toggle as appropriate
	ActivateAbility();
}

function RightClickAbility()
{
	if ( m_bInLevelUp )
		return;

	if ( Abilities.IsAutocast( m_Ability ) )
	{
		Game.PrepareUnitOrders( { OrderType: dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO, AbilityIndex: m_Ability } );
	}
}

function RebuildAbilityUI()
{
	var abilityLevelContainer = $( "#AbilityLevelContainer" );
	abilityLevelContainer.RemoveAndDeleteChildren();
	if (!Entities.IsEnemy(m_QueryUnit) && Entities.IsHero(m_QueryUnit))
	{
		var currentLevel = Abilities.GetLevel( m_Ability );
		for ( var lvl = 0; lvl < Abilities.GetLevel( m_Ability ); lvl++ )
		{
			var levelPanel = $.CreatePanel( "Panel", abilityLevelContainer, "" );
			levelPanel.AddClass( "LevelPanel" );
			levelPanel.SetHasClass( "active_level", ( lvl < currentLevel ) );
			levelPanel.SetHasClass( "next_level", ( lvl == currentLevel ) );
		}
	}
}

(function()
{
	$.GetContextPanel().SetAbility = SetAbility;
	GameEvents.Subscribe( "dota_ability_changed", RebuildAbilityUI ); // major rebuild
	AutoUpdateAbility(); // initial update of dynamic state
})();
