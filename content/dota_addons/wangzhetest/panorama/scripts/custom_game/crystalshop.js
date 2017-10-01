"use strict";
function CrystalShopShowTooltip()
{
	$.DispatchEvent( "DOTAShowTextTooltip",$("#CrystalShop_Button_Open"),"#CrystalShopKey");
}

function CrystalShopHideTooltip()
{
	$.DispatchEvent( "DOTAHideTextTooltip",$("#CrystalShop_Button_Open"));
}
function OpenCrystalshop()
{
	if ($("#CrystalShop_Button_Open").visible)
	{
		$("#CrystalShop_Button_Open").visible = false;
		$("#CrystalShop_Button_Open").hittest = false;
		$("#CrystalShop_Button_Close").visible = true;
		$("#CrystalShop_Button_Close").hittest = true;
		$("#CrystalShop").visible = true;
		Game.EmitSound("Shop.PanelUp");
	}
}
function CloseCrystalshop()
{
	if (! $("#CrystalShop_Button_Open").visible)
	{
		$("#CrystalShop_Button_Open").visible = true;
		$("#CrystalShop_Button_Open").hittest = true;
		$("#CrystalShop_Button_Close").visible = false;
		$("#CrystalShop_Button_Close").hittest = false;
		$("#CrystalShop").visible = false;
		Game.EmitSound("Shop.PanelDown");
	}
}
function OnCrystalShopButtonPressed()
{
	if ($("#CrystalShop_Button_Open").visible)
		OpenCrystalshop();
	else
		CloseCrystalshop();
}

function OnCrystalShopButtonReleased()
{
}

// Main mouse event callback
GameUI.SetMouseCallback(
function( eventName, arg )
{
	var nMouseButton = arg
	var CONSUME_EVENT = true;
	var CONTINUE_PROCESSING_EVENT = false;
	if ( GameUI.GetClickBehaviors() !== CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_NONE )
		return CONTINUE_PROCESSING_EVENT;

	if ( eventName === "pressed" )
	{
		// Left-click is move to position or attack
		if ( arg === 0 )
		{
			CloseCrystalshop();
		}
	}
	// if ( eventName === "wheeled" )
	// {
	// 	g_targetDistance += arg * -50;
	// 	return CONSUME_EVENT;
	// }

	return CONTINUE_PROCESSING_EVENT;
});

var m_HireShopPanels = [];
var m_HireShopPanelsCount = 0;
var m_GeneralsShopPanels = [];
var m_GeneralsShopPanelsCount = 0;
var playerid=[];
var playercount=0;
var adlevel=0;
var hlevel=0;
var hrlevel=0;
var Lumber=0;
function AttackDamageShowTooltip()
{
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#BossLevelup_AttackDamage"),"#BossLevelup_AttackDamage","#BossLevelup_AttackDamage_Description");
}
function AttackDamageHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#BossLevelup_AttackDamage"));
}
function HealthShowTooltip()
{
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#BossLevelup_Health"),"#BossLevelup_Health","#BossLevelup_Health_Description");
}
function HealthHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#BossLevelup_Health"));
}
function HealthRegenShowTooltip()
{
	$.DispatchEvent( "DOTAShowTitleTextTooltip",$("#BossLevelup_HealthRegen"),"#BossLevelup_HealthRegen","#BossLevelup_HealthRegen_Description");
}
function HealthRegenHideTooltip()
{
	$.DispatchEvent( "DOTAHideTitleTextTooltip",$("#BossLevelup_HealthRegen"));
}
function LevelupAttackDamage()
{
	GameEvents.SendCustomGameEventToServer("boss_levelup", {LevelUpType:"attackdamage",LumberCost:58,Income:2});
}
function LevelupHealth()
{
	GameEvents.SendCustomGameEventToServer("boss_levelup", {LevelUpType:"health",LumberCost:58,Income:2});
}
function LevelupHealthRegen()
{
	GameEvents.SendCustomGameEventToServer("boss_levelup", {LevelUpType:"healthregen",LumberCost:58,Income:2});
}
function UpdateBossLevelUpPanel()
{
	$("#AttackDamage_Level").text="Lv."+adlevel;
	$("#Health_Level").text="Lv."+hlevel;
	$("#HealthRegen_Level").text="Lv."+hrlevel;
	$("#BossLevelup_States").SetHasClass("not_enough_states", (Lumber<58));
	$.GetContextPanel().SetHasClass("max_level1", (adlevel>=20));
	$.GetContextPanel().SetHasClass("max_level2", (hlevel>=20));
	$.GetContextPanel().SetHasClass("max_level3", (hrlevel>=20));
	$.Schedule(0.1,UpdateBossLevelUpPanel);
}
function UpdateBossLevel(tableName, keyName, table)
{
	if (keyName == "info")
	{
		if (Players.GetTeam(Players.GetLocalPlayer()) == DOTATeam_t.DOTA_TEAM_GOODGUYS)
		{
			adlevel = table.leftADLevel;
			hlevel = table.leftHLevel;
			hrlevel = table.leftHRLevel;
		}
		else if (Players.GetTeam(Players.GetLocalPlayer()) == DOTATeam_t.DOTA_TEAM_BADGUYS)
		{
			adlevel = table.rightADLevel;
			hlevel = table.rightHLevel;
			hrlevel = table.rightHRLevel;
		}
	}
	UpdateBossLevelUpPanel();
}
function UpdateCrystal(tableName, keyName, table)
{
	if (keyName == ("Player_"+Players.GetLocalPlayer()))
	{
		var playerData = table;
		Lumber = playerData.Crystal;
	}
	UpdateBossLevelUpPanel();
}
function HireSuccess(data)
{
	var HireShop = m_HireShopPanels[data.id];
	HireShop.DecreaseItemStock();
}
function GeneralSuccess(data)
{
	var GeneralItem = m_GeneralsShopPanels[data.id];
	GeneralItem.DecreaseGeneralStock();
}
function ChangeWay()
{
	var wayid = $("#hireshop_chooseway").GetSelected().id;
	var way = 0;
	if (wayid == "hire_way0") way = 0;
	if (wayid == "hire_way1") way = 1;
	if (wayid == "hire_way2") way = 2;
	if (wayid == "hire_way3") way = 3;
	for ( var i = 1; i <= m_HireShopPanelsCount; ++i )
	{
		var HireShop = m_HireShopPanels[i];
		HireShop.SetWay(way);
	}
}

(function()
{
	// smoothCameraDistance();
	$("#CrystalShop_Button_Open").visible = true;
	$("#CrystalShop_Button_Open").hittest = true;
	$("#CrystalShop_Button_Close").visible = false;
	$("#CrystalShop_Button_Close").hittest = false;
	$("#CrystalShop").visible = false;

	UpdateBossLevelUpPanel();

	m_GeneralsShopPanelsCount = m_GeneralsShopPanelsCount + 1;
	var GeneralsItem = $.CreatePanel("Panel", $("#generals_column_1"),"");
	GeneralsItem.BLoadLayout( "file://{resources}/layout/custom_game/general.xml", false, false );
	GeneralsItem.SetGeneralState("general_1",0,500,5000,0,1,1,180,m_GeneralsShopPanelsCount);
	m_GeneralsShopPanels[m_GeneralsShopPanelsCount] = GeneralsItem;
	m_GeneralsShopPanelsCount = m_GeneralsShopPanelsCount + 1;
	var GeneralsItem = $.CreatePanel("Panel", $("#generals_column_2"),"");
	GeneralsItem.BLoadLayout( "file://{resources}/layout/custom_game/general.xml", false, false );
	GeneralsItem.SetGeneralState("general_2",0,450,5000,0,1,1,180,m_GeneralsShopPanelsCount);
	m_GeneralsShopPanels[m_GeneralsShopPanelsCount] = GeneralsItem;
	m_GeneralsShopPanelsCount = m_GeneralsShopPanelsCount + 1;
	var GeneralsItem = $.CreatePanel("Panel", $("#generals_column_1"),"");
	GeneralsItem.BLoadLayout( "file://{resources}/layout/custom_game/general.xml", false, false );
	GeneralsItem.SetGeneralState("general_3",0,400,5000,0,1,1,180,m_GeneralsShopPanelsCount);
	m_GeneralsShopPanels[m_GeneralsShopPanelsCount] = GeneralsItem;
	m_GeneralsShopPanelsCount = m_GeneralsShopPanelsCount + 1;
	var GeneralsItem = $.CreatePanel("Panel", $("#generals_column_2"),"");
	GeneralsItem.BLoadLayout( "file://{resources}/layout/custom_game/general.xml", false, false );
	GeneralsItem.SetGeneralState("general_4",0,350,5000,0,1,1,180,m_GeneralsShopPanelsCount);
	m_GeneralsShopPanels[m_GeneralsShopPanelsCount] = GeneralsItem;
	m_GeneralsShopPanelsCount = m_GeneralsShopPanelsCount + 1;
	var GeneralsItem = $.CreatePanel("Panel", $("#generals_column_1"),"");
	GeneralsItem.BLoadLayout( "file://{resources}/layout/custom_game/general.xml", false, false );
	GeneralsItem.SetGeneralState("general_5",0,300,5000,0,1,1,180,m_GeneralsShopPanelsCount);
	m_GeneralsShopPanels[m_GeneralsShopPanelsCount] = GeneralsItem;
	m_GeneralsShopPanelsCount = m_GeneralsShopPanelsCount + 1;
	var GeneralsItem = $.CreatePanel("Panel", $("#generals_column_2"),"");
	GeneralsItem.BLoadLayout( "file://{resources}/layout/custom_game/general.xml", false, false );
	GeneralsItem.SetGeneralState("general_6",0,300,5000,0,1,1,180,m_GeneralsShopPanelsCount);
	m_GeneralsShopPanels[m_GeneralsShopPanelsCount] = GeneralsItem;

	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_1"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_1",0,20,0,1,5,5,6,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_2"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_2",0,40,0,2,5,5,6,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_1"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_3",0,80,0,4,5,5,6,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_2"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_4",0,120,0,5,3,3,18,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_1"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_5",0,140,0,6,2,2,30,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_2"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_6",0,160,0,7,2,2,30,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_1"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_7",0,200,0,8,2,2,60,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_2"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_8",0,300,0,12,2,2,60,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_1"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_9",0,400,0,17,1,1,120,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_2"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_10",0,500,0,22,1,1,120,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_1"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_11",0,700,0,30,1,1,180,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;
	m_HireShopPanelsCount = m_HireShopPanelsCount + 1;
	var HireShop = $.CreatePanel("Panel", $("#hireshop_items_column_2"),"");
	HireShop.BLoadLayout( "file://{resources}/layout/custom_game/hireshop_item.xml", false, false );
	HireShop.SetItemState("item_hire_12",0,1000,0,40,1,1,180,m_HireShopPanelsCount);
	m_HireShopPanels[m_HireShopPanelsCount] = HireShop;

	$.GetContextPanel().SetHasClass("Russian", ($.Language()=="russian"));
	GameEvents.Subscribe("HireSuccess", HireSuccess);
	GameEvents.Subscribe("GeneralSuccess", GeneralSuccess);

	UpdateBossLevel("Game", "info", CustomNetTables.GetTableValue("Game", "info"));
	UpdateCrystal("PlayerData", "Player_"+Players.GetLocalPlayer(), CustomNetTables.GetTableValue("PlayerData", "Player_"+Players.GetLocalPlayer()));

	CustomNetTables.SubscribeNetTableListener("Game", UpdateBossLevel);
	CustomNetTables.SubscribeNetTableListener("PlayerData", UpdateCrystal);

	Game.AddCommand( "+CrystalShop", OnCrystalShopButtonPressed, "", 0 );
	Game.AddCommand( "-CrystalShop", OnCrystalShopButtonReleased, "", 0 );
})();