function GetStarImage(count,mvp)
{
	if (mvp >= 0 && mvp < 5*count)
		return "file://{images}/custom_game/EndScreen/Star0.psd";
	if (mvp >= 5*count && mvp < 10*count)
		return "file://{images}/custom_game/EndScreen/Star1.psd";
	if (mvp >= 10*count && mvp < 15*count)
		return "file://{images}/custom_game/EndScreen/Star2.psd";
	if (mvp >= 15*count && mvp < 20*count)
		return "file://{images}/custom_game/EndScreen/Star3.psd";
	if (mvp >= 20*count && mvp < 25*count)
		return "file://{images}/custom_game/EndScreen/Star4.psd";
	if (mvp >= 25*count)
		return "file://{images}/custom_game/EndScreen/Star5.psd";
}
function EndGame(data)
{
	$.GetContextPanel().SetHasClass("show", true);
	$.Schedule(0.5,function(){$.GetContextPanel().SetHasClass("endgame", true);})
	var winningTeamId = Game.GetGameWinner();
	var winningTeamDetails = Game.GetTeamDetails( winningTeamId );
	var endScreenVictory = $( "#EndScreenVictory" );
	if ( endScreenVictory )
	{
		endScreenVictory.SetDialogVariable( "winning_team_name", $.Localize( winningTeamDetails.team_name ) );

		if ( GameUI.CustomUIConfig().team_colors )
		{
			var teamColor = GameUI.CustomUIConfig().team_colors[ winningTeamId ];
			teamColor = teamColor.replace( ";", "" );
			endScreenVictory.style.color = teamColor + ";";
		}
	}
	var winningTeamLogo = $( "#WinningTeamLogo" );
	if ( winningTeamLogo )
	{
		var logo_xml = GameUI.CustomUIConfig().team_logo_large_xml;
		if ( logo_xml )
		{
			winningTeamLogo.SetAttributeInt( "team_id", winningTeamId );
			winningTeamLogo.BLoadLayout( logo_xml, false, false );
		}
	}
	var count = data.playercount;
	for (var i = 1; i <= count; i++)
	{
		var Panel;
		var damagetoking_team;
		if (data.team[i] == DOTATeam_t.DOTA_TEAM_GOODGUYS)
		{
			Panel = $("#Team1");
			damagetoking_team = data.damagetoking1;
		}
		else
		{
			Panel = $("#Team2");
			damagetoking_team = data.damagetoking2;
		}
		if (Panel.GetChildCount()<=4)
		{
			var CPanel = $.CreatePanel( "Panel", Panel, "" );
			CPanel.BLoadLayout( "file://{resources}/layout/custom_game/end_screen_player.xml", false, false );
			CPanel.SetHasClass("badguys", (data.playerposition[i] > 4));
			CPanel.GetChild(1).GetChild(0).steamid = data.steamid[i];
			CPanel.GetChild(1).GetChild(1).GetChild(0).text = Players.GetPlayerName(data.playerid[i]);
			CPanel.GetChild(1).GetChild(1).GetChild(1).text = $.Localize("#Level")+data.rankinglevel[i]+" "+$.Localize("#ranking_level_appellation_"+data.rankingappellation[i]);
			if (damagetoking_team == 0)
			{
				CPanel.GetChild(2).text = "0%";
			}
			else
			{
				CPanel.GetChild(2).text = Math.round((data.damagetoking[i]/damagetoking_team)*100)+"%";
			}
			CPanel.GetChild(3).text = data.breakgold[i];
			CPanel.GetChild(4).text = data.killcount[i];
			CPanel.GetChild(5).text = data.score[i];
			CPanel.GetChild(6).text = data.gold[i];
			CPanel.GetChild(7).text = data.lumber[i];
			CPanel.GetChild(8).text = data.income[i];
			CPanel.GetChild(9).text = data.armaments[i];
			CPanel.GetChild(10).SetImage(GetStarImage(count,data.mvp[i]));
			if (data.mvpplayerposition == data.playerposition[i])
			{
				CPanel.GetChild(0).SetImage("file://{images}/custom_game/EndScreen/MVP.psd");
			}
			if (data.rank_mode)
			{
				$.GetContextPanel().SetHasClass("rank_mode", true);
				var rank_sign = "+";
				CPanel.GetChild(11).style.color = "#00ff00";
				if (data.rankingaddscore[i] < 0)
				{
					rank_sign = "-";
					CPanel.GetChild(11).style.color = "#ff0000";
				}
				if (Players.GetLocalPlayer() == data.playerid[i] || Players.IsSpectator(Players.GetLocalPlayer()))
				{
					CPanel.GetChild(11).text = data.rankingscore[i]+"("+rank_sign+Math.abs(data.rankingaddscore[i])+")";
				}
				else
				{
					CPanel.GetChild(11).text = rank_sign+Math.abs(data.rankingaddscore[i]);
				}
			}
		}
	}
}
(function()
{
	GameEvents.Subscribe("end_screen_player_states", EndGame);
})();
