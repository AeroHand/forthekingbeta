var Ps_Crystal=-1;
var Ps_BaseIncome=-1;
var Ps_Income=-1;
var Ps_Score=-1;
var Ps_Worker=-1;
var Ps_Tech=-1;
var Ps_Food_count=-1;
var Ps_Food_max=-1;
var Ps_Ranking_level=-1;
var Ps_Ranking_appellation=-1;
var Ps_Ranking_score=-1;
var Ps_Ranking_rank=-1;
function PlayerRandkInfoShowTooltip()
{
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#PlayerRandkInfo"),Players.GetPlayerName(Players.GetLocalPlayer()),"<font color=\\'#ffffff\\'>"+$.Localize("#Level")+Ps_Ranking_level+"("+$.Localize("#ranking_level_appellation_"+Ps_Ranking_appellation)+")<br>"+$.Localize("#Ranking_score")+Ps_Ranking_score+"<br>"+$.Localize("#Ranking_rank")+Ps_Ranking_rank);
}
function PlayerRandkInfoHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#PlayerRandkInfo"));
}
function MapInfoShowTooltip()
{
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#MapInfo_button"),"#MapInfo","#MapInfo_Description");
}

function MapInfoHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#MapInfo_button"));
}
function CrystalShowTooltip()
{
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#Crystal"),"#Crystal","<font color=\\'#4294f8\\'>"+Ps_Crystal+"</font>");
}

function CrystalHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#Crystal"));
}
function IncomeShowTooltip()
{
	var Panel = $("#Income");
	Panel.SetDialogVariableInt( "baseincome", Ps_BaseIncome );
	Panel.SetDialogVariableInt( "extraincome", Ps_Income );
	var str = $.Localize("#Income_Description",Panel);
	str = str.replace(/'/g,"\\'");
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#Income"),"#Income",str);
}

function IncomeHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#Income"));
}
function ScoreShowTooltip()
{
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#Score"),"#Score","<font color=\\'#ff7eac\\'>"+Ps_Score+"</font>");
}

function ScoreHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#Score"));
}
function WorkerShowTooltip()
{
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#Worker"),"#Worker","<font color=\\'#1E90FF\\'>"+Ps_Worker+"</font>"+"|<font color=\\'#1E90FF\\'>"+Ps_Tech+"</font>");
}

function WorkerHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#Worker"));
}
function FoodShowTooltip()
{
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#Food"),"#Food","<font color=\\'#ac704f\\'>"+Ps_Food_count+"</font>"+"/<font color=\\'#ac704f\\'>"+Ps_Food_max+"</font>");
}

function FoodHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#Food"));
}
function UpdateData(tableName, keyName, table)
{
	if (keyName == ("Player_"+Players.GetLocalPlayer()))
	{
		var playerData = table;
		Ps_Gold = playerData.Gold;
		Ps_Crystal = playerData.Crystal;
		Ps_BaseIncome = playerData.BaseIncome;
		Ps_Income = playerData.Income;
		Ps_Score = playerData.Score;
		Ps_Worker = playerData.FarmerNum;
		Ps_Tech = playerData.CrystalTech;
		Ps_Food_count = playerData.CurFood;
		Ps_Food_max = playerData.FullFood;
		Ps_Ranking_level = playerData.RankingLevel;
		Ps_Ranking_appellation = playerData.RankingAppellation;
		Ps_Ranking_score = playerData.RankingScore;
		Ps_Ranking_rank = playerData.RankingRank;
		$("#Gold_count").text = Ps_Gold;
		$("#Crystal_count").text = Ps_Crystal;
		$("#Income_count").text = Ps_Income+Ps_BaseIncome;
		$("#Score_count").text = Ps_Score;
		$("#Worker_count").text = Ps_Worker;
		$("#Tech_count").text = Ps_Tech;
		$("#Food_count").text = Ps_Food_count;
		$("#Food_max").text = Ps_Food_max;
		$("#LevelNumber").text = Ps_Ranking_level;
		$("#RankingAppellation").text = $.Localize("#ranking_level_appellation_"+Ps_Ranking_appellation);
		$("#RankingScore").text = $.Localize("#Ranking_score")+Ps_Ranking_score;
		$("#Rank").text = $.Localize("#Ranking_rank")+Ps_Ranking_rank;
	}
}
function ChangeSelectedUnit(data)
{
	var queryunit = Players.GetLocalPlayerPortraitUnit();
	$.GetContextPanel().SetHasClass("is_not_commander", Entities.GetUnitName(queryunit) != "npc_dota_hero_legion_commander" && Entities.GetUnitName(queryunit) != "npc_dota_hero_furion"  && Entities.GetUnitName(queryunit) != "npc_dota_hero_kunkka");
}
(function()
{
	// var playerid = Players.GetLocalPlayer();
	// var steam_id = Game.GetPlayerInfo(playerid).player_steamid;
	// GameEvents.SendCustomGameEventToServer("get_rank_state", {steamid:steam_id});
	// $.AsyncWebRequest( 'http://121.40.172.247:8080/ftk/ranking/get?player_id='+steam_id+'&hehe='+Math.random(), 
	// {
	// 	type: 'GET',
	// 	complete: function(a)
	// 	{
	// 		var tt = a.responseText;
	// 		tt = tt.substr(0,tt.length-1);

	// 		$.Msg(tt);
	// 		var aa = JSON.parse(tt);
	// 		if (aa.err == 1300)
	// 		{
	// 		}
	// 		else
	// 		{
	// 			GameEvents.SendCustomGameEventToServer("get_rank_state", {steamid:steam_id,score:aa.score,rank:aa.rank,total:aa.total,per:aa.per,level:GetPlayerLevel(aa.rank,aa.per)});
	// 		}
	// 	}
	// });
	CustomNetTables.SubscribeNetTableListener("PlayerData", UpdateData);
	GameEvents.Subscribe( "dota_player_update_selected_unit", ChangeSelectedUnit );
	GameEvents.Subscribe( "dota_player_update_query_unit", ChangeSelectedUnit );
})();
