-- src/models/grid.lua
local Config = require('src.constants.config')

local Grid = {}

function Grid.new()
    local grid = {}
    for y = 1, Config.GRID_HEIGHT do
        grid[y] = {}
        for x = 1, Config.GRID_WIDTH do
            grid[y][x] = {occupied = false, color = nil}
        end
    end
    return grid
end

function Grid.isValidPosition(grid, piece)
    local pieceShape = piece.shape[1]
    for y = 1, #pieceShape do
        for x = 1, #pieceShape[1] do
            if pieceShape[y][x] == 1 then
                local gridX = piece.x + x
                local gridY = piece.y + y - 1
                
                if gridX < 1 or gridX > Config.GRID_WIDTH or
                   gridY > Config.GRID_HEIGHT or
                   (gridY > 0 and grid[gridY][gridX].occupied) then
                    return false
                end
            end
        end
    end
    return true
end

function Grid.lockPiece(grid, piece)
    local pieceShape = piece.shape[1]
    for y = 1, #pieceShape do
        for x = 1, #pieceShape[1] do
            if pieceShape[y][x] == 1 then
                local gridY = piece.y + y - 1
                if gridY > 0 then
                    grid[gridY][piece.x + x] = {
                        occupied = true,
                        color = piece.shape.color
                    }
                end
            end
        end
    end
end

function Grid.clearLines(grid)
    local linesCleared = 0
    local y = Config.GRID_HEIGHT
    
    while y > 0 do
        local complete = true
        for x = 1, Config.GRID_WIDTH do
            if not grid[y][x].occupied then
                complete = false
                break
            end
        end
        
        if complete then
            linesCleared = linesCleared + 1
            
            -- Move all lines above this one down
            for moveY = y, 2, -1 do
                for x = 1, Config.GRID_WIDTH do
                    grid[moveY][x] = grid[moveY-1][x]
                end
            end
            -- Clear top line
            for x = 1, Config.GRID_WIDTH do
                grid[1][x] = {occupied = false, color = nil}
            end
        else
            y = y - 1
        end
    end
    
    return linesCleared
end

return Grid