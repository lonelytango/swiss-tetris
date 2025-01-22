local Config = {
    BUTTON_WIDTH = 100,
    BUTTON_HEIGHT = 40,
    GRID_SIZE = 30,
    GRID_WIDTH = 10,
    GRID_HEIGHT = 20,
    INITIAL_DROP_TIME = 2.0,
    LEVEL_LINES_REQUIREMENT = 10,
    SPEED_INCREASE_FACTOR = 0.9,
    PREVIEW_SIZE = 4,   -- Size of the preview box (in grid cells)
    PREVIEW_SCALE = 0.8 -- Scale factor for preview pieces
}

Config.BUTTON_X = (Config.GRID_WIDTH * Config.GRID_SIZE) + 20
Config.BUTTON_Y = 20
Config.PREVIEW_X = Config.BUTTON_X                              -- Same X as button
Config.PREVIEW_Y = Config.BUTTON_Y + Config.BUTTON_HEIGHT + 100 -- Below score display
Config.HIGHSCORE_X = Config.BUTTON_X
Config.HIGHSCORE_Y = Config.PREVIEW_Y + (Config.PREVIEW_SIZE * Config.GRID_SIZE * Config.PREVIEW_SCALE) + 40

return Config