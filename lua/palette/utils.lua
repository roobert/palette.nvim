M = {}

M.hex2rgb = function(hex)
	hex = hex:gsub("#", "")
	return {
		r = tonumber("0x" .. hex:sub(1, 2)) / 255,
		g = tonumber("0x" .. hex:sub(3, 4)) / 255,
		b = tonumber("0x" .. hex:sub(5, 6)) / 255,
	}
end

M.rgb2hex = function(rgb)
	return string.format("#%02x%02x%02x", rgb.r * 255, rgb.g * 255, rgb.b * 255)
end

M.rgb2hsl = function(rgb)
	local r, g, b = rgb.r, rgb.g, rgb.b
	local max, min = math.max(r, g, b), math.min(r, g, b)
	local h, s, l = (max + min) / 2, (max + min) / 2, (max + min) / 2

	if max == min then
		-- achromatic
		h, s = 0, 0
	else
		local delta = max - min
		s = l > 0.5 and delta / (2 - max - min) or delta / (max + min)
		if max == r then
			h = (g - b) / delta + (g < b and 6 or 0)
		elseif max == g then
			h = (b - r) / delta + 2
		elseif max == b then
			h = (r - g) / delta + 4
		end
		h = h / 6
	end

	return { h = h, s = s, l = l }
end

M.hsl2rgb = function(hsl)
	local r, g, b

	if hsl.s == 0 then
		-- achromatic
		r, g, b = hsl.l, hsl.l, hsl.l
	else
		local function hue2rgb(p, q, t)
			if t < 0 then
				t = t + 1
			end
			if t > 1 then
				t = t - 1
			end
			if t < 1 / 6 then
				return p + (q - p) * 6 * t
			end
			if t < 1 / 2 then
				return q
			end
			if t < 2 / 3 then
				return p + (q - p) * (2 / 3 - t) * 6
			end
			return p
		end

		local q = hsl.l < 0.5 and hsl.l * (1 + hsl.s) or hsl.l + hsl.s - hsl.l * hsl.s
		local p = 2 * hsl.l - q
		r = hue2rgb(p, q, hsl.h + 1 / 3)
		g = hue2rgb(p, q, hsl.h)
		b = hue2rgb(p, q, hsl.h - 1 / 3)
	end

	return { r = r, g = g, b = b }
end

function M.lighten(hex, percent)
	local hsl = M.rgb2hsl(M.hex2rgb(hex))
	local adjustment = percent / 100.0
	hsl.l = math.min(hsl.l + adjustment, 1)
	return M.rgb2hex(M.hsl2rgb(hsl))
end

function M.darken(hex, percent)
	local hsl = M.rgb2hsl(M.hex2rgb(hex))
	local adjustment = percent / 100.0
	hsl.l = math.max(hsl.l - adjustment, 0)
	return M.rgb2hex(M.hsl2rgb(hsl))
end

local function path_join(base, relative)
	if relative:sub(1, 1) == "/" then
		return relative
	end
	return base .. "/" .. relative
end

local bit = require("bit")

local function generate_cache_key(highlights)
	local serialized_highlights = vim.inspect(highlights)

	local hash = 5381
	for i = 1, #serialized_highlights do
		local char = string.byte(serialized_highlights, i)
		hash = bit.band(bit.bxor(hash * 33, char), 0xFFFFFFFF)
	end

	return tostring(hash)
end

local cache_dir = require("palette").get("cache_dir")

local function cache_path(cache_key)
	if vim.fn.isdirectory(cache_dir) == 0 then
		os.execute("mkdir -p " .. cache_dir)
	end

	local _cache_path = path_join(cache_dir, cache_key .. ".vim")

	if vim.fn.filereadable(_cache_path) == 1 then
		return _cache_path
	end

	return false
end

local function cache_save(cache, cache_key)
	local _cache_path = path_join(cache_dir, cache_key .. ".vim")
	local cache_file = io.open(_cache_path, "w")

	if cache_file then
		for _, cmd in pairs(cache) do
			cache_file:write(cmd .. "\n")
		end
		cache_file:close()
	else
		print("Error: colorscheme could not open cache file for writing: " .. _cache_path)
	end
end

-- map the lua highlight tables into vim highlight commands
M.apply_highlight_groups = function(highlights, caching)
	local cache_key = generate_cache_key(highlights)

	if vim.g.colors_name then
		vim.cmd("highlight clear")
	end

	-- load from cache and return, if cache file exists..
	if caching then
		local _cache_path = cache_path(cache_key)
		if _cache_path then
			print("LOADING CACHE: " .. _cache_path)
			vim.cmd("source " .. _cache_path)
			return
		end
	end

	local cache = {}
	for _, highlight in pairs(highlights) do
		local hlgroup = highlight[1]

		local guifg = highlight[2] and "guifg=" .. highlight[2] or "guifg=NONE"
		local guibg = highlight[3] and "guibg=" .. highlight[3] or "guibg=NONE"

		-- handle italic, bold, underline, etc.
		local gui = "gui="
		if highlight[4] then
			if type(highlight[4]) == "table" then
				-- Join the table of styles into a comma-separated string
				gui = gui .. table.concat(highlight[4], ",")
			else
				-- If it's a single string, just append it
				gui = gui .. highlight[4]
			end
		else
			gui = ""
		end

		local cmd = string.format("highlight %s %s %s %s", hlgroup, guifg, guibg, gui)
		table.insert(cache, cmd)
		vim.cmd(cmd)
	end

	cache_save(cache, cache_key)
end

return M
