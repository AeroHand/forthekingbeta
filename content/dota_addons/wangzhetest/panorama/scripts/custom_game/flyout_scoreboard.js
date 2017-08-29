var bool = [];
var playerid = [];
var player_income = [];
var player_worker_count = [];
var player_tech = [];
var player_score = [];
var player_armaments = [];
var player_ranking_level = [];
var player_ranking_appellation = [];
var showtoother = false;

function UpdatePlayer()
{
	for (var i = 1; i <= 8; i++)
	{
		$("#player"+i+"_avatarimageandname").GetChild(0).steamid = 0;
		$("#player"+i+"_avatarimageandname").GetChild(1).GetChild(0).text = "";
		$("#player"+i+"_avatarimageandname").GetChild(1).GetChild(1).text = "";
		$("#player"+i+"_income").text = "";
		$("#player"+i+"_worker_count").text = "";
		$("#player"+i+"_worker_virgule").text = "";
		$("#player"+i+"_tech").text = "";
		$("#player"+i+"_score").text = "";
		$("#player"+i+"_armaments").text = "";
		if (bool[i])
		{
			$("#player"+i+"_avatarimageandname").GetChild(0).steamid = Game.GetPlayerInfo(playerid[i]).player_steamid;
			$("#player"+i+"_avatarimageandname").GetChild(1).GetChild(0).text = Players.GetPlayerName(playerid[i]);
			$("#player"+i+"_avatarimageandname").GetChild(1).GetChild(1).text = $.Localize("#Level")+player_ranking_level[i]+" "+$.Localize("#ranking_level_appellation_"+player_ranking_appellation[i]);
			var boolb = Players.GetLocalPlayer()==playerid[1] || Players.GetLocalPlayer()==playerid[2] || Players.GetLocalPlayer()==playerid[3] || Players.GetLocalPlayer()==playerid[4];
			if (i>4)
			{
				boolb = Players.GetLocalPlayer()==playerid[5] || Players.GetLocalPlayer()==playerid[6] || Players.GetLocalPlayer()==playerid[7] || Players.GetLocalPlayer()==playerid[8];
			}
			if (boolb || Players.IsSpectator(Players.GetLocalPlayer()) || showtoother)
			{
				$("#player"+i+"_income").text = player_income[i];
				$("#player"+i+"_worker_count").text = player_worker_count[i];
				$("#player"+i+"_worker_virgule").text = "|";
				$("#player"+i+"_tech").text = player_tech[i];
				$("#player"+i+"_score").text = player_score[i];
				$("#player"+i+"_armaments").text = player_armaments[i];
			}
		}
	}
}
function UpdateFlyoutScoreboard()
{
	UpdatePlayer();
	$.Schedule(0.1,UpdateFlyoutScoreboard);
}
function FlyoutScoreboardButtonShowTooltip()
{
	$.DispatchEvent( "DOTAShowTextTooltip",$("#FlyoutScoreboardPanel"),"#FlyoutScoreboardKey");
}

function FlyoutScoreboardButtonHideTooltip()
{
	$.DispatchEvent( "DOTAHideTextTooltip",$("#FlyoutScoreboardPanel"));
}
function OnFlyoutScoreboardButtonPressed()
{
	$.GetContextPanel().SetHasClass("flyout_scoreboard_visible", true);
}
function OnFlyoutScoreboardButtonReleased()
{
	$.GetContextPanel().SetHasClass("flyout_scoreboard_visible", false);
}
function OnClickFlyoutScoreboardButton()
{
	if ($.GetContextPanel().BHasClass("flyout_scoreboard_visible")) OnFlyoutScoreboardButtonReleased();
	else OnFlyoutScoreboardButtonPressed();
}
function GetStatesByLua(data)
{
	playerid[data.position]=data.playerid;
	player_income[data.position]=data.income;
	player_score[data.position]=data.score;
	player_worker_count[data.position]=data.woker;
	player_tech[data.position]=data.tech;
	player_armaments[data.position]=data.armaments;
	player_ranking_level[data.position]=data.ranking_level;
	player_ranking_appellation[data.position]=data.ranking_appellation;
	bool[data.position]=true;
	showtoother=data.showtoother;
}
(function()
{
	bool[1]=false;
	bool[2]=false;
	bool[3]=false;
	bool[4]=false;
	bool[5]=false;
	bool[6]=false;
	bool[7]=false;
	bool[8]=false;
	UpdateFlyoutScoreboard();

	$.GetContextPanel().SetHasClass("Russian", ($.Language()=="russian"));
	GameEvents.Subscribe("updateflyoutscoreboard", GetStatesByLua);
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_PROTECT, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_QUICKBUY, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_COURIER, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_SHOP_SUGGESTEDITEMS, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, true );

})();
Game.AddCommand( "+FlyoutScoreboard", OnFlyoutScoreboardButtonPressed, "", 0 );
Game.AddCommand( "-FlyoutScoreboard", OnFlyoutScoreboardButtonReleased, "", 0 );