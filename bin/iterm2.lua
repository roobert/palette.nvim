#!/usr/bin/env lua

function printTable(tbl, indent)
	indent = indent or 0
	for key, value in pairs(tbl) do
		formatting = string.rep("  ", indent) .. tostring(key) .. ": "
		if type(value) == "table" then
			print(formatting)
			printTable(value, indent + 1)
		else
			print(formatting .. tostring(value))
		end
	end
end

local function colorToComponents(colorCode)
	if colorCode:sub(1, 1) == "#" then
		colorCode = colorCode:sub(2)
	end
	local r_str, g_str, b_str = colorCode:sub(1, 2), colorCode:sub(3, 4), colorCode:sub(5, 6)
	local r = tonumber(r_str, 16) / 255
	local g = tonumber(g_str, 16) / 255
	local b = tonumber(b_str, 16) / 255
	return r, g, b
end

local theme_name = arg[1]
local main_subtable_name = arg[2]
local accent_subtable_name = arg[3]

if not theme_name or not main_subtable_name or not accent_subtable_name then
	print("Usage: colors.lua <theme_name> <main subtable name> <accent subtable name>")
	os.exit(1)
end

package.path = package.path .. ";lua/" .. theme_name .. "/?.lua"
local data = require("colors")

local main_color_table = data.main and data.main[main_subtable_name]
local accent_color_table = data.accent and data.accent[accent_subtable_name]

if not main_color_table or not accent_color_table then
	print("Invalid table or subtable names.")
	os.exit(1)
end

local color_entries = {}
local accent_mappings = {
	{ 1, "accent0" },
	{ 2, "accent3" },
	{ 3, "accent2" },
	{ 4, "accent5" },
	{ 5, "accent6" },
	{ 6, "accent4" },
}

local function addColorEntry(key, alpha, red, green, blue)
	local entry = string.format(
		[[
    <key>%s</key>
    <dict>
        <key>Alpha Component</key>
        <real>%.2f</real>
        <key>Red Component</key>
        <real>%.17f</real>
        <key>Green Component</key>
        <real>%.17f</real>
        <key>Blue Component</key>
        <real>%.17f</real>
        <key>Color Space</key>
        <string>sRGB</string>
    </dict>]],
		key,
		alpha,
		red,
		green,
		blue
	)
	table.insert(color_entries, entry)
end

function LightenDarkenColor(col, amt)
	col = tonumber(col, 16)
	local r = ((col >> 16) & 0xFF) * (1 + amt / 100)
	local g = ((col >> 8) & 0xFF) * (1 + amt / 100)
	local b = (col & 0xFF) * (1 + amt / 100)
	r = math.floor(math.min(255, math.max(0, r)) + 0.5)
	g = math.floor(math.min(255, math.max(0, g)) + 0.5)
	b = math.floor(math.min(255, math.max(0, b)) + 0.5)
	return string.format("#%02x%02x%02x", r, g, b)
end

-- foreground and background come from main palette..
local ansi0_r, ansi0_g, ansi0_b = colorToComponents(main_color_table.color0)
addColorEntry("Ansi " .. 0 .. " Color", 1, ansi0_r, ansi0_g, ansi0_b)

local ansi7_r, ansi7_g, ansi7_b = colorToComponents(main_color_table.color8)
addColorEntry("Ansi " .. 7 .. " Color", 1, ansi7_r, ansi7_g, ansi7_b)

-- normal colors come from accent palette..
for _, mapping in ipairs(accent_mappings) do
	local ansi_number, accent_name = table.unpack(mapping)
	local r, g, b = colorToComponents(accent_color_table[accent_name])
	addColorEntry("Ansi " .. ansi_number .. " Color", 1, r, g, b)
end

local brightening_amount = 20

-- bright colors come from accent palette, but are brightened by brighting_amount
for _, mapping in ipairs(accent_mappings) do
	local ansi_number, accent_name = table.unpack(mapping)
	local original_hex_color = accent_color_table[accent_name]
	local brightened_hex_color = LightenDarkenColor(original_hex_color:sub(2), brightening_amount)
	local r, g, b = colorToComponents(brightened_hex_color)
	addColorEntry("Ansi " .. ansi_number + 8 .. " Color", 1, r, g, b)
end

-- misc colors
local r, g, b
r, g, b = colorToComponents(main_color_table.color7)
addColorEntry("Foreground Color", 1, r, g, b)

r, g, b = colorToComponents(main_color_table.color0)
addColorEntry("Background Color", 1, r, g, b)

r, g, b = colorToComponents(main_color_table.color8)
addColorEntry("Bold Color", 1, r, g, b)

r, g, b = colorToComponents(main_color_table.color7)
addColorEntry("Cursor Color", 1, r, g, b)

r, g, b = colorToComponents(main_color_table.color1)
addColorEntry("Cursor Guide Color", 1, r, g, b)

r, g, b = colorToComponents(main_color_table.color7)
addColorEntry("Cursor Text Color", 1, r, g, b)

r, g, b = colorToComponents(accent_color_table.accent5)
addColorEntry("Link Color", 1, r, g, b)

r, g, b = colorToComponents(main_color_table.color0)
addColorEntry("Selected Text Color", 1, r, g, b)

r, g, b = colorToComponents(main_color_table.color7)
addColorEntry("Selection Color", 1, r, g, b)

local xml_color_entries = table.concat(color_entries, "\n")
local xml_output = string.format(
	[[
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
%s
</dict>
</plist>
]],
	xml_color_entries
)

print(xml_output)
