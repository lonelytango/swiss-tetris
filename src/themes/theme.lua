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
    Z = { Color.rgbToLove(242, 241, 233) }, -- Off white
    A = { Color.rgbToLove(255, 218, 193) }, -- Peach
    B = { Color.rgbToLove(187, 222, 214) }, -- Mint
    C = { Color.rgbToLove(225, 196, 235) }  -- Lavender
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
    Z = { Color.rgbToLove(240, 0, 0) },   -- Red
    A = { Color.rgbToLove(240, 0, 240) }, -- Magenta
    B = { Color.rgbToLove(0, 240, 160) }, -- Turquoise
    C = { Color.rgbToLove(240, 120, 0) }  -- Deep Orange
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
    Z = { Color.rgbToLove(171, 86, 86) },  -- Muted red
    A = { Color.rgbToLove(171, 86, 171) }, -- Muted magenta
    B = { Color.rgbToLove(86, 171, 137) }, -- Muted turquoise
    C = { Color.rgbToLove(171, 120, 86) }  -- Muted bronze
  },
  background = { Color.rgbToLove(20, 20, 20) },
  grid = { Color.rgbToLove(40, 40, 40) }
}

-- Neon Nights theme
Theme.NEON = {
  name = "Neon",
  pieces = {
    I = { Color.rgbToLove(0, 255, 205) },  -- Cyan neon
    O = { Color.rgbToLove(255, 251, 20) }, -- Yellow neon
    T = { Color.rgbToLove(255, 0, 255) },  -- Magenta neon
    L = { Color.rgbToLove(255, 80, 0) },   -- Orange neon
    J = { Color.rgbToLove(0, 50, 255) },   -- Blue neon
    S = { Color.rgbToLove(0, 255, 70) },   -- Green neon
    Z = { Color.rgbToLove(255, 0, 100) },  -- Pink neon
    A = { Color.rgbToLove(180, 0, 255) },  -- Purple neon
    B = { Color.rgbToLove(0, 255, 255) },  -- Aqua neon
    C = { Color.rgbToLove(255, 150, 0) }   -- Gold neon
  },
  background = { Color.rgbToLove(10, 10, 20) },
  grid = { Color.rgbToLove(30, 30, 45) }
}

-- Forest theme
Theme.FOREST = {
  name = "Forest",
  pieces = {
    I = { Color.rgbToLove(95, 141, 78) },   -- Moss green
    O = { Color.rgbToLove(240, 198, 93) },  -- Sunlight
    T = { Color.rgbToLove(141, 89, 41) },   -- Tree bark
    L = { Color.rgbToLove(189, 108, 49) },  -- Cedar
    J = { Color.rgbToLove(59, 99, 39) },    -- Deep forest
    S = { Color.rgbToLove(155, 175, 93) },  -- Lichen
    Z = { Color.rgbToLove(201, 108, 89) },  -- Forest mushroom
    A = { Color.rgbToLove(172, 157, 142) }, -- Birch bark
    B = { Color.rgbToLove(108, 124, 89) },  -- Pine needle
    C = { Color.rgbToLove(191, 172, 133) }  -- Dead leaves
  },
  background = { Color.rgbToLove(27, 38, 25) },
  grid = { Color.rgbToLove(45, 61, 42) }
}

-- Ocean theme
Theme.OCEAN = {
  name = "Ocean",
  pieces = {
    I = { Color.rgbToLove(37, 145, 191) },  -- Ocean blue
    O = { Color.rgbToLove(243, 218, 169) }, -- Sand
    T = { Color.rgbToLove(89, 201, 165) },  -- Seaweed
    L = { Color.rgbToLove(255, 125, 78) },  -- Coral
    J = { Color.rgbToLove(0, 105, 148) },   -- Deep blue
    S = { Color.rgbToLove(195, 228, 180) }, -- Sea foam
    Z = { Color.rgbToLove(255, 89, 100) },  -- Red coral
    A = { Color.rgbToLove(78, 198, 233) },  -- Light blue
    B = { Color.rgbToLove(155, 89, 182) },  -- Sea urchin
    C = { Color.rgbToLove(241, 196, 15) }   -- Starfish
  },
  background = { Color.rgbToLove(11, 30, 44) },
  grid = { Color.rgbToLove(23, 52, 71) }
}

-- Candy theme
Theme.CANDY = {
  name = "Candy",
  pieces = {
    I = { Color.rgbToLove(255, 182, 193) }, -- Pink taffy
    O = { Color.rgbToLove(255, 218, 121) }, -- Lemon drop
    T = { Color.rgbToLove(183, 149, 255) }, -- Grape candy
    L = { Color.rgbToLove(255, 153, 102) }, -- Orange cream
    J = { Color.rgbToLove(102, 217, 255) }, -- Blue raspberry
    S = { Color.rgbToLove(152, 255, 152) }, -- Lime candy
    Z = { Color.rgbToLove(255, 105, 128) }, -- Strawberry
    A = { Color.rgbToLove(255, 166, 201) }, -- Cotton candy
    B = { Color.rgbToLove(190, 255, 232) }, -- Mint
    C = { Color.rgbToLove(255, 198, 255) }  -- Bubblegum
  },
  background = { Color.rgbToLove(45, 25, 35) },
  grid = { Color.rgbToLove(70, 45, 60) }
}

-- Monochrome theme
Theme.MONO = {
  name = "Monochrome",
  pieces = {
    I = { Color.rgbToLove(255, 255, 255) }, -- White
    O = { Color.rgbToLove(230, 230, 230) }, -- Light grey
    T = { Color.rgbToLove(200, 200, 200) }, -- Grey 1
    L = { Color.rgbToLove(180, 180, 180) }, -- Grey 2
    J = { Color.rgbToLove(160, 160, 160) }, -- Grey 3
    S = { Color.rgbToLove(140, 140, 140) }, -- Grey 4
    Z = { Color.rgbToLove(120, 120, 120) }, -- Grey 5
    A = { Color.rgbToLove(100, 100, 100) }, -- Grey 6
    B = { Color.rgbToLove(80, 80, 80) },    -- Grey 7
    C = { Color.rgbToLove(60, 60, 60) }     -- Grey 8
  },
  background = { Color.rgbToLove(10, 10, 10) },
  grid = { Color.rgbToLove(30, 30, 30) }
}

-- Sunset theme
Theme.SUNSET = {
  name = "Sunset",
  pieces = {
    I = { Color.rgbToLove(255, 183, 77) },  -- Golden hour
    O = { Color.rgbToLove(255, 121, 63) },  -- Orange sun
    T = { Color.rgbToLove(246, 114, 128) }, -- Coral sky
    L = { Color.rgbToLove(192, 108, 132) }, -- Dusk pink
    J = { Color.rgbToLove(108, 91, 123) },  -- Twilight
    S = { Color.rgbToLove(255, 166, 158) }, -- Peach
    Z = { Color.rgbToLove(255, 94, 87) },   -- Red sun
    A = { Color.rgbToLove(246, 158, 123) }, -- Light peach
    B = { Color.rgbToLove(132, 96, 158) },  -- Purple haze
    C = { Color.rgbToLove(238, 174, 202) }  -- Pink clouds
  },
  background = { Color.rgbToLove(25, 23, 36) },
  grid = { Color.rgbToLove(45, 41, 60) }
}

-- Cyberpunk theme
Theme.CYBER = {
  name = "Cyberpunk",
  pieces = {
    I = { Color.rgbToLove(0, 255, 238) },  -- Cyber blue
    O = { Color.rgbToLove(255, 62, 255) }, -- Hot pink
    T = { Color.rgbToLove(0, 255, 135) },  -- Matrix green
    L = { Color.rgbToLove(255, 90, 0) },   -- Burning orange
    J = { Color.rgbToLove(118, 38, 255) }, -- Neo purple
    S = { Color.rgbToLove(255, 231, 0) },  -- Electric yellow
    Z = { Color.rgbToLove(255, 0, 72) },   -- Cyber red
    A = { Color.rgbToLove(0, 187, 255) },  -- Hologram blue
    B = { Color.rgbToLove(175, 255, 10) }, -- Toxic green
    C = { Color.rgbToLove(255, 128, 222) } -- Digital pink
  },
  background = { Color.rgbToLove(15, 8, 25) },
  grid = { Color.rgbToLove(35, 20, 50) }
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
