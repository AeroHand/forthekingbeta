var bool=false;
var boss1;
var boss2;
var lifecount1=0;
var lifecount2=0;
var playerid=[];
var playercount=0;
var playerscore=[];
var playeradlevel=[];
var playerhlevel=[];
var playerhrlevel=[];
var playerteam=[];
var showtoenemy=false;
var teamscore1="";
var teamscore2="";
var bosslevel1=0;
var bosslevel2=0;
var playerlevel1="";
var playerlevel2="";
function UpdateTeamScore1()
{
	teamscore1="";
	var score=0;
	for (var i = 1;i<=playercount;i++)
	{
		if (playerteam[playerid[i]] == DOTATeam_t.DOTA_TEAM_GOODGUYS)
		{
			score+=playerscore[playerid[i]];
			if (teamscore1!="")
				teamscore1=teamscore1+"<br>";
			teamscore1=teamscore1+"<font color='#"+(4294967295-Players.GetPlayerColor(playerid[i])).toString(16)+"'>"+Players.GetPlayerName(playerid[i])+"</font>:";
			teamscore1=teamscore1+playerscore[playerid[i]];
		}
	}
	if (teamscore1!="")
		teamscore1="<br>"+teamscore1;
	teamscore1=$.Localize("#AllScore")+":"+score+teamscore1;
	teamscore1 = teamscore1.replace(/'/g,"\\'");
}
function UpdateTeamScore2()
{
	teamscore2="";
	var score=0;
	for (var i = 1;i<=playercount;i++)
	{
		if (playerteam[playerid[i]] == DOTATeam_t.DOTA_TEAM_BADGUYS)
		{
			score+=playerscore[playerid[i]];
			if (teamscore2!="")
				teamscore2=teamscore2+"<br>";
			teamscore2=teamscore2+"<font color='#"+(4294967295-Players.GetPlayerColor(playerid[i])).toString(16)+"'>"+Players.GetPlayerName(playerid[i])+"</font>:";
			teamscore2=teamscore2+playerscore[playerid[i]];
		}
	}
	if (teamscore2!="")
		teamscore2="<br>"+teamscore2;
	teamscore2=$.Localize("#AllScore")+":"+score+teamscore2;
	teamscore2 = teamscore2.replace(/'/g,"\\'");
}
function UpdateBossLevel1()
{
	bosslevel1=0;
	playerlevel1="";
	var bossadlevel=0,bosshlevel=0,bosshrlevel=0;
	for (var i = 1;i<=playercount;i++)
	{
		if (playerteam[playerid[i]] == DOTATeam_t.DOTA_TEAM_GOODGUYS)
		{
			bosslevel1+=playeradlevel[playerid[i]];
			bossadlevel+=playeradlevel[playerid[i]];
			bosslevel1+=playerhlevel[playerid[i]];
			bosshlevel+=playerhlevel[playerid[i]];
			bosslevel1+=playerhrlevel[playerid[i]];
			bosshrlevel+=playerhrlevel[playerid[i]];
		}
	}
	playerlevel1=playerlevel1+$.Localize("#BossLevelup_AttackDamage")+"(<font color='white'>Lv."+bossadlevel+"</font>);";
	playerlevel1=playerlevel1+$.Localize("#BossLevelup_Health")+"(<font color='white'>Lv."+bosshlevel+"</font>);";
	playerlevel1=playerlevel1+$.Localize("#BossLevelup_HealthRegen")+"(<font color='white'>Lv."+bosshrlevel+"</font>)";	
	if (playerteam[Players.GetLocalPlayer()]==DOTATeam_t.DOTA_TEAM_GOODGUYS)
		for (var i = 1;i<=playercount;i++)
		{
			if (playerteam[playerid[i]] == DOTATeam_t.DOTA_TEAM_GOODGUYS)
			{
				if (playerlevel1!="")
					playerlevel1=playerlevel1+"<br>";
				playerlevel1=playerlevel1+Players.GetPlayerName(playerid[i])+":";
				playerlevel1=playerlevel1+$.Localize("#BossLevelup_AttackDamage")+"(<font color='white'>"+playeradlevel[playerid[i]]+"/"+bossadlevel+"</font>);";
				playerlevel1=playerlevel1+$.Localize("#BossLevelup_Health")+"(<font color='white'>"+playerhlevel[playerid[i]]+"/"+bosshlevel+"</font>);";
				playerlevel1=playerlevel1+$.Localize("#BossLevelup_HealthRegen")+"(<font color='white'>"+playerhrlevel[playerid[i]]+"/"+bosshrlevel+"</font>)";
			}
		};
	playerlevel1 = playerlevel1.replace(/'/g,"\\'");
}
function UpdateBossLevel2()
{
	bosslevel2=0;
	playerlevel2="";
	var bossadlevel=0,bosshlevel=0,bosshrlevel=0;
	for (var i = 1;i<=playercount;i++)
	{
		if (playerteam[playerid[i]] == DOTATeam_t.DOTA_TEAM_BADGUYS)
		{
			bosslevel2+=playeradlevel[playerid[i]];
			bossadlevel+=playeradlevel[playerid[i]];
			bosslevel2+=playerhlevel[playerid[i]];
			bosshlevel+=playerhlevel[playerid[i]];
			bosslevel2+=playerhrlevel[playerid[i]];
			bosshrlevel+=playerhrlevel[playerid[i]];
		}
	}
	playerlevel2=playerlevel2+$.Localize("#BossLevelup_AttackDamage")+"(<font color='white'>Lv."+bossadlevel+"</font>);";
	playerlevel2=playerlevel2+$.Localize("#BossLevelup_Health")+"(<font color='white'>Lv."+bosshlevel+"</font>);";
	playerlevel2=playerlevel2+$.Localize("#BossLevelup_HealthRegen")+"(<font color='white'>Lv."+bosshrlevel+"</font>)";	
	if (playerteam[Players.GetLocalPlayer()]==DOTATeam_t.DOTA_TEAM_BADGUYS)
		for (var i = 1;i<=playercount;i++)
		{
			if (playerteam[playerid[i]] == DOTATeam_t.DOTA_TEAM_BADGUYS)
			{
				if (playerlevel2!="")
					playerlevel2=playerlevel2+"<br>";
				playerlevel2=playerlevel2+Players.GetPlayerName(playerid[i])+":";
				playerlevel2=playerlevel2+$.Localize("#BossLevelup_AttackDamage")+"(<font color='white'>"+playeradlevel[playerid[i]]+"/"+bossadlevel+"</font>);";
				playerlevel2=playerlevel2+$.Localize("#BossLevelup_Health")+"(<font color='white'>"+playerhlevel[playerid[i]]+"/"+bosshlevel+"</font>);";
				playerlevel2=playerlevel2+$.Localize("#BossLevelup_HealthRegen")+"(<font color='white'>"+playerhrlevel[playerid[i]]+"/"+bosshrlevel+"</font>)";
			}
		};
	playerlevel2 = playerlevel2.replace(/'/g,"\\'");
}
function UpdateBossHealth()
{
	UpdateTeamScore1();
	UpdateTeamScore2();
	UpdateBossLevel1();
	UpdateBossLevel2();
	if (bool)
	{
		$("#BossHealthBarPanel").visible = true;
		$("#LifeCount1").text = lifecount1;
		$("#LifeCount2").text = lifecount2;
		$("#LevelNumber1").text = bosslevel1;
		$("#LevelNumber2").text = bosslevel2;
		$("#TeamName1").text = $.Localize("#Team1Name");
		$("#TeamName2").text = $.Localize("#Team2Name");
		$("#TeamScore1").text = "("+GetTeamAllScore(DOTATeam_t.DOTA_TEAM_GOODGUYS)+")";
		$("#TeamScore2").text = "("+GetTeamAllScore(DOTATeam_t.DOTA_TEAM_BADGUYS)+")";
		$("#TeamScore1").visible = (playerteam[Players.GetLocalPlayer()]==DOTATeam_t.DOTA_TEAM_GOODGUYS||showtoenemy);
		$("#TeamScore2").visible = (playerteam[Players.GetLocalPlayer()]==DOTATeam_t.DOTA_TEAM_BADGUYS||showtoenemy);
		var healthpercent = ((Entities.GetHealth(boss1)/Entities.GetMaxHealth(boss1))*98.039215686274509803921568627451);
		$("#BossHealth1").style.width = healthpercent+"%";
		healthpercent = ((Entities.GetHealth(boss2)/Entities.GetMaxHealth(boss2))*98.039215686274509803921568627451);
		$("#BossHealth2").style.width = healthpercent+"%";
	}
	else
	{
		$("#BossHealthBarPanel").visible = false;
	}
}

function TeamAllScore1ShowTooltip()
{
	if (playerteam[Players.GetLocalPlayer()]==DOTATeam_t.DOTA_TEAM_GOODGUYS||showtoenemy)
		$.DispatchEvent( "DOTAShowTextTooltip",$("#TeamAllScore1"),teamscore1);
	else
		$.DispatchEvent( "DOTAShowTextTooltip",$("#TeamAllScore1"),$.Localize("#ShowToEnemy"));
}
function TeamAllScore1HideTooltip()
{
	$.DispatchEvent( "DOTAHideTextTooltip",$("#TeamAllScore1"));
}

function TeamAllScore2ShowTooltip()
{
	if (playerteam[Players.GetLocalPlayer()]==DOTATeam_t.DOTA_TEAM_BADGUYS||showtoenemy)
		$.DispatchEvent( "DOTAShowTextTooltip",$("#TeamAllScore2"),teamscore2);
	else
		$.DispatchEvent( "DOTAShowTextTooltip",$("#TeamAllScore2"),$.Localize("#ShowToEnemy"));
}
function TeamAllScore2HideTooltip()
{
	$.DispatchEvent( "DOTAHideTextTooltip",$("#TeamAllScore2"));
}

function BossLevel1ShowTooltip()
{
	var s=$.Localize("#BossLevel")+":<font color='#fbf365'>Lv."+bosslevel1+"</font>";
	s = s.replace(/'/g,"\\'");
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#BossLevel1"),s,playerlevel1);
}
function BossLevel1HideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#BossLevel1"));
}

function BossLevel2ShowTooltip()
{
	var s=$.Localize("#BossLevel")+":<font color='#c6f0f5'>Lv."+bosslevel2+"</font>";
	s = s.replace(/'/g,"\\'");
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#BossLevel2"),s,playerlevel2);
}
function BossLevel2HideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#BossLevel2"));
}

function InitBossHealthBar(data)
{
}
function GetTeamAllScore(team)
{
	var score = 0;
	for (var i = 1;i<=playercount;i++)
	{
		if (playerteam[playerid[i]] == team)
			score+=playerscore[playerid[i]];
	}
	return score;
}
function GetPlayerStatesByLua(data)
{
	boss1=data.boss1;
	lifecount1=data.bosslife1;
	boss2=data.boss2;
	lifecount2=data.bosslife2;
	bool=data.bossbool;
	showtoenemy = data.showtoother;
	for (var i = 1;i<=playercount;i++)
	{
		if (playerid[i] == data.playerid)
		{
			playerscore[data.playerid]=data.score;
			playerteam[data.playerid]=data.playerteam;
			playeradlevel[data.playerid]=data.adlevel;
			playerhlevel[data.playerid]=data.hlevel;
			playerhrlevel[data.playerid]=data.hrlevel;
			UpdateBossHealth();
			return null;
		}
	}
	playercount+=1;
	playerid[playercount]=data.playerid;
	playerscore[data.playerid]=data.score;
	playerteam[data.playerid]=data.playerteam;
	playeradlevel[data.playerid]=data.adlevel;
	playerhlevel[data.playerid]=data.hlevel;
	playerhrlevel[data.playerid]=data.hrlevel;
	UpdateBossHealth();
}
(function()
{
	$.GetContextPanel().SetHasClass("Russian", ($.Language()=="russian"));
	GameEvents.Subscribe("updateflyoutscoreboard", GetPlayerStatesByLua);
})();
