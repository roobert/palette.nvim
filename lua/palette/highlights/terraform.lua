local m = require("palette.theme").main

return {
	{ "@none.terraform", m.color3 },
	{ "@lsp.type.type.terraform", m.color3 },
	{ "@lsp.type.property.terraform", m.color4 },
	{ "@lsp.type.variable.terraform", m.color5 },
	{ "@lsp.type.enumMember.terraform", m.color8 },
	{ "@lsp.type.parameter.terraform", m.color8 },
	{ "@lsp.type.string.terraform", m.color8 },
	{ "@lsp.type.stringMember.terraform", m.color8 },
}
