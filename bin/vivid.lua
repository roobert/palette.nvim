#!/usr/bin/env lua

local theme_name, main_palette_name, accent_palette_name, state_palette_name, vivid_theme_name =
	arg[1], arg[2], arg[3], arg[4], arg[5]

if not theme_name or not main_palette_name or not accent_palette_name or not state_palette_name then
	print("Usage: vivid.lua <theme name> <main palette name> <accent palette name> <state palette name")
	os.exit(1)
end

package.path = package.path .. ";lua/" .. theme_name .. "/?.lua"

local colors = require("colors")

local vivid_file_path = "vivid/themes/" .. vivid_theme_name .. ".yml"

local vivid_file = io.open(vivid_file_path, "w")
local vivid_filetypes_file = io.open("vivid/filetypes.yml", "r")

local function get_ordered_keys(t)
	local keys = {}
	for key in pairs(t) do
		table.insert(keys, key)
	end
	table.sort(keys)
	return keys
end

local function write_color_table(vivid_file, color_table, indent_level)
	indent_level = indent_level or 0

	local keys = get_ordered_keys(color_table)
	for _, key in ipairs(keys) do
		local value = color_table[key]
		if type(value) == "table" then
			write_color_table(vivid_file, value, indent_level + 1)
		else
			if string.sub(value, 1, 1) == "#" then
				value = string.sub(value, 2)
			end
			vivid_file:write(string.rep(" ", indent_level * 2) .. key .. ": '" .. value .. "'\n")
		end
	end
end

local vivid_header = "colors:\n"
vivid_file:write(vivid_header)

local palettes_map = {
	main = main_palette_name,
	accent = accent_palette_name,
	state = state_palette_name,
}

for group, palette_name in pairs(palettes_map) do
	if colors[group] and colors[group][palette_name] then
		write_color_table(vivid_file, { [palette_name] = colors[group][palette_name] })
	end
end

vivid_file:write("\n")
vivid_file:write(vivid_filetypes_file:read("*a"))

vivid_filetypes_file:close()
vivid_file:close()

print("Colors extracted to: " .. vivid_file_path)
