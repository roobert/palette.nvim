M = {}

-- merge user supplied custom main with main
local custom_main_colors = require("palette").get("custom_palettes")["main"] or {}
local all_main = vim.tbl_extend("force", require("palette.colors").main, custom_main_colors)

-- merge user supplied custom accent with accent
local custom_accent_colors = require("palette").get("custom_palettes")["accent"] or {}
local all_accent = vim.tbl_extend("force", require("palette.colors").accent, custom_accent_colors)

-- merge user supplied custom state with state
local custom_state_colors = require("palette").get("custom_palettes")["state"] or {}
local all_state = vim.tbl_extend("force", require("palette.colors").state, custom_state_colors)

-- default colors - these should be set in init.lua
local default_main = require("palette").get("palettes")["main"] or "dark"
local default_accent = require("palette").get("palettes")["accent"] or "pastel"
local default_state = require("palette").get("palettes")["state"] or "pastel"

-- select the main, state, and accent colors based off users config options..
M.main = all_main[require("palette").get("palettes")["main"]] or require("palette.colors").main[default_main]
M.accent = all_accent[require("palette").get("palettes")["accent"]] or require("palette.colors").accent[default_accent]
M.state = all_state[require("palette").get("palettes")["state"]] or require("palette.colors").state[default_state]

-- same for other options..
local italics = require("palette").get("italics") and "italic" or "NONE"
local transparent_background = require("palette").get("transparent_background") and "NONE" or M.main.color0

-- the derived main table
M.main["italic"] = italics
M.main["bg"] = transparent_background
M.main["fg"] = M.main.color8

return M
