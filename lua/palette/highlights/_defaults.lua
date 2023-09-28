local m = require("palette.theme").main
local a = require("palette.theme").accent
local s = require("palette.theme").state

-- Exmaple mappings table entry:
-- { "<highlight>", "<fg>", "<bg>", "<style>" }
-- or for multiple styles:
-- { "<highlight>", "<fg>", "<bg>", {m.italic, "bold", "underline" } }
return {
	-- Default window, etc. bg = None is transparent..
	{ "Whitespace", m.color2 },
	{ "Normal", m.fg, m.bg },
	{ "NormalFloat", m.fg },
	{ "FloatBorder", m.color8, m.bg },
	{ "NotifyBackground", nil, m.bg },
	{ "NonText", m.fg },

	-- End of buffer: ~'s
	{ "EndOfBuffer", m.color3 },

	-- Special characters
	{ "Special", m.color3 },
	{ "SpecialChar", m.color3 },

	-- Preprocessor & Include
	{ "PreProc", m.color3 },
	{ "Include", m.color3 },

	-- Statements and Keywords
	{ "Statement", m.color3 },
	{ "Conditional", m.color3 },
	{ "Repeat", m.color3 },
	{ "Exception", m.color3 },
	{ "Directory", m.color3 },
	{ "Keyword", m.color3 },

	-- Operators and Delimiters
	{ "Operator", m.color4 },
	{ "Delimiter", m.color4 },

	-- Comments and Documentation
	{ "Comment", m.color6, nil, m.italic },
	{ "DocComment", m.color6, nil, m.italic },

	-- Identifiers
	{ "Identifier", m.color5 },
	{ "Variable", m.color6 },

	{ "Function", m.color7 },

	-- Strings
	{ "String", m.color8 },

	-- Variables
	{ "Type", m.color8, nil, "NONE" },
	{ "Label", a.accent0 },

	-- Constants and Literals
	{ "Character", a.accent0 },
	{ "Number", a.accent0 },
	{ "Boolean", a.accent4 },
	{ "Float", a.accent4 },
	{ "Constant", a.accent4 },

	-- Todo's etc.
	{ "Todo", m.color3, nil, m.italic },
	{ "Debug", m.color3, nil, m.italic },

	-- Status line, VertSplit, Tab pages, Titles, etc.
	{ "StatusLine", m.color1 },
	{ "StatusLineNC", m.color2 },
	{ "VertSplit", m.color3 },
	{ "TabLine", m.color3 },
	{ "TabLineSel", m.color5 },
	{ "TabLineFill", m.color6 },
	{ "Title", m.color8 },

	-- Visual Mode
	{ "Visual", a.accent1, m.color1 },
	{ "VisualNOS", m.color4, m.color1 },

	-- Line Numbers
	{ "LineNr", m.color3 },
	{ "CursorLineNr", m.color4 },

	-- Folded text, and the column where it's shown
	{ "Folded", m.color4, m.bg },
	{ "FoldColumn", m.color4, m.bg },

	-- Popup menu
	{ "Pmenu", m.color5, m.color1 },
	{ "PmenuSel", m.color5, m.color2 },
	--{ "PmenuSbar", a.accent0 },
	{ "PmenuThumb", nil, m.color8 },

	-- Spell checking
	{ "SpellBad", m.color3 },
	{ "SpellCap", m.color4 },
	{ "SpellRare", m.color5 },
	{ "SpellLocal", m.color6 },

	-- More UI elements
	{ "Cursor", m.color2 },
	{ "CursorColumn", m.color2 },
	{ "CursorLine", nil, m.color1 },
	{ "CursorLineFold", m.color2 },
	{ "CursorLineSign", m.color2 },
	{ "ToolbarLine", m.color3 },
	{ "ToolbarButton", m.color3 },

	-- UI Messages / prompts
	-- quit, etc.
	{ "MoreMsg", a.accent4 },
	-- input method (prompt)
	{ "CursorIM", a.accent4 },
	{ "Question", a.accent4 },
	{ "SpecialKey", a.accent0 },

	-- Search & Matches
	{ "MatchParen", a.accent3 },
	{ "Search", a.accent1 },
	{ "IncSearch", a.accent1, m.bg },

	-- Errors and Warnings
	{ "NvimInternalError", s.error, m.bg },
	{ "Error", s.error },
	{ "WarningMsg", s.warning },
	{ "ErrorMsg", s.error },

	-- Diagnostic
	{ "DiagnosticInfo", s.info, nil, m.italic },
	{ "DiagnosticHint", s.hint, nil, m.italic },
	{ "DiagnosticWarning", s.warning, nil, m.italic },
	{ "DiagnosticWarn", s.warning, nil, m.italic },
	{ "DiagnosticError", s.error, nil, m.italic },

	-- Indicators
	{ "LspDiagnosticsSignInformation", s.info, m.bg, m.italic },
	{ "LspDiagnosticsSignHint", s.hint, m.bg, m.italic },
	{ "LspDiagnosticsSignWarning", s.warning, m.bg, m.italic },
	{ "LspDiagnosticsSignError", s.error, m.bg, m.italic },

	-- Diff mode
	{ "DiffAdd", s.ok },
	{ "DiffChange", s.warning },
	{ "DiffDelete", s.error },
	{ "DiffText", s.info },

	-- SignColumn
	{ "SignColumn", nil, m.bg },
	{ "GitSignsAdd", s.ok, m.bg },
	{ "GitSignsChange", s.warning, m.bg },
	{ "GitSignsDelete", m.error, m.bg },
}
