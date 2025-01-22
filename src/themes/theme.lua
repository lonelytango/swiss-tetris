-- src/themes/theme.lua
local Color = require('src.utils.color')

local Theme = {}

-- Define different color themes
Theme.PASTEL = {
  name = "Pastel",
  pieces = {
    I = { Color.rgbToLove(204, 234, 238) }, -- Light blue
    O = { Color.rgbToLove(152, 212, 220) }, -- Teal
    T = { Color.rgbToLove(115, 62, 78) },   -- Dark rose
    L = { Color.rgbToLove(245, 133, 157) }, -- Pink
    J = { Color.rgbToLove(250, 194, 206) }, -- Light pink
    S = { Color.rgbToLove(3, 166, 136) },   -- Turquoise
    Z = { Color.rgbToLove(242, 241, 233) }  -- Off white
  },
  background = { Color.rgbToLove(40, 40, 40) },
  grid = { Color.rgbToLove(70, 70, 70) }
}

-- Classic Tetris colors
Theme.CLASSIC = {
  name = "Classic",
  pieces = {
    I = { Color.rgbToLove(0, 240, 240) }, -- Cyan
    O = { Color.rgbToLove(240, 240, 0) }, -- Yellow
    T = { Color.rgbToLove(160, 0, 240) }, -- Purple
    L = { Color.rgbToLove(240, 160, 0) }, -- Orange
    J = { Color.rgbToLove(0, 0, 240) },   -- Blue
    S = { Color.rgbToLove(0, 240, 0) },   -- Green
    Z = { Color.rgbToLove(240, 0, 0) }    -- Red
  },
  background = { Color.rgbToLove(44, 44, 44) },
  grid = { Color.rgbToLove(66, 66, 66) }
}

-- Dark theme
Theme.DARK = {
  name = "Dark",
  pieces = {
    I = { Color.rgbToLove(86, 171, 171) }, -- Muted cyan
    O = { Color.rgbToLove(171, 171, 86) }, -- Muted yellow
    T = { Color.rgbToLove(137, 86, 171) }, -- Muted purple
    L = { Color.rgbToLove(171, 137, 86) }, -- Muted orange
    J = { Color.rgbToLove(86, 86, 171) },  -- Muted blue
    S = { Color.rgbToLove(86, 171, 86) },  -- Muted green
    Z = { Color.rgbToLove(171, 86, 86) }   -- Muted red
  },
  background = { Color.rgbToLove(20, 20, 20) },
  grid = { Color.rgbToLove(40, 40, 40) }
}

-- Current theme (default to PASTEL)
Theme.current = Theme.CLASSIC

-- Get color for a specific piece type
function Theme.getPieceColor(pieceType)
  return Theme.current.pieces[pieceType]
end

-- Change the current theme
function Theme.setTheme(theme)
  Theme.current = theme
end

-- Get a list of available themes
function Theme.getThemeList()
  return {
    Theme.PASTEL,
    Theme.CLASSIC,
    Theme.DARK
  }
end

return Theme
