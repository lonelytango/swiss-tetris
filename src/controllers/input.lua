-- src/controllers/input.lua
local Config = require('src.constants.config')

local Input = {
    keyStates = {},
    INITIAL_DELAY = 0.2, -- Delay before starting repeat
}

function Input.isMouseOverButton(x, y)
    return x >= Config.BUTTON_X and x <= Config.BUTTON_X + Config.BUTTON_WIDTH and
           y >= Config.BUTTON_Y and y <= Config.BUTTON_Y + Config.BUTTON_HEIGHT
end

function Input.handleKeyPressed(key, game)
    Input.keyStates[key] = {
        pressed = true,
        time = 0
    }

    if key == "left" then
        game:movePiece(-1)
    elseif key == "right" then
        game:movePiece(1)
    elseif key == "down" then
        game:hardDrop()
    elseif key == "up" then
        game:rotatePiece()
    end
end

function Input.update(dt, game)
    -- Handle held keys
    for key, state in pairs(Input.keyStates) do
        state.time = state.time + dt
        
        if state.time >= Input.INITIAL_DELAY then
            if key == "left" then
                game:movePiece(-1)
            elseif key == "right" then
                game:movePiece(1)
            end
        end
    end
end

function Input.handleMousePressed(x, y, button, game)
    if button == 1 and Input.isMouseOverButton(x, y) then
        game:reset()
    end
end

return Input