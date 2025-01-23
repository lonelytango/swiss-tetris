local Config = require("src.constants.config")

local GravityAction = {
	name = "gravity",
}

function GravityAction.execute(grid)
	local moved = false
	-- Start from bottom-1 (skip bottom row) and move up
	for y = Config.GRID_HEIGHT - 1, 1, -1 do
		for x = 1, Config.GRID_WIDTH do
			if grid[y][x].occupied then
				-- Check if there's empty space below
				local currentY = y
				while currentY < Config.GRID_HEIGHT and not grid[currentY + 1][x].occupied do
					-- Move block down
					grid[currentY + 1][x] = grid[currentY][x]
					grid[currentY][x] = { occupied = false, color = nil }
					currentY = currentY + 1
					moved = true
				end
			end
		end
	end
	return moved
end

return GravityAction
