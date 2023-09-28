<p align="center">
    <h2 align="center">🎨 Palette</h2>
</p>
<p align="center">
  Beautiful, Versatile, Systematic
</p>
<p align="center">
    <img src="https://github.com/roobert/palette.nvim/assets/226654/56afa310-04f0-42cc-9901-a212d1853ee7" />
</p>

## About

_Palette_ is a Neovim theme system to make creating and customising themes easy.

Highlight groups are logically arranged to strike a harmonious balance between clarity and aesthetic appeal.

Caching ensures themes are performant.

Build easily distributable themes using the provided `build` script.

Generate other application color schemes, such as `LS_COLORS` for matching terminal feel.

## Theory

The theme is broken up into three sets of colors: _main_, _accent_, and _state_.

### Main Colors

The main colors are used for the background, cursorline color, and to color the code and comments.

![Main colors screenshot](https://github-production-user-asset-6210df.s3.amazonaws.com/226654/270648812-f229d2a0-7b99-425e-bffc-062bf387c4d8.png)

### Accent Colors

Accent colors can be used to bring special attention to highlight groups, in this case _constants_ and _integers_ are highlighted with colors not in the main palette:
![Accent colors screenshot](https://github.com/roobert/palette.nvim/assets/226654/2d7ff03c-f1d5-46b9-9359-973fcf7002ed)

### State Colors

There are five different state colors which represent:

- `error`
- `warn`
- `hint`
- `ok`
- `info`

These are used by Diagnostics, git, etc. Anywhere where a state is represented:

![Accent colors screenshot](https://github-production-user-asset-6210df.s3.amazonaws.com/226654/270648776-623c7916-adcd-4d8e-a2f2-e0c28353af65.png)

## Built-In Colors

There are two built-in _main_ palettes: _dark_ and _light_.

There are three built-in _accent_ palettes: _pastel_, _dark_ and _bright_.

There are three built-in _state_ palettes: _pastel_, _dark_ and _bright_.

## Custom Palettes

Custom palettes can be defined like this:

```lua
{
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("palette").setup({
      palettes = {
        main = "custom_main_palette",
        accent = "custom_accent_palette",
        state = "custom_state_palette",
      },

      custom_palettes = {
        main = {
          custom_main_palette = {
            color0 = "#191d33",
            color1 = "#1A1E39",
            color2 = "#383f5e",
            color3 = "#4e5470",
            color4 = "#7b7f94",
            color5 = "#a7a9b7",
            color6 = "#bdbfc9",
            color7 = "#d3d4db",
            color8 = "#e9e9ed",
          },
        },
        accent = {
          custom_accent_palette = {
            accent0 = "#D97C8F",
            accent1 = "#D9AE7E",
            accent2 = "#D9D87E",
            accent3 = "#A5D9A7",
            accent4 = "#8BB9C8",
            accent5 = "#C9A1D3",
            accent6 = "#B8A1D9",
          },
        },
        state = {
          custom_state_palette = {
            error = "#D97C8F",
            warning = "#D9AE7E",
            hint = "#D9D87E",
            ok = "#A5D9A7",
            info = "#8BB9C8",
          },
        },
      },
    })

    vim.cmd([[colorscheme palette]])
  end,
},
```

## Highlight Groups

The highlight groups are spit into [multiple files](https://github.com/roobert/palette.nvim/tree/main/lua/palette/highlights), `_defaults.lua` contains the default highlight groups, and then there is a file for each set of additional highlight groups, e.g: `python.lua`.

The highlight groups use the following colors:

- 9 main colors, named: `color0`-`color8`
- 7 accent colors, named: `accent0`-`accent7`
- 5 state colors, named: `error`, `warning`, `hint`, `ok`, `info`

Additional colors can be added to any palette, with any name, and then used in custom [highlight overrides](https://github.com/roobert/palette.nvim/tree/main#overriding-highlight-groups---built-in-method).

## Derived Palettes

Palettes (including the defaults) can be used to generate new color schemes.

This works by the user specifying a base color and the base palette which is then used to establish the tone difference to generate a new palette.

Note: The resulting colors will match the length of the source color table.

See an example of a derived theme in the next section.

## Caching

_Palette_ implements automatic caching.

The cache is stored in the `palette` (or theme name, if a distributable) directory under your users cache directory, typically: `~/.cache/nvim/palette/`

## Gallery

Built-in _dark_ _main_ palette:

![Palette built-in dark theme](https://github.com/roobert/palette.nvim/assets/226654/56afa310-04f0-42cc-9901-a212d1853ee7)

Built-in _light_ _main_ palette:

![Palette built-in light theme](https://github.com/roobert/palette.nvim/assets/226654/43544e66-92b9-41b2-87f2-4f944a2e2bb4)

A custom derived theme inspired by Life Aquatic's Team Zissou colors:

![Team Zissou theme](https://github.com/roobert/palette.nvim/assets/226654/2d92821a-dd78-4828-b08e-1557a5665856)

## 🛠️ Install

```lua
{
  'roobert/palette',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme palette")
  end
}
```

## ⚙️ Configuration Examples

### Overriding Default Palettes

Example overriding the default palettes:

```lua
{
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("palette").setup({
      palettes = {
        -- dark or light
        main = "light",

        -- pastel, bright or dark
        accent = "dark",
        state = "dark",
      },

      italics = true,
      transparent_background = false,
    })
  end,
},
```

### Custom _Main_ Palette

An example of using a custom _main_ palette:

```lua
{
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("palette").setup({
      palettes = {
        main = "dust_dusk",
      },

      italics = true,
      transparent_background = false,

      custom_palettes = {
        main = {
          -- dusk theme taken from roobert/dust.nvim
          dust_dusk = {
            color0 = "#121527",
            color1 = "#1A1E39",
            color2 = "#232A4D",
            color3 = "#3E4D89",
            color4 = "#687BBA",
            color5 = "#A4B1D6",
            color6 = "#bdbfc9",
            color7 = "#DFE5F1",
            color8 = "#e9e9ed",
          }
        },
        accent = {},
        state = {},
      }
    })

    vim.cmd([[colorscheme palette]])
  end,
},
```

### Derived Theme

An example of using a _derived_ theme based on the built-in _dark_ palette, with a couple of color overrides merged into the generated palette table:

```lua
{
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("palette").setup({
      palettes = {
        main = "team_zissou",
        accent = "pastel",
        state = "pastel",
      },

      custom_palettes = {
        main = {
          -- a blue theme, based off the built-in dark palette
          team_zissou = vim.tbl_extend(
            "force",
            require("palette.generator").generate_colors(
              require("palette.colors").main["dark"],
              "#04213b"
            ),
            {
              -- override background and cursor-line
              color0 = "#191d33",
              color1 = "#1A1E39",
              -- override most prominent colors (strings, etc.)
              color7 = "#e9e9ed",
              color8 = "#d3d4db",
            }
          ),
        },
      }
    })

    vim.cmd([[colorscheme palette]])
  end,
},
```

### Lighten / Darken

It's possible to use `lighten()` and `darken()` to lighten and darken colors. In this
example a default color is being overridden:

```lua
{
    "roobert/palette.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Reference the dark palette
        local dark_palette = require("palette.colors").main["dark"]

        -- Lighten the cursor-line
        dark_palette.color1 = require("palette.utils").lighten(dark_palette["color1"])

        require("palette").setup({
          palettes = {
            -- Reference the custom theme
            main = "custom_lighter_cursorline",
          },
          custom_palettes = {
            main = {
              -- Create a custom theme
              custom_lighter_cursorline = dark_palette,
            }
          },
        })

        vim.cmd([[colorscheme palette]])
    end,
}
```

### Overriding Highlight Groups - Built-In Method

An example of overriding specific highlight groups using the built-in method:

```lua
{
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- alias so we can easily reference theme colors
    a = require("palette.theme").accent

    require("palette").setup({
      -- custom highlight groups can override any highlight groups
      -- add one table per override:
      custom_highlights = {
        {
          -- highlight group, or nil
          "Normal",
          -- foreground, or nil
          a.accent0,
          -- background, or nil
          "#00ff00",
          -- style(s) to apply, or nil
          { "italic", "underline", "bold" },
        },
      }
    })

    vim.cmd([[colorscheme palette]])
  end,
},
```

### Overriding Highlight Groups - Normal Method

Alternatively highlight groups can be overridden in the normal way:

```lua
{
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("palette").setup({})

    vim.cmd([[colorscheme palette]])

    -- example of specific highlight group override..
    vim.cmd([[highlight Normal guifg="#ff0000"]])

    -- example of specific highlight group override using palette color
    a = require("palette.theme").accent
    vim.cmd([[highlight Normal guifg=a.accent0]])
  end,
},
```

## Caching

To adjust caching or set a custom cache path:

```lua
{
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("palette").setup({
      caching = true,
      -- typically: ~/.cache/nvim/palette/
      cache_dir = vim.fn.stdpath("cache") .. "/palette",
    })

    vim.cmd([[colorscheme palette]])
  end,
},
```

## Support for `LS_COLORS`

> [Vivid](https://github.com/sharkdp/vivid) is a generator for the `LS_COLORS` environment variable that controls the colorized output of `ls`, `tree`, `fd`, `bfs`, `dust` and many other tools.

![Custom LS_COLORS screenshot](https://github.com/roobert/palette.nvim/assets/226654/e7e5ac09-dfbd-4fa6-b258-8f2da9332511)

Use the `vivid.lua` script to generate a `vivid` config file:

```
brew install vivid
mkdir -p ~/.config/vivid/themes

# optionally:
# * customize vivid/filetypes.yml
# * change which palettes are used
./bin/vivid.lua palette dark pastel bright palette_dark

cp -v vivid/themes/* ~/.config/vivid/themes/

# add to ~/.zshrc or ~/.bashrc
LS_COLORS="$(vivid generate palette_dark)"
```

## Support for `iterm2`

![iterm2 screenshot](https://github.com/roobert/palette.nvim/assets/226654/1ba8953d-2ce8-4c1c-8e7b-4f7e776f9859)


Generate theme for iterm2:

```bash
./bin/iterm2.lua palette dark pastel > terminal/palette.itermcolors
```

Import the theme through `Settings -> Profiles -> Colors -> Import` and then select from the preset list.

## Custom Themes for Distribution

It's always possible to share your theme by sharing a code block like this:

```lua
{
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("palette").setup({
      palettes = {
        -- built in colorscheme: grey
        main = "dust_dusk",
        -- built in accents: pastel, bright, dark
        accent = "pastel",
        state = "pastel",
      },

      italics = true,
      transparent_background = false,

      custom_palettes = {
        main = {
          dust_dusk = {
            color0 = "#121527",
            color1 = "#1A1E39",
            color2 = "#232A4D",
            color3 = "#3E4D89",
            color4 = "#687BBA",
            color5 = "#A4B1D6",
            color6 = "#bdbfc9",
            color7 = "#DFE5F1",
            color8 = "#e9e9ed",
          },
        },
      },
      accent = {},
      state = {},
    })

    vim.cmd([[colorscheme palette]])
  end,
},
```

However, if you'd like to be able to give people a code block like this:

```lua
{
  "username/colorscheme_name.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme colorscheme_name]])
  end,
},
```

A build script is provided and can be used like this:

1. Fork this repository or click "Use this template" button and name your fork/copy `<your-theme-name>.nvim`
2. Clone the repository
3. Output your custom theme color palettes:

```lua
:lua print(vim.inspect(require("palette.theme")))
```

4. Write the palette and accents to `lua/palette/colors.lua`
5. Run the build script:

```bash
./bin/build.sh <new theme name> <main palette name> <accent palette name> <state palette name>
# e.g:
./bin/build.sh dust dusk pastel pastel
```

6. Optionally add support for [LS_COLORS](https://github.com/roobert/palette.nvim/tree/main#support-for-ls_colors) and [iterm2](https://github.com/roobert/palette.nvim#support-for-iterm2).
7. Update the `README.md` with screenshots, etc.
8. Release your theme to the world!
