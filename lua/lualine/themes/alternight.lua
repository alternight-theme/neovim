local p = require("alternight.palette")
local config = require("alternight.config")

local bg_base = p.base
if config.options.styles.transparency then
	bg_base = "NONE"
end

return {
	normal = {
		a = { bg = p.glitch, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.glitch },
		c = { bg = bg_base, fg = p.spectrum },
	},
	insert = {
		a = { bg = p.proxy, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.proxy },
		c = { bg = bg_base, fg = p.spectrum },
	},
	visual = {
		a = { bg = p.aqua, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.aqua },
		c = { bg = bg_base, fg = p.spectrum },
	},
	replace = {
		a = { bg = p.amber_dark, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.amber_dark },
		c = { bg = bg_base, fg = p.spectrum },
	},
	command = {
		a = { bg = p.peach, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.peach },
		c = { bg = bg_base, fg = p.spectrum },
	},
	inactive = {
		a = { bg = bg_base, fg = p.muted, gui = "bold" },
		b = { bg = bg_base, fg = p.muted },
		c = { bg = bg_base, fg = p.muted },
	},
}
