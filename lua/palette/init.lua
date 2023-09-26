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
	vim.o.background = "dark"

	-- override border types for hover and diagnostic floats..
	vim.diagnostic.config({ float = { border = "rounded" } })

	local float = { focusable = true, style = "minimal", border = "rounded" }
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

	require("lspconfig.ui.windows").default_options.border = "single"

	-- get merged highlight groups
	local highlights = require("palette.highlights")

	-- load the colorscheme mappings
	require("palette.utils").apply_highlight_groups(highlights)
end

return M
