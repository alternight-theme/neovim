local options = require("alternight.config").options
local variants = {
	main = {
		_nc = "#130e1b",
		base = "#251E31",
		surface = "#241b32",
		overlay = "#2b203c",
		muted = "#786e87",
		subtle = "#908caa",
		whisper = "#524168", -- comments
		spectrum = "#efe7f8", -- text
		proxy = "#ecfb23",
		quantum = "#5c7fe2", -- blue
		cipher = "#4ca779", -- green
		mint = "#5fe09f", -- green_alt
		mint_dimmed = "#75dfbc",
		coral = "#f78c6c", -- orange
		peach = "#e27171",
		lavender = "#a477be",
		blush = "#df84a2", -- red
		glitch = "#e0a1a4", -- pink
		aqua = "#9ccfd8",
		amber = "#e7d5a4",
		amber_dark = "#f0bb6b",
		amber_ultra = "#f1b718",
		highlight_low = "#21202e",
		highlight_med = "#403d52",
		highlight_high = "#524f67",
		none = "NONE",
	},
	aurora = {
		_nc = "#f4f4f6",
		base = "#f3f2f8",
		surface = "#eae7f3",
		overlay = "#dedaec",
		muted = "#d8d6e0",
		subtle = "#aba8bd",
		whisper = "#d9d0e6",
		spectrum = "#1f172b",
		proxy = "#ecfb23",
		quantum = "#5c7fe2",
		cipher = "#4ca779",
		mint = "#5fe09f",
		mint_dimmed = "#75dfbc",
		coral = "#f78c6c",
		peach = "#e27171",
		lavender = "#a477be",
		blush = "#df84a2",
		glitch = "#e0a1a4",
		aqua = "#9ccfd8",
		amber = "#e7d5a4",
		amber_dark = "#f0bb6b",
		amber_ultra = "#f1b718",
		highlight_low = "#f4ede8",
		highlight_med = "#dfdad9",
		highlight_high = "#cecacd",
		none = "NONE",
	},
}

if variants[options.variant] ~= nil then
	return variants[options.variant]
end

return vim.o.background == "light" and variants.dawn or variants["main"]
