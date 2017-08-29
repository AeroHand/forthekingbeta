function ShowPlayerTools()
{
	$.GetContextPanel().SetHasClass("show_tools", ! $.GetContextPanel().BHasClass("show_tools"));
}
(function()
{
	$.GetContextPanel().visible = !Players.IsSpectator(Players.GetLocalPlayer());
})();