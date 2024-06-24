local p = require("alternight.palette")

return {
	normal = {
		a = { bg = p.surface, fg = p.glitch, gui = "bold" },
		b = { bg = p.surface, fg = p.spectrum },
		c = { bg = p.surface, fg = p.subtle, gui = "italic" },
	},
	insert = {
		a = { bg = p.surface, fg = p.proxy, gui = "bold" },
	},
	visual = {
		a = { bg = p.surface, fg = p.aqua, gui = "bold" },
	},
	replace = {
		a = { bg = p.surface, fg = p.amber_dark, gui = "bold" },
	},
	command = {
		a = { bg = p.surface, fg = p.peach, gui = "bold" },
	},
	inactive = {
		a = { bg = p.base, fg = p.subtle, gui = "bold" },
		b = { bg = p.base, fg = p.subtle },
		c = { bg = p.base, fg = p.subtle, gui = "italic" },
	},
}
