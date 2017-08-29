var RoundProgressBarPanel;
function UpdateRound(data)
{
	$("#RoundNumber").text = data.round;
}
function UpdateRoundProgressBar(data)
{
	$("#RoundProgressBarTime").text = $.Localize("#QuestTimer")+Math.floor(data.time)+"/"+data.period;
	var percent = data.time/data.period;
	var width = percent*100+"%";
	var size;
	if (percent == 0)
		size = "100% 100%";
	else
		size = (1/percent)*100+"% 100%";
	RoundProgressBarPanel.style.width=width;
	RoundProgressBarPanel.style.backgroundSize=size;
	if (percent>=0.99)
		$("#RoundProgressBar").SetHasClass("full", true);
	else
		$("#RoundProgressBar").SetHasClass("full", false);
}
(function()
{
	RoundProgressBarPanel = $("#RoundProgressBarOverlay");
	$.GetContextPanel().SetHasClass("Russian", ($.Language()=="russian"));
	GameEvents.Subscribe("updateround", UpdateRound);
	GameEvents.Subscribe("updateroundprogressbar", UpdateRoundProgressBar);
})();