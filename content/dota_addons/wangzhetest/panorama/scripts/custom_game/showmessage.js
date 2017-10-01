var time = -1;
var last = 0;
var mode = 0;
function Reset2()
{
	$.GetContextPanel().SetHasClass( "show", false );
}
function Reset1()
{
	$.GetContextPanel().SetHasClass( "time", false );
	$.GetContextPanel().SetHasClass( "show", true );
	last = Game.GetGameTime();
	time = 0.85;
	mode = 2;
}
function Timer()
{
	var now = Game.GetGameTime();
	if (now - last >= time)
		if (mode == 1)
			Reset1();
		else
			Reset2();
	$.Schedule(0,Timer);
}
function ShowMessage(data)
{
	if (data.Message != "")
	{
		$("#Message").text = $.Localize(data.Message);
		$.GetContextPanel().SetHasClass( "show", false );
		$.GetContextPanel().SetHasClass( "time", true );
		last = Game.GetGameTime();
		time = 0.15;
		mode = 1;
		// GameEvents.SendEventClientSide("dota_hud_error_message", {"splitscreenplayer":Players.GetLocalPlayer(), "reason":80, "message":$.Localize(data.Message)});
	}
	Game.EmitSound(data.SoundName);
}
(function()
{
	$.Schedule(0,Timer);
	$.GetContextPanel().SetHasClass("Russian", ($.Language()=="russian"));
	GameEvents.Subscribe("showmessage", ShowMessage);
})();