var m_GeneralName = "";
var m_GeneralGoldCost = -1;
var m_GeneralLumberCost = -1;
var m_GeneralNeedScore = -1;
var m_GeneralIncome = -1;
var m_GeneralStock = -1;
var m_GeneralMaxStock = -1;
var m_GeneralStockTime = -1;
var m_RestockTime = -1;
var m_GeneralId = -1;
var m_way = -1;
var m_Gold=-1;
var m_Crystal=-1;
var m_Income=-1;
var m_Score=-1;
var m_Worker_count=-1;
var m_Worker_max=-1;
var m_Food_count=-1;
var m_Food_max=-1;
var last_time=-1;

function UpdateGeneral()
{
	$( "#GeneralImage" ).SetImage("file://{images}/generals/"+m_GeneralName+".png");
	$( "#GeneralStock" ).text = m_GeneralStock;
	$( "#GeneralGoldCost" ).text = m_GeneralGoldCost;
	$( "#GeneralLumberCost" ).text = m_GeneralLumberCost;

	$.GetContextPanel().SetHasClass("not_enough_states", (m_Gold<m_GeneralGoldCost||m_Crystal<m_GeneralLumberCost));
	$.GetContextPanel().SetHasClass("no_stock", (m_GeneralStock<=0));
	if (m_GeneralGoldCost==0)		$("#GeneralGoldCost").visible = false;
	if (m_GeneralLumberCost==0)	$("#GeneralLumberCost").visible = false;

	if (m_GeneralStock==0)
	{
		$( "#Cooldown" ).visible = true;
		var cooldownPercent = Math.ceil( 100 * m_RestockTime / m_GeneralStockTime );
		$( "#CooldownTimer" ).text = Math.ceil( m_RestockTime );
		$( "#CooldownOverlay" ).style.width = cooldownPercent+"%";
	}
	else
	{
		$( "#Cooldown" ).visible = false;
	}

	$.Schedule( 0.1, UpdateGeneral );
}

function GeneralShowTooltip()
{
	var Panel = $("#GeneralButton");
	Panel.SetDialogVariableInt( "gold", m_GeneralGoldCost );
	Panel.SetDialogVariableInt( "crystal", m_GeneralLumberCost );
	Panel.SetDialogVariableInt( "needscore", m_GeneralNeedScore );
	Panel.SetDialogVariableInt( "income", m_GeneralIncome );
	var str = $.Localize("#"+m_GeneralName+"_Description",Panel);
	str = str.replace(/'/g,"\\'");
	$.DispatchEvent("DOTAShowTitleTextTooltip",$.GetContextPanel(),$.Localize("#"+m_GeneralName),str);
}

function GeneralHideTooltip()
{
	$.DispatchEvent("DOTAHideTitleTextTooltip",$.GetContextPanel());
}
function AddGeneralStock()
{
	m_GeneralStock = m_GeneralStock + 1;
}
function RestockGeneralTimer()
{
	var now=Game.GetGameTime();
	m_RestockTime = m_RestockTime -	(now-last_time);
	last_time=now;
	if (m_RestockTime>0)
	{
		$.Schedule(0,RestockGeneralTimer);
	}
	else
	{
		AddGeneralStock();
		RestockGeneral();
	}
}
function RestockGeneral()
{
	if (m_GeneralStock<m_GeneralMaxStock)
	{
		m_RestockTime=m_GeneralStockTime;
		last_time=Game.GetGameTime();
		$.Schedule(0,RestockGeneralTimer);
	}
}
function DecreaseGeneralStock()
{
	m_GeneralStock = m_GeneralStock - 1;
	if (m_GeneralStock==m_GeneralMaxStock-1)
		RestockGeneral();
}
function SetWay(way)
{
	m_way = way;
}
function BuyGeneral()
{
	GameEvents.SendCustomGameEventToServer("item_purchased", {id:m_GeneralId,ItemName:m_GeneralName,GoldCost:m_GeneralGoldCost,LumberCost:m_GeneralLumberCost,NeedScore:m_GeneralNeedScore,Income:m_GeneralIncome,Way:m_way,Stock:m_GeneralStock});
}
function SetGeneralState(GeneralName,GeneralGoldCost,GeneralLumberCost,GeneralNeedScore,GeneralIncome,GeneralStock,GeneralMaxStock,GeneralStockTime,GeneralId)
{
	m_GeneralName=GeneralName;
	m_GeneralGoldCost=GeneralGoldCost;
	m_GeneralLumberCost=GeneralLumberCost;
	m_GeneralNeedScore=GeneralNeedScore;
	m_GeneralIncome=GeneralIncome;
	m_GeneralStock=GeneralStock;
	m_GeneralMaxStock=GeneralMaxStock;
	m_GeneralStockTime=GeneralStockTime;
	m_GeneralId=GeneralId;

	RestockGeneral();
	m_way=0;
}
function UpdateData(tableName, keyName, table)
{
	if (keyName == ("Player_"+Players.GetLocalPlayer()))
	{
		var playerData = table;
		m_Gold = playerData.Gold;
		m_Crystal = playerData.Crystal;
		m_Income = playerData.BaseIncome+playerData.Income;
		m_Score = playerData.Score;
		m_Worker_count = playerData.FarmerNum;
		m_Worker_max = 8;
		m_Food_count = playerData.CurFood;
		m_Food_max = playerData.FullFood;
	}
}

(function()
{
	$.GetContextPanel().SetGeneralState = SetGeneralState;
	$.GetContextPanel().DecreaseGeneralStock = DecreaseGeneralStock;
	$.GetContextPanel().SetWay = SetWay;

	UpdateData("PlayerData", "Player_"+Players.GetLocalPlayer(), CustomNetTables.GetTableValue("PlayerData", "Player_"+Players.GetLocalPlayer()));
	CustomNetTables.SubscribeNetTableListener("PlayerData", UpdateData);
	UpdateGeneral();
})();
