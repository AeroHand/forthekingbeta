var m_HasPlayer = [];
var m_PlayerID = [];
var m_PlayerIncome = [];
var m_PlayerFamerNum = [];
var m_PlayerCrystalTech = [];
var m_PlayerScore = [];
var m_PlayerArmsValue = [];
var m_PlayerRankingLevel = [];
var m_PlayerRankingAppellation = [];
var m_ShowToEnemy = false;

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
		if (m_HasPlayer[i])
		{
			$("#player"+i+"_avatarimageandname").GetChild(0).steamid = Game.GetPlayerInfo(m_PlayerID[i]).player_steamid;
			$("#player"+i+"_avatarimageandname").GetChild(1).GetChild(0).text = Players.GetPlayerName(m_PlayerID[i]);
			$("#player"+i+"_avatarimageandname").GetChild(1).GetChild(1).text = $.Localize("#Level")+m_PlayerRankingLevel[i]+" "+$.Localize("#ranking_level_appellation_"+m_PlayerRankingAppellation[i]);
			var m_HasPlayerb = Players.GetLocalPlayer()==m_PlayerID[1] || Players.GetLocalPlayer()==m_PlayerID[2] || Players.GetLocalPlayer()==m_PlayerID[3] || Players.GetLocalPlayer()==m_PlayerID[4];
			if (i>4)
			{
				m_HasPlayerb = Players.GetLocalPlayer()==m_PlayerID[5] || Players.GetLocalPlayer()==m_PlayerID[6] || Players.GetLocalPlayer()==m_PlayerID[7] || Players.GetLocalPlayer()==m_PlayerID[8];
			}
			if (m_HasPlayerb || Players.IsSpectator(Players.GetLocalPlayer()) || m_ShowToEnemy)
			{
				$("#player"+i+"_income").text = m_PlayerIncome[i];
				$("#player"+i+"_worker_count").text = m_PlayerFamerNum[i];
				$("#player"+i+"_worker_virgule").text = "|";
				$("#player"+i+"_tech").text = m_PlayerCrystalTech[i];
				$("#player"+i+"_score").text = m_PlayerScore[i];
				$("#player"+i+"_armaments").text = m_PlayerArmsValue[i];
			}
		}
	}
}
function UpdateFlyoutScoreboard()
{
	UpdatePlayer();
	$.Schedule(1/30, UpdateFlyoutScoreboard);
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
function UpdateData(tableName, keyName, table)
{
	var playerIDs = Game.GetAllPlayerIDs();
	for (var i = 0; i < playerIDs.length; i++)
	{
		var playerID = playerIDs[i];
		var playerData = CustomNetTables.GetTableValue("PlayerData", "Player_"+playerID);
		var playerPosition = playerData.PlayerPosition;

		m_HasPlayer[playerPosition] = true;

		m_PlayerID[playerPosition] = playerID;
		m_PlayerIncome[playerPosition] = playerData.BaseIncome+playerData.Income;
		m_PlayerFamerNum[playerPosition] = playerData.FarmerNum;
		m_PlayerCrystalTech[playerPosition] = playerData.CrystalTech;
		m_PlayerScore[playerPosition] = playerData.Score;
		m_PlayerArmsValue[playerPosition] = playerData.ArmsValue;
		m_PlayerRankingLevel[playerPosition] = playerData.RankingLevel;
		m_PlayerRankingAppellation[playerPosition] = playerData.RankingAppellation;
	}
	UpdatePlayer();
}
function UpdateRound(tableName, keyName, table)
{
	if (keyName == "info")
	{
		m_ShowToEnemy = table.round >= 8;
	}
}
(function()
{
	m_HasPlayer[1]=false;
	m_HasPlayer[2]=false;
	m_HasPlayer[3]=false;
	m_HasPlayer[4]=false;
	m_HasPlayer[5]=false;
	m_HasPlayer[6]=false;
	m_HasPlayer[7]=false;
	m_HasPlayer[8]=false;

	$.GetContextPanel().SetHasClass("Russian", ($.Language()=="russian"));


	UpdateRound("Game", "info", CustomNetTables.GetTableValue("Game", "info"));
	UpdateData();

	CustomNetTables.SubscribeNetTableListener("Game", UpdateRound);
	CustomNetTables.SubscribeNetTableListener("PlayerData", UpdateData);

	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_PROTECT, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_QUICKBUY, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_COURIER, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_SHOP_SUGGESTEDITEMS, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false );
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, true );

	UpdateFlyoutScoreboard();

	Game.AddCommand( "+FlyoutScoreboard", OnFlyoutScoreboardButtonPressed, "", 0 );
	Game.AddCommand( "-FlyoutScoreboard", OnFlyoutScoreboardButtonReleased, "", 0 );
})();