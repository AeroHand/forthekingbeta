var m_LeftKing = -1;
var m_RightKing = -1;
var m_LeftLife = 0;
var m_RightLife = 0;

var m_PlayerCount = 0;
var m_PlayerScore = [];
var m_PlayerADLevel = [];
var m_PlayerHLevel = [];
var m_PlayerHRLevel = [];
var m_ShowToEnemy = false;

var teamscore1 = "";
var teamscore2 = "";
var bosslevel1 = 0;
var bosslevel2 = 0;
var playerlevel1 = "";
var playerlevel2 = "";
function UpdateTeamScore()
{
	teamscore1 = "";
	var score = 0;
	
	var playerIDs = Game.GetAllPlayerIDs();
	for (var i = 0; i < playerIDs.length; i++)
	{
		var playerID = playerIDs[i];
		if (m_PlayerScore[playerID] != undefined)
		{
			if (Players.GetTeam(playerID) == DOTATeam_t.DOTA_TEAM_GOODGUYS)
			{
				score += m_PlayerScore[playerID];
				if (teamscore1 != "") teamscore1 = teamscore1 + "<br>";

				var wrong_color = Players.GetPlayerColor(playerID).toString(16);
				var playerColor = "#"+wrong_color.substring(6,8)+wrong_color.substring(4,6)+wrong_color.substring(2,4)+wrong_color.substring(0,2);
				teamscore1 = teamscore1 + "<font color='"+playerColor+"'>"+Players.GetPlayerName(playerID)+"</font>:";
				teamscore1 = teamscore1 + m_PlayerScore[playerID];
			}
		}
	}
	if (teamscore1 != "") teamscore1 = "<br>" + teamscore1;
	teamscore1 = $.Localize("#AllScore")+":"+score+teamscore1;
	teamscore1 = teamscore1.replace(/'/g,"\\'");
	//------------------------------------------
	teamscore2 = "";
	var score = 0;

	var playerIDs = Game.GetAllPlayerIDs();
	for (var i = 0; i < playerIDs.length; i++)
	{
		var playerID = playerIDs[i];
		if (m_PlayerScore[playerID] != undefined)
		{
			if (Players.GetTeam(playerID) == DOTATeam_t.DOTA_TEAM_BADGUYS)
			{
				score += m_PlayerScore[playerID];
				if (teamscore2 != "") teamscore2 = teamscore2 + "<br>";

				var wrong_color = Players.GetPlayerColor(playerID).toString(16);
				var playerColor = "#"+wrong_color.substring(6,8)+wrong_color.substring(4,6)+wrong_color.substring(2,4)+wrong_color.substring(0,2);
				teamscore2 = teamscore2 + "<font color='"+playerColor+"'>"+Players.GetPlayerName(playerID)+"</font>:";
				teamscore2 = teamscore2 + m_PlayerScore[playerID];
			}
		}
	}
	if (teamscore2 != "") teamscore2 = "<br>" + teamscore2;
	teamscore2 = $.Localize("#AllScore")+":"+score+teamscore2;
	teamscore2 = teamscore2.replace(/'/g,"\\'");
}
function UpdateBossLevel()
{
	bosslevel1 = 0;
	playerlevel1 = "";

	var bossadlevel = 0, bosshlevel = 0, bosshrlevel = 0;
	
	var playerIDs = Game.GetAllPlayerIDs();
	for (var i = 0; i < playerIDs.length; i++)
	{
		var playerID = playerIDs[i];
		if (Players.GetTeam(playerID) == DOTATeam_t.DOTA_TEAM_GOODGUYS)
		{
			bosslevel1 += m_PlayerADLevel[playerID];
			bossadlevel += m_PlayerADLevel[playerID];
			bosslevel1 += m_PlayerHLevel[playerID];
			bosshlevel += m_PlayerHLevel[playerID];
			bosslevel1 += m_PlayerHRLevel[playerID];
			bosshrlevel += m_PlayerHRLevel[playerID];
		}
	}
	playerlevel1 = playerlevel1 + $.Localize("#BossLevelup_AttackDamage")+"(<font color='white'>Lv."+bossadlevel+"</font>);";
	playerlevel1 = playerlevel1 + $.Localize("#BossLevelup_Health")+"(<font color='white'>Lv."+bosshlevel+"</font>);";
	playerlevel1 = playerlevel1 + $.Localize("#BossLevelup_HealthRegen")+"(<font color='white'>Lv."+bosshrlevel+"</font>)";	

	if (Players.GetTeam(Players.GetLocalPlayer()) == DOTATeam_t.DOTA_TEAM_GOODGUYS)
	{
		var playerIDs = Game.GetAllPlayerIDs();
		for (var i = 0; i < playerIDs.length; i++)
		{
			var playerID = playerIDs[i];
			if (Players.GetTeam(playerID) == DOTATeam_t.DOTA_TEAM_GOODGUYS)
			{
				if (playerlevel1 != "") playerlevel1 = playerlevel1 + "<br>";
				var wrong_color = Players.GetPlayerColor(playerID).toString(16);
				var playerColor = "#"+wrong_color.substring(6,8)+wrong_color.substring(4,6)+wrong_color.substring(2,4)+wrong_color.substring(0,2);

				playerlevel1 = playerlevel1 + "<font color='"+playerColor+"'>"+Players.GetPlayerName(playerID)+"</font>:";
				playerlevel1 = playerlevel1 + $.Localize("#BossLevelup_AttackDamage")+"(<font color='white'>"+m_PlayerADLevel[playerID]+"/"+bossadlevel+"</font>);";
				playerlevel1 = playerlevel1 + $.Localize("#BossLevelup_Health")+"(<font color='white'>"+m_PlayerHLevel[playerID]+"/"+bosshlevel+"</font>);";
				playerlevel1 = playerlevel1 + $.Localize("#BossLevelup_HealthRegen")+"(<font color='white'>"+m_PlayerHRLevel[playerID]+"/"+bosshrlevel+"</font>)";
			}
		}
	}
	playerlevel1 = playerlevel1.replace(/'/g,"\\'");
	//------------------------------------------
	bosslevel2 = 0;
	playerlevel2 = "";

	var bossadlevel = 0, bosshlevel = 0, bosshrlevel = 0;
	
	var playerIDs = Game.GetAllPlayerIDs();
	for (var i = 0; i < playerIDs.length; i++)
	{
		var playerID = playerIDs[i];
		if (Players.GetTeam(playerID) == DOTATeam_t.DOTA_TEAM_BADGUYS)
		{
			bosslevel2 += m_PlayerADLevel[playerID];
			bossadlevel += m_PlayerADLevel[playerID];
			bosslevel2 += m_PlayerHLevel[playerID];
			bosshlevel += m_PlayerHLevel[playerID];
			bosslevel2 += m_PlayerHRLevel[playerID];
			bosshrlevel += m_PlayerHRLevel[playerID];
		}
	}
	playerlevel2 = playerlevel2 + $.Localize("#BossLevelup_AttackDamage")+"(<font color='white'>Lv."+bossadlevel+"</font>);";
	playerlevel2 = playerlevel2 + $.Localize("#BossLevelup_Health")+"(<font color='white'>Lv."+bosshlevel+"</font>);";
	playerlevel2 = playerlevel2 + $.Localize("#BossLevelup_HealthRegen")+"(<font color='white'>Lv."+bosshrlevel+"</font>)";	

	if (Players.GetTeam(Players.GetLocalPlayer()) == DOTATeam_t.DOTA_TEAM_BADGUYS)
	{
		var playerIDs = Game.GetAllPlayerIDs();
		for (var i = 0; i < playerIDs.length; i++)
		{
			var playerID = playerIDs[i];
			if (Players.GetTeam(playerID) == DOTATeam_t.DOTA_TEAM_BADGUYS)
			{
				if (playerlevel2 != "") playerlevel2 = playerlevel2 + "<br>";
				var wrong_color = Players.GetPlayerColor(playerID).toString(16);
				var playerColor = "#"+wrong_color.substring(6,8)+wrong_color.substring(4,6)+wrong_color.substring(2,4)+wrong_color.substring(0,2);

				playerlevel2 = playerlevel2 + "<font color='"+playerColor+"'>"+Players.GetPlayerName(playerID)+"</font>:";
				playerlevel2 = playerlevel2 + $.Localize("#BossLevelup_AttackDamage")+"(<font color='white'>"+m_PlayerADLevel[playerID]+"/"+bossadlevel+"</font>);";
				playerlevel2 = playerlevel2 + $.Localize("#BossLevelup_Health")+"(<font color='white'>"+m_PlayerHLevel[playerID]+"/"+bosshlevel+"</font>);";
				playerlevel2 = playerlevel2 + $.Localize("#BossLevelup_HealthRegen")+"(<font color='white'>"+m_PlayerHRLevel[playerID]+"/"+bosshrlevel+"</font>)";
			}
		}
	}
	playerlevel2 = playerlevel2.replace(/'/g,"\\'");
}

function UpdataBossHealth()
{
	$.Schedule(0, UpdataBossHealth);

	var healthpercent = ((Entities.GetHealth(m_LeftKing)/Entities.GetMaxHealth(m_LeftKing))*98.034);
	$("#BossHealth1").style.width = healthpercent+"%";
	var healthpercent = ((Entities.GetHealth(m_RightKing)/Entities.GetMaxHealth(m_RightKing))*98.034);
	$("#BossHealth2").style.width = healthpercent+"%";
}

function Update()
{
	UpdateTeamScore();
	UpdateBossLevel();

	$("#LifeCount1").text = m_LeftLife;
	$("#LifeCount2").text = m_RightLife;
	$("#LevelNumber1").text = bosslevel1;
	$("#LevelNumber2").text = bosslevel2;
	$("#TeamName1").text = $.Localize("#Team1Name");
	$("#TeamName2").text = $.Localize("#Team2Name");
	$("#TeamScore1").text = "("+GetTeamAllScore(DOTATeam_t.DOTA_TEAM_GOODGUYS)+")";
	$("#TeamScore2").text = "("+GetTeamAllScore(DOTATeam_t.DOTA_TEAM_BADGUYS)+")";
	$("#TeamScore1").visible = (Players.GetTeam(Players.GetLocalPlayer()) == DOTATeam_t.DOTA_TEAM_GOODGUYS || m_ShowToEnemy);
	$("#TeamScore2").visible = (Players.GetTeam(Players.GetLocalPlayer()) == DOTATeam_t.DOTA_TEAM_BADGUYS || m_ShowToEnemy);
}

function TeamAllScore1ShowTooltip()
{
	if (Players.GetTeam(Players.GetLocalPlayer()) || m_ShowToEnemy) $.DispatchEvent("DOTAShowTextTooltip", $("#TeamAllScore1"), teamscore1);
	else $.DispatchEvent("DOTAShowTextTooltip", $("#TeamAllScore1"), $.Localize("#ShowToEnemy"));
}
function TeamAllScore1HideTooltip()
{
	$.DispatchEvent("DOTAHideTextTooltip", $("#TeamAllScore1"));
}

function TeamAllScore2ShowTooltip()
{
	if (Players.GetTeam(Players.GetLocalPlayer()) || m_ShowToEnemy) $.DispatchEvent( "DOTAShowTextTooltip", $("#TeamAllScore2"), teamscore2);
	else $.DispatchEvent("DOTAShowTextTooltip", $("#TeamAllScore2"), $.Localize("#ShowToEnemy"));
}
function TeamAllScore2HideTooltip()
{
	$.DispatchEvent("DOTAHideTextTooltip", $("#TeamAllScore2"));
}

function BossLevel1ShowTooltip()
{
	var s = $.Localize("#BossLevel")+":<font color='#fbf365'>Lv."+bosslevel1+"</font>";
	s = s.replace(/'/g,"\\'");
	$.DispatchEvent("DOTAShowTitleTextTooltip", $("#BossLevel1"), s, playerlevel1);
}
function BossLevel1HideTooltip()
{
	$.DispatchEvent("DOTAHideTitleTextTooltip", $("#BossLevel1"));
}

function BossLevel2ShowTooltip()
{
	var s = $.Localize("#BossLevel")+":<font color='#c6f0f5'>Lv."+bosslevel2+"</font>";
	s = s.replace(/'/g,"\\'");
	$.DispatchEvent("DOTAShowTitleTextTooltip", $("#BossLevel2"), s, playerlevel2);
}
function BossLevel2HideTooltip()
{
	$.DispatchEvent("DOTAHideTitleTextTooltip", $("#BossLevel2"));
}

function GetTeamAllScore(team)
{
	var score = 0;
	var playerIDs = Game.GetAllPlayerIDs();
	for (var i = 0; i < playerIDs.length; i++)
	{
		var playerID = playerIDs[i];
		if (Players.GetTeam(playerID) == team) score+=m_PlayerScore[playerID];
	}
	return score;
}
function UpdataGame(tableName, keyName, table)
{
	if (keyName == "info")
	{
		m_LeftKing = table.leftKing;
		m_LeftLife = table.leftLife;

		m_RightKing = table.rightKing;
		m_RightLife = table.rightLife;

		m_ShowToEnemy = table.round >= 8;
	
		m_PlayerCount = table.leftPlayerCount + table.rightPlayerCount;

		Update();
		UpdataBossHealth();
	}
}
function UpdatePlayerData(tableName, keyName, table)
{
	var playerIDs = Game.GetAllPlayerIDs();
	for (var i = 0; i < playerIDs.length; i++)
	{
		var playerID = playerIDs[i];
		var playerData = CustomNetTables.GetTableValue("PlayerData", "Player_"+playerID);

		m_PlayerScore[playerID] = playerData.Score;
		m_PlayerADLevel[playerID] = playerData.ADLevel;
		m_PlayerHLevel[playerID] = playerData.HLevel;
		m_PlayerHRLevel[playerID] = playerData.HRLevel;
	}
	Update();
}
(function()
{
	$.GetContextPanel().SetHasClass("Russian", ($.Language()=="russian"));

	UpdataGame("Game", "info", CustomNetTables.GetTableValue("Game", "info"));
	UpdatePlayerData();

	CustomNetTables.SubscribeNetTableListener("Game", UpdataGame);
	CustomNetTables.SubscribeNetTableListener("PlayerData", UpdatePlayerData);
})();
