"use strict";

var m_AbilityPanels = []; // created up to a high-water mark, but reused when selection changes
var X_number = [];
var Enter = false;
var last_time = 0;
var time = 30;
function X_active(player,number)
{
	if (Players.GetLocalPlayer() == player)
	{
		X_number[player] = X_number[player] || 0;
		var bool = $("#X"+number).BHasClass("choosed");
		if (bool)
		{
			X_number[player] -= 1;
			$("#X"+number).SetHasClass("choosed", ! bool);
			$("#ability_list").GetChild(number-1).SetHasClass("X_ability", ! bool);
		}
		else
		{
			if (X_number[player] < 3)
			{
				X_number[player] += 1;
				$("#X"+number).SetHasClass("choosed", ! bool);
				$("#ability_list").GetChild(number-1).SetHasClass("X_ability", ! bool);
			}
		}
	}
}
function Enter_active(player)
{
	if (! Players.IsValidPlayerID(player))
	{
		return;
	}
	if (Players.GetLocalPlayer() == player)
	{
		Enter = true;
		$.GetContextPanel().SetHasClass("HideReroll",true);
		GameEvents.SendCustomGameEventToServer("reroll", {
			Q:$("#X1").BHasClass("choosed"),
			W:$("#X2").BHasClass("choosed"),
			E:$("#X3").BHasClass("choosed"),
			D:$("#X4").BHasClass("choosed"),
			F:$("#X5").BHasClass("choosed"),
			G:$("#X6").BHasClass("choosed"),
			R:$("#X7").BHasClass("choosed"),
			X:$("#X8").BHasClass("choosed")
		});
		// $.Msg({
		// 	Q:$("#X1").BHasClass("choosed"),
		// 	W:$("#X2").BHasClass("choosed"),
		// 	E:$("#X3").BHasClass("choosed"),
		// 	D:$("#X4").BHasClass("choosed"),
		// 	F:$("#X5").BHasClass("choosed"),
		// 	G:$("#X6").BHasClass("choosed"),
		// 	R:$("#X7").BHasClass("choosed"),
		// 	X:$("#X8").BHasClass("choosed")
		// });
		$("#X1").SetHasClass("choosed", false);
		$("#X2").SetHasClass("choosed", false);
		$("#X3").SetHasClass("choosed", false);
		$("#X4").SetHasClass("choosed", false);
		$("#X5").SetHasClass("choosed", false);
		$("#X6").SetHasClass("choosed", false);
		$("#X7").SetHasClass("choosed", false);
		$("#X8").SetHasClass("choosed", false);
		for (var i =  $("#ability_list").GetChildCount()-1; i >= 0; i--)
		{
			$("#ability_list").GetChild(i).SetHasClass("X_ability", false);
		}
	}
}
function UpdateRerollTime()
{
	var now = Game.GetGameTime();
	time = 90 - (now - last_time);
	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME))
	{
		time = -1;
	}
	$("#EnterTime").text = Math.ceil(Math.abs(time));
	if (time >= 0)
	{
		$.Schedule(1/30,UpdateRerollTime);
	}
	else
	{
		for (var i = 0; i < Players.GetMaxPlayers(); i++)
		{
			Enter_active(i);
		}
	}
}
function UpdateAbilityList()
{
	var abilityListPanel = $( "#ability_list" );
	if ( !abilityListPanel )
		return;

	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME))
	{
		$.GetContextPanel().style.opacity = "1";
		// return;
	}

	var queryUnit = Players.GetLocalPlayerPortraitUnit();
	if (Entities.GetUnitName(queryUnit)!="npc_dummy_build_base")
	{
		$.GetContextPanel().style.opacity = "0";
		// return;
	}
	else
	{
		$.GetContextPanel().style.opacity = "1";
	}

	$.GetContextPanel().SetHasClass("HideReroll",Enter || ! Entities.IsControllableByPlayer(queryUnit,Players.GetLocalPlayer()) || time < 0);
	// see if we can level up
	var nRemainingPoints = Entities.GetAbilityPoints( queryUnit );
	var bPointsToSpend = ( nRemainingPoints > 0 );
	var bControlsUnit = Entities.IsControllableByPlayer( queryUnit, Game.GetLocalPlayerID() );
	$.GetContextPanel().SetHasClass( "could_level_up", ( bControlsUnit && bPointsToSpend ) );

	// update all the panels
	var nUsedPanels = 0;
	for ( var i = 0; i < Entities.GetAbilityCount( queryUnit ); ++i )
	{
		var ability = Entities.GetAbility( queryUnit, i );
		if ( ability == -1 )
			continue;

		if ( !Abilities.IsDisplayedAbility(ability) )
			continue;
		
		if ( nUsedPanels >= m_AbilityPanels.length )
		{
			// create a new panel
			var abilityPanel = $.CreatePanel( "Panel", abilityListPanel, "" );
			abilityPanel.BLoadLayout( "file://{resources}/layout/custom_game/action_bar_ability.xml", false, false );
			m_AbilityPanels.push( abilityPanel );
		}

		// update the panel for the current unit / ability
		var abilityPanel = m_AbilityPanels[ nUsedPanels ];
		abilityPanel.SetAbility( ability, queryUnit, Game.IsInAbilityLearnMode() );
		
		nUsedPanels++;
	}

	// clear any remaining panels
	for ( var i = nUsedPanels; i < m_AbilityPanels.length; ++i )
	{
		var abilityPanel = m_AbilityPanels[ i ];
		abilityPanel.SetAbility( -1, -1, false );
	}
}

(function()
{
	last_time = Game.GetGameTime();
	$.GetContextPanel().visible = false;

	GameEvents.Subscribe( "dota_portrait_ability_layout_changed", UpdateAbilityList );
	GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateAbilityList );
	GameEvents.Subscribe( "dota_player_update_query_unit", UpdateAbilityList );
	GameEvents.Subscribe( "dota_ability_changed", UpdateAbilityList );
	GameEvents.Subscribe( "dota_hero_ability_points_changed", UpdateAbilityList );
	
	UpdateAbilityList(); // initial update
	UpdateRerollTime();
})();

