-- merge all the highlight tables together into a single highlight table
local sub_dir = "highlights"
local highlights = {}

local module_path = debug.getinfo(1).source:match("@?(.*/)")
local command = "ls " .. module_path .. sub_dir .. "/*.lua"
local files = {}

for file in io.popen(command):lines() do
	table.insert(files, file)
end

-- Reverse iterate through the files.
for i = #files, 1, -1 do
	local table_from_file = loadfile(files[i])()
	if type(table_from_file) == "table" then
		for key, value in pairs(table_from_file) do
			highlights[key] = value
		end
	end
end

local custom_highlights = require("palette").get("custom_highlights") or {}

-- override the highlights with the custom highlights
for _, highlight in ipairs(custom_highlights) do
	table.insert(highlights, highlight)
end

return highlights
