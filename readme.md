# AlterNight for Neovim

## Getting started

Install `alternight-theme/neovim` using your favourite plugin manager:

**paq-nvim**

```lua
{ "alternight-theme/neovim", as = "alternight" }
```

**lazy.nvim**

```lua
{ "alternight-theme/neovim", name = "alternight" }
```

## Gallery

**AlterNight**

![Rosé Pine with Neovim](https://user-images.githubusercontent.com/1973/163921570-0f577baf-3199-4f09-9779-a7eb9238151a.png)

**AlterNight Aurora**

![Rosé Pine Dawn with Neovim](https://user-images.githubusercontent.com/1973/163921656-644a2db3-c55c-4e89-9bdd-39cdd7a2681b.png)

## Options

> [!IMPORTANT]
> Configure options _before_ setting colorscheme.

AlterNight has two variants: main and aurora. By default, `vim.o.background` is followed, using aurora when light and dark, otherwise.

Colour values accept named colours from the [AlterNight palette](https://rosepinetheme.com/palette/ingredients/), e.g. "coral", or valid hex, e.g. "#f78c6c".

```lua
require("rose-pine").setup({
    variant = "auto", -- auto, main or aurora
    dark_variant = "main",
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- VertSplit = { fg = "muted", bg = "muted" },
    },

    before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.coral then
        --     highlight.fg = palette.glitch
        -- end
    end,
})

vim.cmd("colorscheme alternight")
-- vim.cmd("colorscheme alternight-aurora")
```

> [!NOTE]
> Visit the [wiki](https://github.com/alternight-theme/neovim/wiki) for [plugin configurations](https://github.com/alternight-theme/neovim/wiki/Plugin-configurations) and [recipes](https://github.com/alternight-theme/neovim/wiki/Recipes).

## Contributing

I welcome and appreciate contributions of any kind. Create an issue or start a discussion for any proposed changes. Pull requests are encouraged for supporting additional plugins or [treesitter improvements](https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights).

Feel free to update the [wiki](https://github.com/alternight-theme/neovim/wiki/) with any [recipes](https://github.com/alternight-theme/neovim/wiki/Recipes).
