---@alias Variant "main" | "aurora"
---@alias Palette { base: string, surface: string, overlay: string, muted: string, subtle: string, spectrum: string, proxy: string, whisper: string, biolink: string, bitdust: string, limewire: string, skyware: string, quantum: string, cipher: string, mint_dimmed: string, coral: string, peach: string, blush: string, glitch: string, aqua: string, amber: string, amber_dark: string, amber_ultra: string }
---@alias PaletteColor "base" | "surface" | "overlay" | "muted" | "subtle" | "whisper" | "spectrum" | "proxy" | "biolink" | "bitdust" | "limewire" | "skyware" | "quantum" | "cipher" | "mint_dimmed" | "coral" | "peach" | "blush" | "glitch" | "aqua" | "amber" | "amber_dark" | "amber_ultra" | "highlight_low" | "highlight_med" | "highlight_high"
---@alias Highlight { link: string, inherit: boolean } | { fg: string, bg: string, sp: string, bold: boolean, italic: boolean, undercurl: boolean, underline: boolean, underdouble: boolean, underdotted: boolean, underdashed: boolean, strikethrough: boolean, inherit: boolean }

local config = {}

---@class Options
config.options = {
	---Set the desired variant: "auto" will follow the vim background,
	---defaulting to "main" for dark and "aurora" for light.
	---@type "auto" | Variant
	variant = "auto",

	---Differentiate between active and inactive windows and panels.
	dim_inactive_windows = false,

	---Extend background behind borders. Appearance differs based on which
	---border characters you are using.
	extend_background_behind_borders = true,

	enable = {
		legacy_highlights = true,
		migrations = true,
		terminal = true,
	},

	styles = {
		bold = true,
		italic = true,
		transparency = false,
	},

	---@type table<string, string | PaletteColor>
	groups = {
		border = "muted",
		link = "quantum",
		panel = "surface",

		error = "blush",
		hint = "bitdust",
		info = "quantum",
		note = "coral",
		todo = "limewire",
		warn = "amber_dark",

		git_add = "skyware",
		git_change = "amber_dark",
		git_delete = "blush",
		git_dirty = "amber",
		git_ignore = "muted",
		git_merge = "quantum",
		git_rename = "cipher",
		git_stage = "bitdust",
		git_text = "glitch",
		git_untracked = "subtle",

		---@type string | PaletteColor
		h1 = "bitdust",
		h2 = "aqua",
		h3 = "glitch",
		h4 = "amber_dark",
		h5 = "coral",
		h6 = "mint_dimmed",

		---@deprecated Replaced by `options.highlight_groups["Normal"]`
		-- background = "base",
		---@deprecated Replaced by `options.highlight_groups["Comment"]`
		-- comment = "subtle",
		---@deprecated Replaced by `options.highlight_groups["@punctuation"]`
		-- punctuation = "muted",
		---@deprecated Expects a table with values h1...h6
		-- headings = "text",
	},

	---@type table<string, Highlight>
	highlight_groups = {},

	---Called before each highlight group, before setting the highlight.
	---@param group string
	---@param highlight Highlight
	---@param palette Palette
	---@diagnostic disable-next-line: unused-local
	before_highlight = function(group, highlight, palette) end,

	---@deprecated Replaced by `options.dim_inactive_windows`
	-- dim_nc_background = false,
	---@deprecated Replaced by `options.enable.transparency`
	-- disable_background = false,
	---@deprecated Replaced by `options.highlight_groups["NormalFloat"]`
	-- disable_float_background = false,
	---@deprecated Replaced by `options.styles.italic`
	-- disable_italics = false,
	---@deprecated Replaced by `options.highlight_groups`
	-- bold_vert_split = false
}

local function migrate(options)
	if options.bold_vert_split then
		local border = options.groups.border or "muted"
		options.highlight_groups["VertSplit"] = { fg = border, bg = border }
		options.highlight_groups["WinSeparator"] = { fg = border, bg = border }
	end

	if options.disable_background then
		options.highlight_groups["Normal"] = { bg = "NONE" }
	end

	if options.disable_float_background then
		options.highlight_groups["NormalFloat"] = { bg = "NONE" }
	end

	options.dim_inactive_windows = options.dim_nc_background or options.dim_inactive_windows

	if options.groups.background ~= nil then
		options.highlight_groups["Normal"] = { bg = options.groups.background }
	end

	if options.groups.comment ~= nil then
		options.highlight_groups["Comment"] = { fg = options.groups.comment }
	end

	if options.groups.punctuation ~= nil then
		options.highlight_groups["@punctuation"] = { fg = options.groups.punctuation }
	end

	options.styles.transparency = (options.disable_background and options.disable_float_background)
		or options.styles.transparency

	-- These never actually existed, but may be set intuitively by the user
	-- because of `disable_italics` existing.
	options.styles.bold = not (options.disable_bold or options.disable_bolds) and options.styles.bold or false

	-- Similar to bold options, `disable_italic` never existed but could be a
	-- common typo of the actual `disable_italics`.
	options.styles.italic = not (options.disable_italic or options.disable_italics) and options.styles.italic or false

	-- Set h1 through h6 to the same color if only one is specified
	if type(options.groups.headings) == "string" then
		options.groups.h1 = options.groups.headings
		options.groups.h2 = options.groups.headings
		options.groups.h3 = options.groups.headings
		options.groups.h4 = options.groups.headings
		options.groups.h5 = options.groups.headings
		options.groups.h6 = options.groups.headings
	elseif options.groups.headings == "table" then
		options.groups.h1 = options.groups.headings.h1 or options.groups.h1
		options.groups.h2 = options.groups.headings.h2 or options.groups.h2
		options.groups.h3 = options.groups.headings.h3 or options.groups.h3
		options.groups.h4 = options.groups.headings.h4 or options.groups.h4
		options.groups.h5 = options.groups.headings.h5 or options.groups.h5
		options.groups.h6 = options.groups.headings.h6 or options.groups.h6
	end
	options.groups.headings = nil

	return options
end

---@param options Options | nil
function config.extend_options(options)
	config.options = vim.tbl_deep_extend("force", config.options, options or {})

	if config.options.enable.migrations then
		config.options = migrate(config.options)
	end
end

return config
