var RoundProgressBarPanel = $("#RoundProgressBarOverlay");
var m_RoundTime = 0;
var m_NextRoundTime = 0;

function UpdataGame(tableName, keyName, table)
{
	if (keyName == "info")
	{
		$("#RoundNumber").text = table.round;

		m_RoundTime = table.roundTime;
	}
	if (keyName == "time")
	{
		m_NextRoundTime = table.nextRoundTime;
	}
}
function Updata()
{
	$.Schedule(0.1, Updata);

	var time = m_RoundTime - Math.max(0, m_NextRoundTime-Game.GetGameTime());

	$("#RoundProgressBarTime").text = $.Localize("#QuestTimer")+Math.floor(time)+"/"+m_RoundTime;

	var percent = time/m_RoundTime;
	var width = percent*100+"%";
	var size;
	if (percent == 0) size = "100% 100%";
	else size = (1/percent)*100+"% 100%";
	RoundProgressBarPanel.style.width = width;
	RoundProgressBarPanel.style.backgroundSize = size;
	if (percent>=0.99) $("#RoundProgressBar").SetHasClass("full", true);
	else $("#RoundProgressBar").SetHasClass("full", false);
}
(function()
{
	$.GetContextPanel().SetHasClass("Russian", ($.Language()=="russian"));

	UpdataGame("Game", "info", CustomNetTables.GetTableValue("Game", "info"));
	UpdataGame("Game", "time", CustomNetTables.GetTableValue("Game", "time"));
	CustomNetTables.SubscribeNetTableListener("Game", UpdataGame);

	Updata();
})();