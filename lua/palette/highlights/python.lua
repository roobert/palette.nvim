local m = require("palette.theme").main
local a = require("palette.theme").accent

return {
	{ "@repeat.python", m.color3, nil, m.italic },
	{ "@conditional.python", m.color3, nil, m.italic },
	{ "@operator.python", m.color3 },
	{ "@conditional.call.python", m.color3 },
	{ "@punctuation.bracket.python", m.color3 },
	{ "@punctuation.special.python", m.color3 },
	{ "@function.builtin.python", m.color3 },

	{ "@keyword.operator.python", m.color4, nil, m.italic },
	{ "@method.call.python", m.color4 },
	{ "@function.python", m.color4 },
	{ "@function.call.python", m.color4 },
	{ "@type.python", m.color4 },

	{ "@constructor.python", m.color5 },
	{ "@field.python", m.color5 },

	{ "@variable.python", m.color6 },

	-- function arguments (keys)
	{ "@parameter.python", m.color7 },

	{ "@string.python", m.color8 },

	{ "@constant.builtin.python", a.accent4 },
}
