function WriteConfig()
	local basePath = "../../../content/dota_addons/wangzhetest/panorama/scripts/custom_game/copy_from_lua_config.js"
	local script_text = [[
]]
	script_text = script_text .. "\n\n"

	--所有兵种列表
	local str = json.encode(AllTypes)
	script_text = script_text .. "\n\nvar AllTypes = \n" .. str .. "\n\n"
	--兵种科技树
	local str = json.encode(building_tech.t_tech)
	script_text = script_text .. "\n\nvar BuildingTech = \n" .. str .. "\n\n"

	out = io.open(basePath,"w")
	if out then
		out:write(script_text)
		out:close()
	end
end

if IsInToolsMode() then
	WriteConfig()
end