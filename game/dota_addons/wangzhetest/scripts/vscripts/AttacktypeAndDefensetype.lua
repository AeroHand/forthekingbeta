if AandDSystem == nil then
	AandDSystem = class({})
end
AandDSystemTable = {}
function GetAandDSystem(hunit)
	return AandDSystemTable[hunit:entindex()]
end
function AandDSystem:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index=self
	return o
end
--初始抗性表
AandDSystem.DefaultResistance = 
{
	["normal".."VS".."small"] = 1-0.80,
	["normal".."VS".."medium"] = 1-1.30,
	["normal".."VS".."large"] = 1-0.90,
	["normal".."VS".."fort"] = 1-0.90,
	["normal".."VS".."hero"] = 1-0.85,
	["normal".."VS".."none"] = 1-1.00,

	["pierce".."VS".."small"] = 1-1.30,
	["pierce".."VS".."medium"] = 1-1.00,
	["pierce".."VS".."large"] = 1-0.80,
	["pierce".."VS".."fort"] = 1-0.80,
	["pierce".."VS".."hero"] = 1-0.85,
	["pierce".."VS".."none"] = 1-1.00,

	["magic".."VS".."small"] = 1-1.10,
	["magic".."VS".."medium"] = 1-0.80,
	["magic".."VS".."large"] = 1-1.30,
	["magic".."VS".."fort"] = 1-0.70,
	["magic".."VS".."hero"] = 1-0.85,
	["magic".."VS".."none"] = 1-1.00,

	["siege".."VS".."small"] = 1-0.80,
	["siege".."VS".."medium"] = 1-0.90,
	["siege".."VS".."large"] = 1-0.90,
	["siege".."VS".."fort"] = 1-1.30,
	["siege".."VS".."hero"] = 1-0.85,
	["siege".."VS".."none"] = 1-1.00,

	["chaos".."VS".."small"] = 1-1.10,
	["chaos".."VS".."medium"] = 1-1.10,
	["chaos".."VS".."large"] = 1-1.10,
	["chaos".."VS".."fort"] = 1-1.10,
	["chaos".."VS".."hero"] = 1-1.10,
	["chaos".."VS".."none"] = 1-1.10,
	
	["hero".."VS".."small"] = 1-1.00,
	["hero".."VS".."medium"] = 1-1.00,
	["hero".."VS".."large"] = 1-1.00,
	["hero".."VS".."fort"] = 1-1.00,
	["hero".."VS".."hero"] = 1-1.00,
	["hero".."VS".."none"] = 1-1.00,
}
function AandDSystem:Init()
	self.attacktype_ability =
	{
		normal="AB",
		pierce="AP",
		magic="AM",
		siege="AS",
		chaos="AL",
		hero="AH",
	}
	self.defensetype_ability =
	{
		small="DW",
		medium="DS",
		large="DZ",
		fort="DC",
		hero="DH",
		none="DB",
	}
	self.ResistanceTable = 
	{
		["normal"] = {},
		["pierce"] = {},
		["magic"] = {},
		["siege"] = {},
		["chaos"] = {},
		["hero"] = {},
	}
	self.Resistance = 
	{
		["normal"] = 0,
		["pierce"] = 0,
		["magic"] = 0,
		["siege"] = 0,
		["chaos"] = 0,
		["hero"] = 0,
	}
end
function AandDSystem:UpdateResistance(sattacktype)
	local r = 1
	for i,resistance in pairs(self.ResistanceTable[sattacktype]) do
		r = r * (1-resistance)
	end
	self.Resistance[sattacktype] = 1-r
end
--sname为索引，可以用做修改或删除所添加的抗性，不填，则返回一个系统随机生成的索引
function AandDSystem:AddAttacktypeResistance(sattacktype,fresistance,sname)
	if not (sattacktype == "normal" or sattacktype == "pierce" or sattacktype == "magic" or sattacktype == "siege" or sattacktype == "chaos" or sattacktype == "hero") then
		return
	end
	sname = sname or DoUniqueString(sattacktype)
	self.ResistanceTable[sattacktype][sname] = fresistance
	self:UpdateResistance(sattacktype)
	return sname
end
function AandDSystem:RemoveAttacktypeResistance(sattacktype,sname)
	if not (sattacktype == "normal" or sattacktype == "pierce" or sattacktype == "magic" or sattacktype == "siege" or sattacktype == "chaos" or sattacktype == "hero") then
		return
	end
	if type(sname) ~= "string" then
		return
	end
	self.ResistanceTable[sattacktype][sname] = 0
	self:UpdateResistance(sattacktype)
end
function AandDSystem:GetAttacktypeResistance(sattacktype)
	return self.Resistance[sattacktype]
end
function AandDSystem:GetUnit()
	return self.Unit
end
function AandDSystem:GetAttackType()
	return self.AttackType
end
function AandDSystem:GetDefensetype()
	return self.Defensetype
end
function AandDSystem:TransDefenseType(sdefensetype)
	if sdefensetype == "W" then
		return "small"
	end
	if sdefensetype == "S" then
		return "medium"
	end
	if sdefensetype == "Z" then
		return "large"
	end
	if sdefensetype == "C" then
		return "fort"
	end
	if sdefensetype == "H" then
		return "hero"
	end
	if sdefensetype == "B" then
		return "none"
	end
	return sdefensetype
end
function AandDSystem:TransAttackType(sattacktype)
	if sattacktype == "B" then
		return "normal"
	end
	if sattacktype == "P" then
		return "pierce"
	end
	if sattacktype == "M" then
		return "magic"
	end
	if sattacktype == "S" then
		return "siege"
	end
	if sattacktype == "L" then
		return "chaos"
	end
	if sattacktype == "H" then
		return "hero"
	end
	return sattacktype
end
--给单位添加攻防系统，并且初始化抗性
function CreateAandDSystem(hunit,sattacktype,sdefensetype)
	local AandD = AandDSystem:new()
	local s = hunit:entindex()
	AandDSystemTable[s] = AandD
	AandD:Init()
	AandD.Unit = hunit
	sattacktype = AandD:TransAttackType(sattacktype)
	sdefensetype = AandD:TransDefenseType(sdefensetype)

	--初始化抗性
	for i,v in pairs(AandD.attacktype_ability) do
		AandD:AddAttacktypeResistance(i,AandD.DefaultResistance[i.."VS"..sdefensetype],v)
	end
	
	UnitManager:AddDefaultAbility(AandD.Unit)

	AandD.AttackType = sattacktype
	AandD.Attacktype_Abiltiy = AbilityManager:AddAndSet(AandD.Unit,AandD.attacktype_ability[sattacktype])

	AandD.Defensetype = sdefensetype
	AandD.Defensetype_Abiltiy = AbilityManager:AddAndSet(AandD.Unit,AandD.defensetype_ability[sdefensetype])

	return AandD
end