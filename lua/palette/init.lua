M = {}

local config = {
	palettes = {
		main = "dark",
		accent = "pastel",
		state = "pastel",
	},

	custom_palettes = {
		main = {},
		accent = {},
		state = {},
	},

	italics = true,
	transparent_background = false,

	caching = true,
	cache_dir = vim.fn.stdpath("cache") .. "/palette",
}

M.setup = function(opts)
	config = vim.tbl_extend("force", config, opts)
end

M.get = function(key)
	return config[key]
end

function M.load()
	vim.g.colors_name = "palette"

	-- options
	vim.o.termguicolors = true
	vim.o.background = config.palettes.main == "light" and "light" or "dark"

	-- override border types for diagnostic floats
	vim.diagnostic.config({ float = { border = "rounded" } })

	-- get merged highlight groups
	local highlights = require("palette.highlights")

	-- load the colorscheme mappings
	require("palette.utils").apply_highlight_groups(highlights, config["caching"])
end

return M
