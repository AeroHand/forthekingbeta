var m_LeftKing = -1;
var m_RightKing = -1;
function BossControl()
{
	var unit = Players.GetLocalPlayerPortraitUnit();
	if (unit == m_LeftKing || unit == m_RightKing) GameEvents.SendCustomGameEventToServer("set_boss_controllable",{});
}
function SetBossControllable(data)
{

}
(function()
{
	var info = CustomNetTables.GetTableValue("Game", "info");
	m_LeftKing = info.leftKing;
	m_RightKing = info.rightKing;

	GameEvents.Subscribe("dota_player_update_selected_unit", BossControl);
	GameEvents.Subscribe("dota_player_update_query_unit", BossControl);

	GameEvents.Subscribe("updatebosscontrollable", SetBossControllable);
})();
