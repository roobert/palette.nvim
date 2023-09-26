#!/usr/bin/env lua

-- Extract the specified table and subsection based on command-line arguments
local theme_name = arg[1]
local table_name = arg[2]
local subsection_name = arg[3]

if not theme_name or not table_name or not subsection_name then
	print("Usage: colors.lua <theme_name> <palette name> <palette variant>")
	os.exit(1)
end

package.path = package.path .. ";lua/" .. theme_name .. "/?.lua"

local data = require("colors")

local function resetColor()
	print("\27[0m", "")
end

-- Function to print color as a block in terminal
local function printColorBlock(colorCode, label, blockWidth, mode)
	mode = mode or "block" -- default to block mode

	local r = tonumber(colorCode:sub(2, 3), 16)
	local g = tonumber(colorCode:sub(4, 5), 16)
	local b = tonumber(colorCode:sub(6, 7), 16)

	if mode == "block" then
		local escapeSequence = "\27[48;2;%d;%d;%dm" -- background color
		local brightness = r * 0.299 + g * 0.587 + b * 0.114

		local textColorR, textColorG, textColorB
		if brightness < 128 then
			textColorR, textColorG, textColorB = 255, 255, 255 -- white
		else
			textColorR, textColorG, textColorB = 0, 0, 0 -- black
		end

		local block = string.rep(" ", blockWidth)
		io.write(
			string.format(
				escapeSequence .. "\27[38;2;%d;%d;%dm%s %s ",
				r,
				g,
				b,
				textColorR,
				textColorG,
				textColorB,
				block,
				label
			)
		)
	elseif mode == "text" then
		local padding = string.rep(" ", blockWidth - #label)
		io.write(string.format("\27[38;2;%d;%d;%dm%s%s ", r, g, b, label, padding))
	end
end

local color_table = data[table_name] and data[table_name][subsection_name]

if not color_table then
	print("Invalid table or subsection name.")
	os.exit(1)
end

local sorted_keys = {}
for key in pairs(color_table) do
	table.insert(sorted_keys, key)
end
table.sort(sorted_keys)

print()
for _, key in ipairs(sorted_keys) do
	local value = color_table[key]
	printColorBlock(value, key, 7, "text")
end
resetColor()

for _, key in ipairs(sorted_keys) do
	local value = color_table[key]
	printColorBlock(value, "", 6, "block")
end
resetColor()

for _, key in ipairs(sorted_keys) do
	local value = color_table[key]
	printColorBlock(value, "", 6, "block")
end
resetColor()

for _, key in ipairs(sorted_keys) do
	local value = color_table[key]
	printColorBlock(value, "", 6, "block")
end
resetColor()
print()
