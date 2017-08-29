var PlayerPanels = [];

function OnClickRankboardButton()
{
	$.GetContextPanel().SetHasClass("show_rank_board", ! $.GetContextPanel().BHasClass("show_rank_board"));
	if ($.GetContextPanel().BHasClass("show_rank_board"))
	{
		$("#PlayersRank").SetFocus();
		RefreshRankboard();
	}
}
function RefreshRankboard()
{
	$.AsyncWebRequest( 'http://www.dota2rpg.com/game_wz1/wz_get_ladderpoints_top.php', 
	{
		type: 'GET',
		complete: function(a)
		{
			var tt = a.responseText;
			tt = tt.substr(0,tt.length-1);

			var aa = JSON.parse(tt);
			if (aa.err == 1300)
			{
			}
			else
			{
				var local_steam_id = Game.GetLocalPlayerInfo();
				$.Msg(local_steam_id);
				for (var i in aa)
				{
					if (aa[i].playerid)
					{
						var PlayerPanel = PlayerPanels[i-1];
						PlayerPanel.FindChildTraverse("Player_rank").text = i;
						PlayerPanel.FindChildTraverse("Player_image").steamid = aa[i].playerid;
						PlayerPanel.FindChildTraverse("Player_name").steamid = aa[i].playerid;
						PlayerPanel.FindChildTraverse("Player_score").text = aa[i].points;
						PlayerPanel.FindChildTraverse("Player_game_tms").text = aa[i].gametimes;
						PlayerPanel.FindChildTraverse("Player_win_rate").text = (aa[i].wintimes/aa[i].gametimes*100).toFixed(0) + "%";
					}
				}
			}
		}
	});
}
(function()
{
	for (var i = 0; i < 50; i++)
	{
		var PlayerPanel = $.CreatePanel("Panel", $("#PlayersRank"), "top_"+(i+1));
		PlayerPanel.BLoadLayoutSnippet("PlayerRank");
		PlayerPanels.push(PlayerPanel);
	}
	RefreshRankboard();
})();