-- src/controllers/input.lua
local Config = require('src.constants.config')

local Input = {
    keyStates = {},
    INITIAL_DELAY = 0.2, -- Delay before starting repeat
}

function Input.isMouseOverComponent(x, y, component)
    return x >= component.X and x <= component.X + component.WIDTH and
        y >= component.Y and y <= component.Y + component.HEIGHT
end

function Input.isMouseOverQuitButton(x, y)
    return x >= Config.QUIT_BUTTON_X and x <= Config.QUIT_BUTTON_X + Config.BUTTON_WIDTH and
        y >= Config.QUIT_BUTTON_Y and y <= Config.QUIT_BUTTON_Y + Config.BUTTON_HEIGHT
end

function Input.handleKeyPressed(key, game)
	Input.keyStates[key] = {
		pressed = true,
		time = 0,
	}

	if key == "left" then
		game:movePiece(-1)
	elseif key == "right" then
		game:movePiece(1)
	elseif key == "down" then
		game:movePieceDown()
	elseif key == "space" then
		game:hardDrop()
	elseif key == "up" then
		game:rotatePiece()
	elseif key == "escape" then
		love.event.quit()
	elseif key == "q" then
		game:executeAction("gravity")
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
    if button == 1 then
        if Input.isMouseOverComponent(x, y, Config.COMPONENTS.RESET_BUTTON) then
			game:reset()
        elseif Input.isMouseOverComponent(x, y, Config.COMPONENTS.QUIT_BUTTON) then
			love.event.quit()
        end
    end
end

return Input