AandDSystem = AandDSystem or class(
{
	attackTypeAbilityList =
	{
		normal = "AB",
		pierce = "AP",
		magic = "AM",
		siege = "AS",
		chaos = "AL",
		hero = "AH",
	},
	defenseTypeAbilityList =
	{
		small = "DW",
		medium = "DS",
		large = "DZ",
		fort = "DC",
		hero = "DH",
		none = "DB",
	},
	resistanceTable = 
	{
		["normal"] = {},
		["pierce"] = {},
		["magic"] = {},
		["siege"] = {},
		["chaos"] = {},
		["hero"] = {},
	},
	resistance = 
	{
		["normal"] = 0,
		["pierce"] = 0,
		["magic"] = 0,
		["siege"] = 0,
		["chaos"] = 0,
		["hero"] = 0,
	},
},
nil, nil)

AandDSystem.AandDSystemTable = {}
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

function AandDSystem:GetAandDSystem(hUnit)
	return self.AandDSystemTable[hUnit:entindex()]
end

function AandDSystem:constructor(hUnit)
	local index = hUnit:entindex()
	AandDSystem.AandDSystemTable[index] = self

	local unitName = hUnit:GetUnitName()
	local attackType = UnitManager:GetAttackTypeFromName(unitName)
	local defenseType = UnitManager:GetDefendTypeFromName(unitName)

	self.unit = hUnit
	attackType = self:TransAttackType(attackType)
	defenseType = self:TransDefenseType(defenseType)

	--初始化抗性
	for i,v in pairs(self.attackTypeAbilityList) do
		self:AddAttacktypeResistance(i, self.DefaultResistance[i.."VS"..defenseType], v)
	end

	UnitManager:AddDefaultAbility(self.unit)

	self.attackType = attackType
	self.attackTypeAbility = AbilityManager:AddAndSet(self.unit, self.attackTypeAbilityList[attackType])

	self.defenseType = defenseType
	self.defenseTypeAbiltiy = AbilityManager:AddAndSet(self.unit, self.defenseTypeAbilityList[defenseType])
end

function AandDSystem:UpdateResistance(attackType)
	local r = 1
	for i,resistance in pairs(self.resistanceTable[attackType]) do
		r = r * (1-resistance)
	end
	self.resistance[attackType] = 1-r
end
--sname为索引，可以用做修改或删除所添加的抗性，不填，则返回一个系统随机生成的索引
function AandDSystem:AddAttacktypeResistance(attackType, fResistance, sName)
	if not (attackType == "normal" or attackType == "pierce" or attackType == "magic" or attackType == "siege" or attackType == "chaos" or attackType == "hero") then
		return
	end
	sName = sName or DoUniqueString(attackType)
	self.resistanceTable[attackType][sName] = fResistance
	self:UpdateResistance(attackType)
	return sName
end
function AandDSystem:RemoveAttacktypeResistance(attackType, sName)
	if not (attackType == "normal" or attackType == "pierce" or attackType == "magic" or attackType == "siege" or attackType == "chaos" or attackType == "hero") then
		return
	end
	if type(sName) ~= "string" then
		return
	end
	self.resistanceTable[attackType][sName] = nil
	self:UpdateResistance(attackType)
end

function AandDSystem:GetAttacktypeResistance(attackType)
	return self.resistance[attackType]
end
function AandDSystem:GetUnit()
	return self.unit
end
function AandDSystem:GetAttackType()
	return self.attackType
end
function AandDSystem:GetDefensetype()
	return self.defenseType
end

function AandDSystem:TransDefenseType(defenseType)
	if defenseType == "W" then
		return "small"
	end
	if defenseType == "S" then
		return "medium"
	end
	if defenseType == "Z" then
		return "large"
	end
	if defenseType == "C" then
		return "fort"
	end
	if defenseType == "H" then
		return "hero"
	end
	if defenseType == "B" then
		return "none"
	end
	return defenseType
end
function AandDSystem:TransAttackType(attackType)
	if attackType == "B" then
		return "normal"
	end
	if attackType == "P" then
		return "pierce"
	end
	if attackType == "M" then
		return "magic"
	end
	if attackType == "S" then
		return "siege"
	end
	if attackType == "L" then
		return "chaos"
	end
	if attackType == "H" then
		return "hero"
	end
	return attackType
end