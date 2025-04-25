--- @class Jack
local Jack = {
	config = JackConfig,
	palette = JackPalette,
}

--- @alias Contrast "hard" | "sorf" | ""
--- @alias Theme "tiger" |  ""
--- @class HighlightDefinition
--- @fg string?
--- @bg string?
--- @bold boolean?
--- @underline boolean?

--- @class JackConfig
--- @field overwrites table<string, HighlightDefinition>?
--- @field palette_overwrites table<string, string>?
--- @field contrast Contrast?
--- @field terminal_colors boolean?
JackConfig = {
	palette_overrides = {},
	contrast = "",
	terminal_colors = false,
}

JackPalette = {
	dark_hard = "#1d2021",
	light_hard = "#f9f5d7",
	gray = "#928374",
}

-- Theme: "tiger"

-- @class Tiger
-- @field get_colors function()
-- @field get_groups function()
local Tiger = {}

Tiger.get_colors = function()
	local p = Jack.palette
	local config = Jack.config

	for color, hex in pairs(config.palette_overrides) do
		p[color] = hex
	end
	local bg = vim.o.background
	local contrast = config.contrast

	local color_groups = {
		dark = {
			bg0 = p.dark_hard,
			bg1 = p.dark_hard,
			bg2 = p.dark_hard,
			bg3 = p.dark_hard,
			bg4 = p.dark_hard,
			fg0 = p.light_hard,
			fg1 = p.light_hard,
			fg2 = p.light_hard,
			fg3 = p.light_hard,
			fg4 = p.light_hard,
			dark_red = p.dark_hard,
			dark_green = p.dark_hard,
			dark_aqua = p.dark_hard,
			gray = p.gray,
			--[[ red = p.bright_red,
        green = p.bright_green,
        yellow = p.bright_yellow,
        blue = p.bright_blue,
        purple = p.bright_purple,
        aqua = p.bright_aqua,
        orange = p.bright_orange,
        neutral_red = p.neutral_red,
        neutral_green = p.neutral_green,
        neutral_yellow = p.neutral_yellow,
        neutral_blue = p.neutral_blue,
        neutral_purple = p.neutral_purple,
        neutral_aqua = p.neutral_aqua,
]]
		},
		light = {
			bg0 = p.light_hard,
			bg1 = p.light_hard,
			bg2 = p.light_hard,
			bg3 = p.light_hard,
			bg4 = p.light_hard,
			fg0 = p.dark_hard,
			fg1 = p.dark_hard,
			fg2 = p.dark_hard,
			fg3 = p.dark_hard,
			fg4 = p.dark_hard,
			dark_red = p.dark_hard,
			dark_green = p.dark_hard,
			dark_aqua = p.dark_hard,
			gray = p.gray,
		},
	}
	-- TODO: contrast manipulation
	if contrast ~= nil and contrast ~= "" then
		--[[ color_groups[bg].bg0 = p[bg .. "0_" .. contrast]
		color_groups[bg].dark_red = p[bg .. "_red_" .. contrast]
		color_groups[bg].dark_green = p[bg .. "_green_" .. contrast]
		color_groups[bg].dark_aqua = p[bg .. "_aqua_" .. contrast] ]]
	end
	return color_groups[bg]
end

Tiger.get_groups = function()
	local colors = Tiger.get_colors()
	local config = Jack.config

	if config.terminal_colors then
	end

	local groups = {}

	for group, hl in pairs(config.overwrites) do
		if groups[group] then
			groups[group].link = nil
		end
		groups[group] = vim.tbl_extend("force", groups[group] or {}, hl)
	end
	return groups
end

--- @param opts table<Theme>
Jack.load = function(opts)
	if vim.version().minor < 8 then
		vim.notify_once("jack.nvim: requires neovim version 0.8 or higher")
		return
	end

	if vim.g.colors_name then
		vim.cmd.hi("clear")
	end
	vim.g.colors_name = "jack"
	vim.o.termguicolors = true

	local theme = opts["_theme"]

	local groups = nil
	if theme ~= nil and theme == "tiger" then
		groups = Tiger.get_groups()
	end

	if groups == nil then
		vim.notify_once("jack.nvim: could not retrive groups")
		return
	end
	for group, settings in pairs(groups) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return Jack
