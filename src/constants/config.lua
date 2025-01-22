local Config = {
    -- Game grid configuration
    GRID_SIZE = 30,
    GRID_WIDTH = 10,
    GRID_HEIGHT = 20,
    -- Game mechanics configuration
    INITIAL_DROP_TIME = 2.0,
    LEVEL_LINES_REQUIREMENT = 10,
    SPEED_INCREASE_FACTOR = 0.9,
    -- Preview configuration
    PREVIEW_SIZE = 4,    -- Size of the preview box (in grid cells)
    PREVIEW_SCALE = 0.6, -- Scale factor for preview pieces

    -- UI Layout configuration
    SIDE_PANEL = {
        PADDING = 20,         -- Padding from game grid
        MARGIN = 15,          -- Margin between components
        WIDTH = 160,          -- Width of the side panel
        COMPONENT_HEIGHT = 40 -- Standard height for components
    },

    -- Button configuration
    BUTTON = {
        WIDTH = 140,
        HEIGHT = 40
    }
}

-- Calculate main game area position (always starts at 0,0)
Config.GAME_AREA = {
    X = 0,
    Y = 0,
    WIDTH = Config.GRID_WIDTH * Config.GRID_SIZE,
    HEIGHT = Config.GRID_HEIGHT * Config.GRID_SIZE
}

-- Calculate side panel position
Config.SIDE_PANEL.X = Config.GAME_AREA.WIDTH + Config.SIDE_PANEL.PADDING
Config.SIDE_PANEL.Y = 0

-- Function to get the Y position for components in the side panel
local function getComponentY(index)
    return Config.SIDE_PANEL.Y + (index - 1) * (Config.SIDE_PANEL.COMPONENT_HEIGHT + Config.SIDE_PANEL.MARGIN)
end

-- Define component positions (in order from top to bottom)
Config.COMPONENTS = {
    RESET_BUTTON = {
        X = Config.SIDE_PANEL.X + (Config.SIDE_PANEL.WIDTH - Config.BUTTON.WIDTH) / 2,
        Y = getComponentY(1),
        WIDTH = Config.BUTTON.WIDTH,
        HEIGHT = Config.BUTTON.HEIGHT
    },

    SCORE = {
        X = Config.SIDE_PANEL.X,
        Y = getComponentY(2),
        WIDTH = Config.SIDE_PANEL.WIDTH,
        HEIGHT = Config.SIDE_PANEL.COMPONENT_HEIGHT
    },

    LEVEL = {
        X = Config.SIDE_PANEL.X,
        Y = getComponentY(3),
        WIDTH = Config.SIDE_PANEL.WIDTH,
        HEIGHT = Config.SIDE_PANEL.WIDTH
    },

    NEXT_PIECE = {
        X = Config.SIDE_PANEL.X,
        Y = getComponentY(4),
        WIDTH = Config.SIDE_PANEL.WIDTH,
        HEIGHT = Config.SIDE_PANEL.WIDTH
    },

    HIGH_SCORES = {
        X = Config.SIDE_PANEL.X,
        Y = getComponentY(7), -- Leave space for the preview box
        WIDTH = Config.SIDE_PANEL.WIDTH,
        HEIGHT = Config.SIDE_PANEL.COMPONENT_HEIGHT * 3
    },

    QUIT_BUTTON = {
        X = Config.SIDE_PANEL.X + (Config.SIDE_PANEL.WIDTH - Config.BUTTON.WIDTH) / 2,
        Y = getComponentY(11), -- At the bottom
        WIDTH = Config.BUTTON.WIDTH,
        HEIGHT = Config.BUTTON.HEIGHT
    }
}

-- Calculate total required height
Config.WINDOW = {
    WIDTH = Config.GAME_AREA.WIDTH + Config.SIDE_PANEL.PADDING + Config.SIDE_PANEL.WIDTH + Config.SIDE_PANEL.PADDING,
    HEIGHT = math.max(
        Config.GAME_AREA.HEIGHT,
        Config.COMPONENTS.QUIT_BUTTON.Y + Config.COMPONENTS.QUIT_BUTTON.HEIGHT + Config.SIDE_PANEL.PADDING
    )
}

return Config
