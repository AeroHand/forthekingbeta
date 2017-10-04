var boss_left_controllable = -1;
var boss_right_controllable = -1;
var playerteam = [];
function BossControlShowTooltip()
{
	var str = $.Localize("#BossControler");
	if (playerteam[Players.GetLocalPlayer()]==DOTATeam_t.DOTA_TEAM_GOODGUYS) str=str+":"+Players.GetPlayerName(boss_left_controllable);
	if (playerteam[Players.GetLocalPlayer()]==DOTATeam_t.DOTA_TEAM_BADGUYS) str=str+":"+Players.GetPlayerName(boss_right_controllable);
	str = str.replace(/'/g,"\\'");
	$.DispatchEvent("DOTAShowTextTooltip",$("#BossControlButton_Label"),str);
}

function BossControlHideTooltip()
{
	$.DispatchEvent("DOTAHideTextTooltip",$("#BossControlButton_Label"));
}
function SetBossControllable(data)
{
	if (data.team == DOTATeam_t.DOTA_TEAM_GOODGUYS)
		boss_left_controllable=data.player;
	if (data.team == DOTATeam_t.DOTA_TEAM_BADGUYS)
		boss_right_controllable=data.player;
	if (Players.GetLocalPlayer()==data.player)
	{
		BossControlHideTooltip();
		BossControlShowTooltip();
	}
}

function BossControl()
{
	GameEvents.SendCustomGameEventToServer("set_boss_controllable",{});
	GameEvents.SendCustomGameEventToServer("opentop",{});
}
function UpdatePlayerTeam(data)
{
	playerteam[data.playerid] = data.playerteam;
}
(function()
{
	$.GetContextPanel().SetHasClass("Russian", ($.Language()=="russian"));
	GameEvents.Subscribe("updateflyoutscoreboard", UpdatePlayerTeam);
	GameEvents.Subscribe("updatebosscontrollable", SetBossControllable);
})();
