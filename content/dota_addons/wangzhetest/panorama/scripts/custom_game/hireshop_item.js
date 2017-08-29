var m_ItemName = "";
var m_ItemGoldCost = -1;
var m_ItemLumberCost = -1;
var m_ItemNeedScore = -1;
var m_ItemIncome = -1;
var m_ItemStock = -1;
var m_ItemMaxStock = -1;
var m_ItemStockTime = -1;
var m_RestockTime = -1;
var m_ItemId = -1;
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

function UpdateItem()
{
	$( "#ItemImage" ).SetImage("file://{images}/custom_game/hireshop/"+m_ItemName+".png");
	$( "#ItemStock" ).text = m_ItemStock;
	$( "#ItemGoldCost" ).text = m_ItemGoldCost;
	$( "#ItemLumberCost" ).text = m_ItemLumberCost;

	$.GetContextPanel().SetHasClass("not_enough_states", (m_Gold<m_ItemGoldCost||m_Crystal<m_ItemLumberCost));
	$.GetContextPanel().SetHasClass("no_stock", (m_ItemStock<=0));
	if (m_ItemGoldCost==0)		$("#ItemGoldCost").visible = false;
	if (m_ItemLumberCost==0)	$("#ItemLumberCost").visible = false;

	if (m_ItemStock==0)
	{
		$( "#Cooldown" ).visible = true;
		var cooldownPercent = Math.ceil( 100 * m_RestockTime / m_ItemStockTime );
		$( "#CooldownTimer" ).text = Math.ceil( m_RestockTime );
		$( "#CooldownOverlay" ).style.width = cooldownPercent+"%";
	}
	else
	{
		$( "#Cooldown" ).visible = false;
	}

	$.Schedule( 0.1, UpdateItem );
}

function ItemShowTooltip()
{
	var Panel = $("#ItemButton");
	Panel.SetDialogVariableInt( "gold", m_ItemGoldCost );
	Panel.SetDialogVariableInt( "crystal", m_ItemLumberCost );
	Panel.SetDialogVariableInt( "income", m_ItemIncome );
	var str = $.Localize("#"+m_ItemName+"_Description",Panel);
	str = str.replace(/'/g,"\\'");
	$.DispatchEvent("DOTAShowTitleTextTooltip",$.GetContextPanel(),$.Localize("#"+m_ItemName),str);
}

function ItemHideTooltip()
{
	$.DispatchEvent("DOTAHideTitleTextTooltip",$.GetContextPanel());
}
function AddItemStock()
{
	m_ItemStock = m_ItemStock + 1;
}
function RestockItemTimer()
{
	var now=Game.GetGameTime();
	m_RestockTime = m_RestockTime -	(now-last_time);
	last_time=now;
	if (m_RestockTime>0)
	{
		$.Schedule(0,RestockItemTimer);
	}
	else
	{
		AddItemStock();
		RestockItem();
	}
}
function RestockItem()
{
	if (m_ItemStock<m_ItemMaxStock)
	{
		m_RestockTime=m_ItemStockTime;
		last_time=Game.GetGameTime();
		$.Schedule(0,RestockItemTimer);
	}
}
function DecreaseItemStock()
{
	m_ItemStock = m_ItemStock - 1;
	if (m_ItemStock==m_ItemMaxStock-1)
		RestockItem();
}
function SetWay(way)
{
	m_way = way;
}
function BuyItem()
{
	GameEvents.SendCustomGameEventToServer("item_purchased", {id:m_ItemId,ItemName:m_ItemName,GoldCost:m_ItemGoldCost,LumberCost:m_ItemLumberCost,NeedScore:m_ItemNeedScore,Income:m_ItemIncome,Way:m_way,Stock:m_ItemStock});
}
function SetItemState(ItemName,ItemGoldCost,ItemLumberCost,ItemNeedScore,ItemIncome,ItemStock,ItemMaxStock,ItemStockTime,ItemId)
{
	m_ItemName=ItemName;
	m_ItemGoldCost=ItemGoldCost;
	m_ItemLumberCost=ItemLumberCost;
	m_ItemNeedScore=ItemNeedScore;
	m_ItemIncome=ItemIncome;
	m_ItemStock=ItemStock;
	m_ItemMaxStock=ItemMaxStock;
	m_ItemStockTime=ItemStockTime;
	m_ItemId=ItemId;

	RestockItem();
	m_way=0;
}
function GetStatesByLua(data)
{
	m_Gold=data.gold;
	m_Crystal=data.crystal;
	m_Income=data.income;
	m_Score=data.score;
	m_Worker_count=data.woker_count;
	m_Worker_max=data.woker_max;
	m_Food_count=data.food_count;
	m_Food_max=data.food_max;
}

(function()
{
	$.GetContextPanel().SetItemState = SetItemState;
	$.GetContextPanel().DecreaseItemStock = DecreaseItemStock;
	$.GetContextPanel().SetWay = SetWay;


	GameEvents.Subscribe("updateplayerstates", GetStatesByLua);
	UpdateItem();
})();
