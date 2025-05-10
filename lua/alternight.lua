local M = {}
local config = require("alternight.config")

local function set_highlights()
	local utilities = require("alternight.utilities")
	local palette = require("alternight.palette")
	local styles = config.options.styles

	local groups = {}
	for group, color in pairs(config.options.groups) do
		groups[group] = utilities.parse_color(color)
	end

	local function make_border(fg)
		fg = fg or groups.border
		return {
			fg = fg,
			bg = (config.options.extend_background_behind_borders and not styles.transparency) and palette.surface
				or "NONE",
		}
	end

	local highlights = {}
	local legacy_highlights = {
		["@attribute.diff"] = { fg = palette.coral },
		["@boolean"] = { link = "Boolean" },
		["@class"] = { fg = palette.peach },
		["@conditional"] = { link = "Conditional" },
		["@field"] = { fg = palette.quantum },
		["@include"] = { link = "Include" },
		["@interface"] = { fg = palette.skyware },
		["@macro"] = { link = "Macro" },
		["@method"] = { fg = palette.quantum },
		["@namespace"] = { link = "Include" },
		["@number"] = { link = "Number" },
		["@parameter"] = { fg = palette.skyware, italic = styles.italic },
		["@preproc"] = { link = "PreProc" },
		["@punctuation"] = { fg = palette.subtle },
		["@punctuation.bracket"] = { link = "@punctuation" },
		["@punctuation.delimiter"] = { link = "@punctuation" },
		["@punctuation.special"] = { link = "@punctuation" },
		["@regexp"] = { link = "String" },
		["@repeat"] = { link = "Repeat" },
		["@storageclass"] = { link = "StorageClass" },
		["@symbol"] = { link = "Identifier" },
		["@text"] = { fg = palette.spectrum },
		["@text.danger"] = { fg = groups.error },
		["@text.diff.add"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		["@text.diff.delete"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		["@text.emphasis"] = { italic = styles.italic },
		["@text.environment"] = { link = "Macro" },
		["@text.environment.name"] = { link = "Type" },
		["@text.math"] = { link = "Special" },
		["@text.note"] = { link = "SpecialComment" },
		["@text.strike"] = { strikethrough = true },
		["@text.strong"] = { bold = styles.bold },
		["@text.title"] = { link = "Title" },
		["@text.title.1.markdown"] = { link = "markdownH1" },
		["@text.title.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@text.title.2.markdown"] = { link = "markdownH2" },
		["@text.title.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@text.title.3.markdown"] = { link = "markdownH3" },
		["@text.title.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@text.title.4.markdown"] = { link = "markdownH4" },
		["@text.title.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@text.title.5.markdown"] = { link = "markdownH5" },
		["@text.title.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@text.title.6.markdown"] = { link = "markdownH6" },
		["@text.title.6.marker.markdown"] = { link = "markdownH6Delimiter" },
		["@text.underline"] = { underline = true },
		["@text.uri"] = { fg = groups.link },
		["@text.warning"] = { fg = groups.warn },
		["@todo"] = { link = "Todo" },

		-- lukas-reineke/indent-blankline.nvim
		IndentBlanklineChar = { fg = palette.whisper, nocombine = true },
		IndentBlanklineSpaceChar = { fg = palette.whisper, nocombine = true },
		IndentBlanklineSpaceCharBlankline = { fg = palette.whisper, nocombine = true },
	}
	local default_highlights = {
		ColorColumn = { bg = palette.surface },
		Conceal = { bg = "NONE" },
		CurSearch = { fg = palette.base, bg = palette.proxy, bold = styles.bold },
		Cursor = { fg = palette.base, bg = palette.proxy },
		CursorColumn = { bg = palette.overlay },
		-- CursorIM = {},
		CursorLine = { bg = palette.overlay },
		CursorLineNr = { fg = palette.spectrum, bold = styles.bold },
		-- DarkenedPanel = { },
		-- DarkenedStatusline = {},
		DiffAdd = { bg = groups.git_add, blend = 20 },
		DiffChange = { bg = groups.git_change, blend = 20 },
		DiffDelete = { bg = groups.git_delete, blend = 20 },
		DiffText = { bg = groups.git_text, blend = 20 },
		diffAdded = { link = "DiffAdd" },
		diffChanged = { link = "DiffChange" },
		diffRemoved = { link = "DiffDelete" },
		Directory = { fg = palette.glitch, bold = styles.bold },
		-- EndOfBuffer = {},
		ErrorMsg = { fg = groups.error, bold = styles.bold },
		FloatBorder = make_border(),
		FloatTitle = { link = "Directory" },
		FoldColumn = { fg = palette.muted },
		Folded = { fg = palette.spectrum, bg = groups.panel },
		IncSearch = { link = "CurSearch" },
		LineNr = { fg = palette.muted },
		MatchParen = { fg = palette.proxy, bg = palette.base, blend = 25 },
		ModeMsg = { fg = palette.subtle },
		MoreMsg = { fg = palette.amber },
		NonText = { fg = palette.muted },
		Normal = { fg = palette.spectrum, bg = palette.base },
		NormalFloat = { bg = groups.panel },
		NormalNC = { fg = palette.spectrum, bg = config.options.dim_inactive_windows and palette._nc or palette.base },
		NvimInternalError = { link = "ErrorMsg" },
		Pmenu = { fg = palette.subtle, bg = groups.panel },
		PmenuExtra = { fg = palette.muted, bg = groups.panel },
		PmenuExtraSel = { fg = palette.subtle, bg = palette.overlay },
		PmenuKind = { fg = palette.glitch, bg = groups.panel },
		PmenuKindSel = { fg = palette.subtle, bg = palette.overlay },
		PmenuSbar = { bg = groups.panel },
		PmenuSel = { fg = palette.spectrum, bg = palette.overlay },
		PmenuThumb = { bg = palette.muted },
		Question = { fg = palette.amber_dark },
		-- QuickFixLink = {},
		-- RedrawDebugNormal = {},
		RedrawDebugClear = { fg = palette.base, bg = palette.mint_dimmed },
		RedrawDebugComposed = { fg = palette.base, bg = palette.coral },
		RedrawDebugRecompose = { fg = palette.base, bg = palette.blush },
		Search = { fg = palette.base, bg = palette.spectrum },
		SignColumn = { fg = palette.spectrum, bg = "NONE" },
		SpecialKey = { fg = palette.bitdust },
		SpellBad = { sp = palette.subtle, undercurl = true },
		SpellCap = { sp = palette.subtle, undercurl = true },
		SpellLocal = { sp = palette.subtle, undercurl = true },
		SpellRare = { sp = palette.subtle, undercurl = true },
		StatusLine = { fg = palette.subtle, bg = groups.panel },
		StatusLineNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
		StatusLineTerm = { fg = palette.base, bg = palette.proxy },
		StatusLineTermNC = { fg = palette.base, bg = palette.proxy, blend = 60 },
		Substitute = { link = "IncSearch" },
		TabLine = { fg = palette.subtle, bg = groups.panel },
		TabLineFill = { bg = groups.panel },
		TabLineSel = { fg = palette.spectrum, bg = palette.overlay, bold = styles.bold },
		Title = { fg = palette.coral, bold = styles.bold },
		VertSplit = { fg = groups.border },
		Visual = { bg = palette.highlight_med },
		-- VisualNOS = {},
		WarningMsg = { fg = groups.warn, bold = styles.bold },
		-- Whitespace = {},
		WildMenu = { link = "IncSearch" },
		WinBar = { fg = palette.subtle, bg = groups.panel },
		WinBarNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
		WinSeparator = { fg = groups.border },

		DiagnosticError = { fg = groups.error },
		DiagnosticHint = { fg = groups.hint },
		DiagnosticInfo = { fg = groups.info },
		DiagnosticWarn = { fg = groups.warn },
		DiagnosticDefaultError = { link = "DiagnosticError" },
		DiagnosticDefaultHint = { link = "DiagnosticHint" },
		DiagnosticDefaultInfo = { link = "DiagnosticInfo" },
		DiagnosticDefaultWarn = { link = "DiagnosticWarn" },
		DiagnosticFloatingError = { link = "DiagnosticError" },
		DiagnosticFloatingHint = { link = "DiagnosticHint" },
		DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
		DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
		DiagnosticSignError = { link = "DiagnosticError" },
		DiagnosticSignHint = { link = "DiagnosticHint" },
		DiagnosticSignInfo = { link = "DiagnosticInfo" },
		DiagnosticSignWarn = { link = "DiagnosticWarn" },
		DiagnosticUnderlineError = { sp = groups.error, undercurl = true },
		DiagnosticUnderlineHint = { sp = groups.hint, undercurl = true },
		DiagnosticUnderlineInfo = { sp = groups.info, undercurl = true },
		DiagnosticUnderlineWarn = { sp = groups.warn, undercurl = true },
		DiagnosticVirtualTextError = { fg = groups.error, bg = groups.error, blend = 10 },
		DiagnosticVirtualTextHint = { fg = groups.hint, bg = groups.hint, blend = 10 },
		DiagnosticVirtualTextInfo = { fg = groups.info, bg = groups.info, blend = 10 },
		DiagnosticVirtualTextWarn = { fg = groups.warn, bg = groups.warn, blend = 10 },

		Boolean = { fg = palette.skyware },
		Character = { fg = palette.mint_dimmed },
		Comment = { fg = palette.whisper, italic = styles.italic },
		Conditional = { fg = palette.biolink },
		Constant = { fg = palette.glitch },
		Debug = { fg = palette.glitch },
		Define = { fg = palette.bitdust },
		Delimiter = { fg = palette.subtle },
		Error = { fg = palette.blush },
		Exception = { fg = palette.peach },
		Float = { fg = palette.amber_ultra },
		Function = { fg = palette.glitch },
		Identifier = { fg = palette.spectrum },
		Include = { fg = palette.bitdust },
		Keyword = { fg = palette.bitdust },
		Label = { fg = palette.amber },
		LspCodeLens = { fg = palette.subtle },
		LspCodeLensSeparator = { fg = palette.muted },
		LspInlayHint = { fg = palette.muted, bg = palette.muted, blend = 10 },
		LspReferenceRead = { bg = palette.highlight_med },
		LspReferenceText = { bg = palette.highlight_med },
		LspReferenceWrite = { bg = palette.highlight_med },
		Macro = { fg = palette.bitdust },
		Number = { fg = palette.amber_ultra },
		Operator = { fg = palette.spectrum },
		PreCondit = { fg = palette.biolink },
		PreProc = { link = "PreCondit" },
		Repeat = { fg = palette.coral },
		Special = { fg = palette.peach },
		SpecialChar = { link = "Special" },
		SpecialComment = { fg = palette.muted },
		Statement = { fg = palette.coral, bold = styles.bold },
		StorageClass = { fg = palette.peach },
		String = { fg = palette.cipher },
		Structure = { fg = palette.mint_dimmed },
		Tag = { fg = palette.skyware },
		Todo = { fg = palette.base, bg = palette.proxy, blend = 20 },
		Type = { fg = palette.limewire },
		TypeDef = { link = "Type" },
		Underlined = { fg = palette.glitch, underline = true },

		healthError = { fg = groups.error },
		healthSuccess = { fg = groups.info },
		healthWarning = { fg = groups.warn },

		htmlArg = { fg = palette.bitdust },
		htmlBold = { bold = styles.bold },
		htmlEndTag = { fg = palette.subtle },
		htmlH1 = { link = "markdownH1" },
		htmlH2 = { link = "markdownH2" },
		htmlH3 = { link = "markdownH3" },
		htmlH4 = { link = "markdownH4" },
		htmlH5 = { link = "markdownH5" },
		htmlItalic = { italic = styles.italic },
		htmlLink = { link = "markdownUrl" },
		htmlTag = { fg = palette.subtle },
		htmlTagN = { fg = palette.spectrum },
		htmlTagName = { fg = palette.coral },

		markdownDelimiter = { fg = palette.subtle },
		markdownH1 = { fg = groups.h1, bold = styles.bold },
		markdownH1Delimiter = { link = "markdownH1" },
		markdownH2 = { fg = groups.h2, bold = styles.bold },
		markdownH2Delimiter = { link = "markdownH2" },
		markdownH3 = { fg = groups.h3, bold = styles.bold },
		markdownH3Delimiter = { link = "markdownH3" },
		markdownH4 = { fg = groups.h4, bold = styles.bold },
		markdownH4Delimiter = { link = "markdownH4" },
		markdownH5 = { fg = groups.h5, bold = styles.bold },
		markdownH5Delimiter = { link = "markdownH5" },
		markdownH6 = { fg = groups.h6, bold = styles.bold },
		markdownH6Delimiter = { link = "markdownH6" },
		markdownLinkText = { link = "markdownUrl" },
		markdownUrl = { fg = groups.link, sp = groups.link, underline = true },

		mkdCode = { fg = palette.coral },
		mkdCodeDelimiter = { fg = palette.glitch },
		mkdCodeEnd = { fg = palette.coral },
		mkdCodeStart = { fg = palette.coral },
		mkdFootnotes = { fg = palette.coral },
		mkdID = { fg = palette.coral, underline = true },
		mkdInlineURL = { link = "markdownUrl" },
		mkdLink = { link = "markdownUrl" },
		mkdLinkDef = { link = "markdownUrl" },
		mkdListItemLine = { fg = palette.spectrum },
		mkdRule = { fg = palette.subtle },
		mkdURL = { link = "markdownUrl" },

		--- Identifiers
		["@variable"] = { fg = palette.glitch },
		["@variable.builtin"] = { fg = palette.peach, bold = styles.bold },
		["@variable.parameter"] = { fg = palette.skyware, italic = styles.italic },
		["@variable.member"] = { fg = palette.quantum },

		["@constant"] = { fg = palette.blush },
		["@constant.builtin"] = { fg = palette.blush, bold = styles.bold },
		["@constant.macro"] = { fg = palette.blush },

		["@module"] = { fg = palette.spectrum },
		["@module.builtin"] = { fg = palette.spectrum, bold = styles.bold },
		["@label"] = { link = "Label" },

		--- Literals
		["@string"] = { link = "String" },
		-- ["@string.documentation"] = {},
		["@string.regexp"] = { fg = palette.bitdust },
		["@string.escape"] = { fg = palette.mint_dimmed },
		["@string.special"] = { link = "String" },
		["@string.special.symbol"] = { link = "Identifier" },
		["@string.special.url"] = { fg = groups.link },
		-- ["@string.special.path"] = {},

		["@character"] = { link = "Character" },
		["@character.special"] = { link = "Character" },

		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Number" },
		["@float"] = { link = "Number" },

		--- Types
		["@type"] = { fg = palette.limewire },
		["@type.builtin"] = { fg = palette.limewire, bold = styles.bold },
		-- ["@type.definition"] = {},
		-- ["@type.qualifier"] = {},

		-- ["@attribute"] = {},
		["@property"] = { fg = palette.quantum },

		--- Functions
		["@function"] = { fg = palette.amber },
		["@function.builtin"] = { fg = palette.amber },
		-- ["@function.call"] = {},
		["@function.macro"] = { link = "Function" },
		["@function.method"] = { fg = palette.glitch },
		["@function.method.call"] = { fg = palette.bitdust },

		["@constructor"] = { fg = palette.peach, italic = styles.italic },
		["@operator"] = { link = "Operator" },

		--- Keywords
		["@keyword"] = { link = "Keyword" },
		-- ["@keyword.coroutine"] = {},
		-- ["@keyword.function"] = {},
		["@keyword.as"] = { fg = palette.bitdust },
		["@keyword.class"] = { fg = palette.bitdust },
		["@keyword.conditional"] = { fg = palette.biolink },
		["@keyword.conditional.case"] = { fg = palette.biolink },
		["@keyword.conditional.default"] = { fg = palette.biolink },
		["@keyword.conditional.else"] = { fg = palette.biolink },
		["@keyword.conditional.elseif"] = { fg = palette.biolink },
		["@keyword.conditional.if"] = { fg = palette.biolink },
		["@keyword.conditional.switch"] = { fg = palette.biolink },
		["@keyword.conditional.ternary"] = { fg = palette.biolink },
		["@keyword.debug"] = { fg = palette.bitdust },
		["@keyword.directive"] = { fg = palette.bitdust },
		["@keyword.directive.define"] = { fg = palette.bitdust },
		["@keyword.directive.export"] = { fg = palette.bitdust },
		["@keyword.directive.import"] = { fg = palette.bitdust },
		["@keyword.directive.include"] = { fg = palette.bitdust },
		["@keyword.directive.pragma"] = { fg = palette.bitdust },
		["@keyword.exception"] = { fg = palette.bitdust },
		["@keyword.export"] = { fg = palette.bitdust },
		["@keyword.from"] = { fg = palette.bitdust },
		["@keyword.import"] = { fg = palette.bitdust },
		["@keyword.namespace"] = { fg = palette.bitdust },
		["@keyword.operator"] = { fg = palette.spectrum },
		["@keyword.repeat"] = { fg = palette.bitdust },
		["@keyword.return"] = { fg = palette.bitdust },
		["@keyword.storage"] = { fg = palette.bitdust },
		["@keyword.return"] = { fg = palette.bitdust },
		["@keyword.this"] = { fg = palette.bitdust },
		["@keyword.throw"] = { fg = palette.bitdust },
		["@keyword.type"] = { fg = palette.bitdust },
		["@keyword.var"] = { fg = palette.bitdust },
		-- ["@keyword.directive.unused"] = { fg = palette.bitdust },
		-- ["@keyword.directive.unused.import"] = { fg = palette.bitdust },
		-- ["@keyword.directive.unused.export"] = { fg = palette.bitdust },
		-- ["@keyword.directive.unused.include"] = { fg = palette.bitdust },

		--- Punctuation
		["@punctuation.delimiter"] = { fg = palette.spectrum },
		["@punctuation.bracket"] = { fg = palette.spectrum },
		["@punctuation.special"] = { fg = palette.spectrum },

		--- Comments
		["@comment"] = { link = "Comment" },
		-- ["@comment.documentation"] = {},

		["@comment.error"] = { fg = groups.error },
		["@comment.warning"] = { fg = groups.warn },
		["@comment.todo"] = { fg = groups.todo, bg = groups.todo, blend = 20 },
		["@comment.hint"] = { fg = groups.hint, bg = groups.hint, blend = 20 },
		["@comment.info"] = { fg = groups.info, bg = groups.info, blend = 20 },
		["@comment.note"] = { fg = groups.note, bg = groups.note, blend = 20 },

		--- Markup
		["@markup.strong"] = { bold = styles.bold },
		["@markup.italic"] = { italic = styles.italic },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },

		["@markup.heading"] = { fg = palette.skyware, bold = styles.bold },

		["@markup.quote"] = { fg = palette.subtle },
		["@markup.math"] = { link = "Special" },
		["@markup.environment"] = { link = "Macro" },
		["@markup.environment.name"] = { link = "@type" },

		-- ["@markup.link"] = {},
		["@markup.link.markdown_inline"] = { fg = palette.subtle },
		["@markup.link.label.markdown_inline"] = { fg = palette.quantum },
		["@markup.link.url"] = { fg = groups.link },

		-- ["@markup.raw"] = { bg = palette.surface },
		-- ["@markup.raw.block"] = { bg = palette.surface },
		["@markup.raw.delimiter.markdown"] = { fg = palette.subtle },

		["@markup.list"] = { fg = palette.spectrum },
		["@markup.list.checked"] = { fg = palette.quantum, bg = palette.quantum, blend = 10 },
		["@markup.list.unchecked"] = { fg = palette.spectrum },

		-- Markdown headings
		["@markup.heading.1.markdown"] = { link = "markdownH1" },
		["@markup.heading.2.markdown"] = { link = "markdownH2" },
		["@markup.heading.3.markdown"] = { link = "markdownH3" },
		["@markup.heading.4.markdown"] = { link = "markdownH4" },
		["@markup.heading.5.markdown"] = { link = "markdownH5" },
		["@markup.heading.6.markdown"] = { link = "markdownH6" },
		["@markup.heading.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@markup.heading.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@markup.heading.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@markup.heading.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@markup.heading.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@markup.heading.6.marker.markdown"] = { link = "markdownH6Delimiter" },

		["@diff.plus"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		["@diff.minus"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		["@diff.delta"] = { bg = groups.git_change, blend = 20 },

		["@tag"] = { link = "Tag" },
		["@tag.attribute"] = { fg = palette.bitdust },
		["@tag.delimiter"] = { fg = palette.subtle },

		--- Non-highlighting captures
		-- ["@none"] = {},
		["@conceal"] = { link = "Conceal" },
		["@conceal.markdown"] = { fg = palette.subtle },

		-- ["@spell"] = {},
		-- ["@nospell"] = {},

		--- Semantic
		["@lsp.type.comment"] = {},
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.interface"] = { link = "@interface" },
		["@lsp.type.keyword"] = { link = "@keyword" },
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.namespace.python"] = { link = "@variable" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.variable"] = {}, -- defer to treesitter for regular variables
		["@lsp.type.variable.svelte"] = { link = "@variable" },
		["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.operator.injected"] = { link = "@operator" },
		["@lsp.typemod.string.injected"] = { link = "@string" },
		["@lsp.typemod.variable.constant"] = { link = "@constant" },
		["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
		["@lsp.typemod.variable.injected"] = { link = "@variable" },

		--- Plugins
		-- romgrk/barbar.nvim
		BufferCurrent = { fg = palette.spectrum, bg = palette.overlay },
		BufferCurrentIndex = { fg = palette.spectrum, bg = palette.overlay },
		BufferCurrentMod = { fg = palette.glitch, bg = palette.overlay },
		BufferCurrentSign = { fg = palette.subtle, bg = palette.overlay },
		BufferCurrentTarget = { fg = palette.amber_dark, bg = palette.overlay },
		BufferInactive = { fg = palette.subtle },
		BufferInactiveIndex = { fg = palette.subtle },
		BufferInactiveMod = { fg = palette.amber },
		BufferInactiveSign = { fg = palette.muted },
		BufferInactiveTarget = { fg = palette.amber_dark },
		BufferTabpageFill = { fg = "NONE", bg = "NONE" },
		BufferVisible = { fg = palette.subtle },
		BufferVisibleIndex = { fg = palette.subtle },
		BufferVisibleMod = { fg = palette.glitch },
		BufferVisibleSign = { fg = palette.muted },
		BufferVisibleTarget = { fg = palette.amber_dark },

		-- lewis6991/gitsigns.nvim
		GitSignsAdd = { link = "SignAdd" },
		GitSignsChange = { link = "SignChange" },
		GitSignsDelete = { link = "SignDelete" },
		SignAdd = { fg = groups.git_add, bg = "NONE" },
		SignChange = { fg = groups.git_change, bg = "NONE" },
		SignDelete = { fg = groups.git_delete, bg = "NONE" },

		-- mvllow/modes.nvim
		ModesCopy = { bg = palette.amber_dark },
		ModesDelete = { bg = palette.blush },
		ModesInsert = { bg = palette.proxy },
		ModesReplace = { bg = palette.biolink },
		ModesVisual = { bg = palette.bitdust },

		-- kyazdani42/nvim-tree.lua
		NvimTreeEmptyFolderName = { fg = palette.muted },
		NvimTreeFileDeleted = { fg = groups.git_delete },
		NvimTreeFileDirty = { fg = groups.git_dirty },
		NvimTreeFileMerge = { fg = groups.git_merge },
		NvimTreeFileNew = { fg = palette.amber },
		NvimTreeFileRenamed = { fg = groups.git_rename },
		NvimTreeFileStaged = { fg = groups.git_stage },
		NvimTreeFolderIcon = { fg = palette.subtle },
		NvimTreeFolderName = { fg = palette.amber_dark },
		NvimTreeGitDeleted = { fg = groups.git_delete },
		NvimTreeGitDirty = { fg = groups.git_dirty },
		NvimTreeGitIgnored = { fg = groups.git_ignore },
		NvimTreeGitMerge = { fg = groups.git_merge },
		NvimTreeGitNew = { fg = groups.git_add },
		NvimTreeGitRenamed = { fg = groups.git_rename },
		NvimTreeGitStaged = { fg = groups.git_stage },
		NvimTreeImageFile = { fg = palette.spectrum },
		NvimTreeNormal = { link = "Normal" },
		NvimTreeOpenedFile = { fg = palette.spectrum, bg = palette.overlay },
		NvimTreeOpenedFolderName = { link = "NvimTreeFolderName" },
		NvimTreeRootFolder = { fg = palette.skyware, bold = styles.bold },
		NvimTreeSpecialFile = { link = "NvimTreeNormal" },
		NvimTreeWindowPicker = { link = "StatusLineTerm" },

		-- nvim-neotest/neotest
		NeotestAdapterName = { fg = palette.bitdust },
		NeotestBorder = { fg = palette.highlight_med },
		NeotestDir = { fg = palette.skyware },
		NeotestExpandMarker = { fg = palette.highlight_med },
		NeotestFailed = { fg = palette.blush },
		NeotestFile = { fg = palette.spectrum },
		NeotestFocused = { fg = palette.amber_dark, bg = palette.highlight_med },
		NeotestIndent = { fg = "" },
		NeotestMarked = { fg = palette.glitch, bold = styles.bold },
		NeotestNamespace = { fg = palette.amber_dark },
		NeotestPassed = { fg = palette.cipher },
		NeotestRunning = { fg = palette.amber_dark },
		NeotestWinSelect = { fg = palette.muted },
		NeotestSkipped = { fg = palette.subtle },
		NeotestTarget = { fg = palette.blush },
		NeotestTest = { fg = palette.amber_dark },
		NeotestUnknown = { fg = palette.subtle },
		NeotestWatching = { fg = palette.bitdust },

		-- nvim-neo-tree/neo-tree.nvim
		NeoTreeGitAdded = { fg = groups.git_add },
		NeoTreeGitConflict = { fg = groups.git_merge },
		NeoTreeGitDeleted = { fg = groups.git_delete },
		NeoTreeGitIgnored = { fg = groups.git_ignore },
		NeoTreeGitModified = { fg = groups.git_dirty },
		NeoTreeGitRenamed = { fg = groups.git_rename },
		NeoTreeGitUntracked = { fg = groups.git_untracked },
		NeoTreeTitleBar = { link = "StatusLineTerm" },

		-- folke/flash.nvim
		FlashLabel = { fg = palette.base, bg = palette.blush },

		-- folke/which-key.nvim
		WhichKey = { fg = palette.bitdust },
		WhichKeyDesc = { fg = palette.amber_dark },
		WhichKeyFloat = { bg = groups.panel },
		WhichKeyGroup = { fg = palette.skyware },
		WhichKeySeparator = { fg = palette.subtle },
		WhichKeyValue = { fg = palette.glitch },

		-- lukas-reineke/indent-blankline.nvim
		IblIndent = { fg = palette.overlay },
		IblScope = { fg = palette.skyware },
		IblWhitespace = { fg = palette.overlay },

		-- hrsh7th/nvim-cmp
		CmpItemAbbr = { fg = palette.subtle },
		CmpItemAbbrDeprecated = { fg = palette.subtle, strikethrough = true },
		CmpItemAbbrMatch = { fg = palette.spectrum, bold = styles.bold },
		CmpItemAbbrMatchFuzzy = { fg = palette.spectrum, bold = styles.bold },
		CmpItemKind = { fg = palette.subtle },
		CmpItemKindClass = { link = "StorageClass" },
		CmpItemKindFunction = { link = "Function" },
		CmpItemKindInterface = { link = "Type" },
		CmpItemKindMethod = { link = "PreProc" },
		CmpItemKindSnippet = { link = "String" },
		CmpItemKindVariable = { link = "Identifier" },

		-- NeogitOrg/neogit
		-- https://github.com/NeogitOrg/neogit/blob/master/lua/neogit/lib/hl.lua#L109-L198
		NeogitChangeAdded = { fg = groups.git_add, bold = styles.bold, italic = styles.italic },
		NeogitChangeBothModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitChangeCopied = { fg = groups.git_untracked, bold = styles.bold, italic = styles.italic },
		NeogitChangeDeleted = { fg = groups.git_delete, bold = styles.bold, italic = styles.italic },
		NeogitChangeModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitChangeNewFile = { fg = groups.git_stage, bold = styles.bold, italic = styles.italic },
		NeogitChangeRenamed = { fg = groups.git_rename, bold = styles.bold, italic = styles.italic },
		NeogitChangeUpdated = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitDiffAddHighlight = { link = "DiffAdd" },
		NeogitDiffContextHighlight = { bg = palette.surface },
		NeogitDiffDeleteHighlight = { link = "DiffDelete" },
		NeogitFilePath = { fg = palette.skyware, italic = styles.italic },
		NeogitHunkHeader = { bg = groups.panel },
		NeogitHunkHeaderHighlight = { bg = groups.panel },

		-- vimwiki/vimwiki
		VimwikiHR = { fg = palette.subtle },
		VimwikiHeader1 = { link = "markdownH1" },
		VimwikiHeader2 = { link = "markdownH2" },
		VimwikiHeader3 = { link = "markdownH3" },
		VimwikiHeader4 = { link = "markdownH4" },
		VimwikiHeader5 = { link = "markdownH5" },
		VimwikiHeader6 = { link = "markdownH6" },
		VimwikiHeaderChar = { fg = palette.subtle },
		VimwikiLink = { link = "markdownUrl" },
		VimwikiList = { fg = palette.bitdust },
		VimwikiNoExistsLink = { fg = palette.blush },

		-- nvim-neorg/neorg
		NeorgHeading1Prefix = { link = "markdownH1Delimiter" },
		NeorgHeading1Title = { link = "markdownH1" },
		NeorgHeading2Prefix = { link = "markdownH2Delimiter" },
		NeorgHeading2Title = { link = "markdownH2" },
		NeorgHeading3Prefix = { link = "markdownH3Delimiter" },
		NeorgHeading3Title = { link = "markdownH3" },
		NeorgHeading4Prefix = { link = "markdownH4Delimiter" },
		NeorgHeading4Title = { link = "markdownH4" },
		NeorgHeading5Prefix = { link = "markdownH5Delimiter" },
		NeorgHeading5Title = { link = "markdownH5" },
		NeorgHeading6Prefix = { link = "markdownH6Delimiter" },
		NeorgHeading6Title = { link = "markdownH6" },
		NeorgMarkerTitle = { fg = palette.skyware, bold = styles.bold },

		-- tami5/lspsaga.nvim (fork of glepnir/lspsaga.nvim)
		DefinitionCount = { fg = palette.glitch },
		DefinitionIcon = { fg = palette.glitch },
		DefinitionPreviewTitle = { fg = palette.glitch, bold = styles.bold },
		LspFloatWinBorder = make_border(),
		LspFloatWinNormal = { bg = groups.panel },
		LspSagaAutoPreview = { fg = palette.subtle },
		LspSagaCodeActionBorder = make_border(palette.glitch),
		LspSagaCodeActionContent = { fg = palette.skyware },
		LspSagaCodeActionTitle = { fg = palette.amber_dark, bold = styles.bold },
		LspSagaCodeActionTruncateLine = { link = "LspSagaCodeActionBorder" },
		LspSagaDefPreviewBorder = make_border(),
		LspSagaDiagnosticBorder = make_border(palette.amber_dark),
		LspSagaDiagnosticHeader = { fg = palette.skyware, bold = styles.bold },
		LspSagaDiagnosticTruncateLine = { link = "LspSagaDiagnosticBorder" },
		LspSagaDocTruncateLine = { link = "LspSagaHoverBorder" },
		LspSagaFinderSelection = { fg = palette.amber_dark },
		LspSagaHoverBorder = { link = "LspFloatWinBorder" },
		LspSagaLspFinderBorder = { link = "LspFloatWinBorder" },
		LspSagaRenameBorder = make_border(palette.bitdust),
		LspSagaRenamePromptPrefix = { fg = palette.blush },
		LspSagaShTruncateLine = { link = "LspSagaSignatureHelpBorder" },
		LspSagaSignatureHelpBorder = make_border(palette.skyware),
		ReferencesCount = { fg = palette.glitch },
		ReferencesIcon = { fg = palette.glitch },
		SagaShadow = { bg = palette.overlay },
		TargetWord = { fg = palette.bitdust },

		-- ray-x/lsp_signature.nvim
		LspSignatureActiveParameter = { bg = palette.overlay },

		-- rlane/pounce.nvim
		PounceAccept = { fg = palette.blush, bg = palette.blush, blend = 20 },
		PounceAcceptBest = { fg = palette.amber_dark, bg = palette.coral, blend = 20 },
		PounceGap = { link = "Search" },
		PounceMatch = { link = "Search" },

		-- ggandor/leap.nvim
		LeapLabelPrimary = { link = "IncSearch" },
		LeapLabelSecondary = { link = "StatusLineTerm" },
		LeapMatch = { link = "MatchParen" },

		-- phaazon/hop.nvim
		-- smoka7/hop.nvim
		HopNextKey = { fg = palette.blush, bg = palette.blush, blend = 20 },
		HopNextKey1 = { fg = palette.base, bg = palette.glitch, blend = 20 },
		HopNextKey2 = { fg = palette.coral, bg = palette.coral, blend = 20 },
		HopUnmatched = { fg = palette.muted },

		-- nvim-telescope/telescope.nvim
		TelescopeBorder = make_border(),
		TelescopeMatching = { fg = palette.glitch },
		TelescopeNormal = { link = "NormalFloat" },
		TelescopePromptNormal = { link = "TelescopeNormal" },
		TelescopePromptPrefix = { fg = palette.subtle },
		TelescopeSelection = { fg = palette.spectrum, bg = palette.overlay },
		TelescopeSelectionCaret = { fg = palette.glitch, bg = palette.overlay },
		TelescopeTitle = { fg = palette.skyware, bold = styles.bold },

		-- ibhagwan/fzf-lua
		FzfLuaNormal = { link = "NormalFloat" },
		FzfLuaTitle = { fg = palette.skyware, bold = styles.bold },
		FzfLuaBorder = make_border(),
		FzfLuaHeaderText = { fg = palette.blush },
		FzfLuaHeaderBind = { fg = palette.glitch },
		FzfLuaBufFlagCur = { fg = palette.subtle },
		FzfLuaBufFlagAlt = { fg = palette.subtle },

		-- rcarriga/nvim-notify
		NotifyDEBUGBorder = make_border(),
		NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
		NotifyDEBUGTitle = { fg = palette.muted },
		NotifyERRORBorder = make_border(groups.error),
		NotifyERRORIcon = { link = "NotifyERRORTitle" },
		NotifyERRORTitle = { fg = groups.error },
		NotifyINFOBorder = make_border(groups.info),
		NotifyINFOIcon = { link = "NotifyINFOTitle" },
		NotifyINFOTitle = { fg = groups.info },
		NotifyTRACEBorder = make_border(palette.bitdust),
		NotifyTRACEIcon = { link = "NotifyTRACETitle" },
		NotifyTRACETitle = { fg = palette.bitdust },
		NotifyWARNBorder = make_border(groups.warn),
		NotifyWARNIcon = { link = "NotifyWARNTitle" },
		NotifyWARNTitle = { fg = groups.warn },

		-- rcarriga/nvim-dap-ui
		DapUIBreakpointsCurrentLine = { fg = palette.amber_dark, bold = styles.bold },
		DapUIBreakpointsDisabledLine = { fg = palette.muted },
		DapUIBreakpointsInfo = { link = "DapUIThread" },
		DapUIBreakpointsLine = { link = "DapUIBreakpointsPath" },
		DapUIBreakpointsPath = { fg = palette.skyware },
		DapUIDecoration = { link = "DapUIBreakpointsPath" },
		DapUIFloatBorder = make_border(),
		DapUIFrameName = { fg = palette.spectrum },
		DapUILineNumber = { link = "DapUIBreakpointsPath" },
		DapUIModifiedValue = { fg = palette.skyware, bold = styles.bold },
		DapUIScope = { link = "DapUIBreakpointsPath" },
		DapUISource = { fg = palette.bitdust },
		DapUIStoppedThread = { link = "DapUIBreakpointsPath" },
		DapUIThread = { fg = palette.amber_dark },
		DapUIValue = { fg = palette.spectrum },
		DapUIVariable = { fg = palette.spectrum },
		DapUIWatchesEmpty = { fg = palette.blush },
		DapUIWatchesError = { link = "DapUIWatchesEmpty" },
		DapUIWatchesValue = { link = "DapUIThread" },

		-- glepnir/dashboard-nvim
		DashboardCenter = { fg = palette.glitch },
		DashboardFooter = { fg = palette.bitdust },
		DashboardHeader = { fg = palette.proxy },
		DashboardShortcut = { fg = palette.blush },

		-- SmiteshP/nvim-navic
		NavicIconsArray = { fg = palette.amber_dark },
		NavicIconsBoolean = { fg = palette.skyware },
		NavicIconsClass = { fg = palette.skyware },
		NavicIconsConstant = { fg = palette.coral },
		NavicIconsConstructor = { fg = palette.peach },
		NavicIconsEnum = { fg = palette.peach },
		NavicIconsEnumMember = { fg = palette.quantum },
		NavicIconsEvent = { fg = palette.amber_dark },
		NavicIconsField = { fg = palette.skyware },
		NavicIconsFile = { fg = palette.muted },
		NavicIconsFunction = { fg = palette.glitch },
		NavicIconsInterface = { fg = palette.skyware },
		NavicIconsKey = { fg = palette.bitdust },
		NavicIconsKeyword = { fg = palette.bitdust },
		NavicIconsMethod = { fg = palette.bitdust },
		NavicIconsModule = { fg = palette.glitch },
		NavicIconsNamespace = { fg = palette.muted },
		NavicIconsNull = { fg = palette.skyware },
		NavicIconsNumber = { fg = palette.amber_dark },
		NavicIconsObject = { fg = palette.quantum },
		NavicIconsOperator = { fg = palette.subtle },
		NavicIconsPackage = { fg = palette.muted },
		NavicIconsProperty = { fg = palette.quantum },
		NavicIconsString = { fg = palette.cipher },
		NavicIconsStruct = { fg = palette.biolink },
		NavicIconsTypeParameter = { fg = palette.skyware },
		NavicIconsVariable = { fg = palette.spectrum },
		NavicSeparator = { fg = palette.subtle },
		NavicText = { fg = palette.subtle },

		-- folke/noice.nvim
		NoiceCursor = { fg = palette.highlight_high, bg = palette.spectrum },

		-- folke/trouble.nvim
		TroubleText = { fg = palette.subtle },
		TroubleCount = { fg = palette.bitdust, bg = palette.surface },
		TroubleNormal = { fg = palette.spectrum, bg = groups.panel },

		-- echasnovski/mini.clue
		MiniClueTitle = { bg = groups.panel, bold = styles.bold },

		-- echasnovski/mini.diff
		MiniDiffOverAdd = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		MiniDiffOverChange = { fg = groups.git_change, bg = groups.git_change, blend = 20 },
		MiniDiffOverContext = { bg = palette.surface },
		MiniDiffOverDelete = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		MiniDiffSignAdd = { fg = groups.git_add },
		MiniDiffSignChange = { fg = groups.git_change },
		MiniDiffSignDelete = { fg = groups.git_delete },

		-- echasnovski/mini.pick
		MiniPickBorderText = { bg = groups.panel },
		MiniPickPrompt = { bg = groups.panel, bold = styles.bold },

		-- echasnovski/mini.indentscope
		MiniIndentscopeSymbol = { fg = palette.muted },
		MiniIndentscopeSymbolOff = { fg = palette.muted },

		-- echasnovski/mini.statusline
		MiniStatuslineDevinfo = { fg = palette.subtle, bg = palette.overlay },
		MiniStatuslineFileinfo = { link = "MiniStatuslineDevinfo" },
		MiniStatuslineFilename = { fg = palette.muted, bg = palette.surface },
		MiniStatuslineInactive = { link = "MiniStatuslineFilename" },
		MiniStatuslineModeCommand = { fg = palette.base, bg = palette.blush, bold = styles.bold },
		MiniStatuslineModeInsert = { fg = palette.base, bg = palette.skyware, bold = styles.bold },
		MiniStatuslineModeNormal = { fg = palette.base, bg = palette.glitch, bold = styles.bold },
		MiniStatuslineModeOther = { fg = palette.base, bg = palette.glitch, bold = styles.bold },
		MiniStatuslineModeReplace = { fg = palette.base, bg = palette.amber_dark, bold = styles.bold },
		MiniStatuslineModeVisual = { fg = palette.base, bg = palette.bitdust, bold = styles.bold },

		-- goolord/alpha-nvim
		AlphaButtons = { fg = palette.proxy },
		AlphaFooter = { fg = palette.amber_dark },
		AlphaHeader = { fg = palette.skyware },
		AlphaShortcut = { fg = palette.glitch },

		-- github/copilot.vim
		CopilotSuggestion = { fg = palette.muted, italic = styles.italic },

		-- nvim-treesitter/nvim-treesitter-context
		TreesitterContext = { bg = palette.overlay },
		TreesitterContextLineNumber = { fg = palette.glitch, bg = palette.overlay },

		-- RRethy/vim-illuminate
		IlluminatedWordRead = { link = "LspReferenceRead" },
		IlluminatedWordText = { link = "LspReferenceText" },
		IlluminatedWordWrite = { link = "LspReferenceWrite" },
	}
	local transparency_highlights = {
		DiagnosticVirtualTextError = { fg = groups.error },
		DiagnosticVirtualTextHint = { fg = groups.hint },
		DiagnosticVirtualTextInfo = { fg = groups.info },
		DiagnosticVirtualTextWarn = { fg = groups.warn },

		FloatBorder = { fg = palette.muted, bg = "NONE" },
		Folded = { fg = palette.spectrum, bg = "NONE" },
		NormalFloat = { bg = "NONE" },
		Normal = { fg = palette.spectrum, bg = "NONE" },
		NormalNC = { fg = palette.spectrum, bg = config.options.dim_inactive_windows and palette._nc or "NONE" },
		Pmenu = { fg = palette.subtle, bg = "NONE" },
		PmenuKind = { fg = palette.skyware, bg = "NONE" },
		SignColumn = { fg = palette.spectrum, bg = "NONE" },
		StatusLine = { fg = palette.subtle, bg = "NONE" },
		StatusLineNC = { fg = palette.muted, bg = "NONE" },
		TabLine = { bg = "NONE", fg = palette.subtle },
		TabLineFill = { bg = "NONE" },
		TabLineSel = { fg = palette.spectrum, bg = "NONE", bold = styles.bold },

		-- ["@markup.raw"] = { bg = "none" },
		["@markup.raw.markdown_inline"] = { fg = palette.amber_dark },
		-- ["@markup.raw.block"] = { bg = "none" },

		TelescopeNormal = { fg = palette.subtle, bg = "NONE" },
		TelescopePromptNormal = { fg = palette.spectrum, bg = "NONE" },
		TelescopeSelection = { fg = palette.spectrum, bg = "NONE", bold = styles.bold },
		TelescopeSelectionCaret = { fg = palette.glitch },

		WhichKeyFloat = { bg = "NONE" },

		IblIndent = { fg = palette.overlay, bg = "NONE" },
		IblScope = { fg = palette.skyware, bg = "NONE" },
		IblWhitespace = { fg = palette.overlay, bg = "NONE" },

		MiniClueTitle = { bg = "NONE", bold = styles.bold },

		MiniPickBorderText = { bg = "NONE" },
		MiniPickPrompt = { bg = "NONE", bold = styles.bold },
	}

	if config.options.enable.legacy_highlights then
		for group, highlight in pairs(legacy_highlights) do
			highlights[group] = highlight
		end
	end
	for group, highlight in pairs(default_highlights) do
		highlights[group] = highlight
	end
	if styles.transparency then
		for group, highlight in pairs(transparency_highlights) do
			highlights[group] = highlight
		end
	end

	-- Reconcile highlights with config
	if config.options.highlight_groups ~= nil and next(config.options.highlight_groups) ~= nil then
		for group, highlight in pairs(config.options.highlight_groups) do
			local existing = highlights[group] or {}
			-- Traverse link due to
			-- "If link is used in combination with other attributes; only the link will take effect"
			-- see: https://neovim.io/doc/user/api.html#nvim_set_hl()
			while existing.link ~= nil do
				existing = highlights[existing.link] or {}
			end
			local parsed = vim.tbl_extend("force", {}, highlight)

			if highlight.fg ~= nil then
				parsed.fg = utilities.parse_color(highlight.fg) or highlight.fg
			end
			if highlight.bg ~= nil then
				parsed.bg = utilities.parse_color(highlight.bg) or highlight.bg
			end
			if highlight.sp ~= nil then
				parsed.sp = utilities.parse_color(highlight.sp) or highlight.sp
			end

			if (highlight.inherit == nil or highlight.inherit) and existing ~= nil then
				parsed.inherit = nil
				highlights[group] = vim.tbl_extend("force", existing, parsed)
			else
				parsed.inherit = nil
				highlights[group] = parsed
			end
		end
	end

	for group, highlight in pairs(highlights) do
		if config.options.before_highlight ~= nil then
			config.options.before_highlight(group, highlight, palette)
		end

		if highlight.blend ~= nil and (highlight.blend >= 0 and highlight.blend <= 100) and highlight.bg ~= nil then
			highlight.bg = utilities.blend(highlight.bg, highlight.blend_on or palette.base, highlight.blend / 100)
		end

		vim.api.nvim_set_hl(0, group, highlight)
	end

	--- Terminal
	if config.options.enable.terminal then
		vim.g.terminal_color_0 = palette.overlay -- black
		vim.g.terminal_color_1 = palette.blush -- red
		vim.g.terminal_color_2 = palette.cipher -- green
		vim.g.terminal_color_3 = palette.amber_dark -- yellow
		vim.g.terminal_color_4 = palette.quantum -- blue
		vim.g.terminal_color_5 = palette.bitdust -- magenta
		vim.g.terminal_color_6 = palette.skyware -- cyan
		vim.g.terminal_color_7 = palette.spectrum -- white
		vim.g.terminal_color_8 = palette.subtle -- bright black
		vim.g.terminal_color_9 = palette.glitch -- bright red
		vim.g.terminal_color_10 = palette.biolink -- bright green
		vim.g.terminal_color_11 = palette.amber -- bright yellow
		vim.g.terminal_color_12 = palette.quantum -- bright blue
		vim.g.terminal_color_13 = palette.bitdust -- bright magenta
		vim.g.terminal_color_14 = palette.skyware -- bright cyan
		vim.g.terminal_color_15 = palette.spectrum -- bright white

		-- Support StatusLineTerm & StatusLineTermNC from vim
		vim.cmd([[
		augroup alternight
			autocmd!
			autocmd TermOpen * if &buftype=='terminal'
				\|setlocal winhighlight=StatusLine:StatusLineTerm,StatusLineNC:StatusLineTermNC
				\|else|setlocal winhighlight=|endif
			autocmd ColorSchemePre * autocmd! alternight
		augroup END
		]])
	end
end

---@param variant Variant | nil
function M.colorscheme(variant)
	config.extend_options({ variant = variant })

	vim.opt.termguicolors = true
	if vim.g.colors_name then
		vim.cmd("hi clear")
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "alternight"

	set_highlights()
end

---@param options Options
function M.setup(options)
	config.extend_options(options or {})
end

return M
