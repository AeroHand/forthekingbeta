function ShowPlayerTools()
{
	$.GetContextPanel().SetHasClass("show_tools", ! $.GetContextPanel().BHasClass("show_tools"));
}
function ShowRealDamage(i)
{
	GameEvents.SendCustomGameEventToServer("update_player_settings", {show_damage_message:i})
}
(function()
{
	$.GetContextPanel().visible = !Players.IsSpectator(Players.GetLocalPlayer());
})();