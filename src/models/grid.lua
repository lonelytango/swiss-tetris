-- src/models/grid.lua
local Config = require('src.constants.config')
local ParticleSystem = require('src.models.particle_system')

local Grid = {}

function Grid.new()
    local grid = {}
    for y = 1, Config.GRID_HEIGHT do
        grid[y] = {}
        for x = 1, Config.GRID_WIDTH do
            grid[y][x] = {occupied = false, color = nil}
        end
    end

    -- Add animation state
    grid.clearingLines = {}
    grid.animationTimer = 0
    grid.isAnimating = false
    grid.particles = ParticleSystem.new()
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
                   gridY > Config.GRID_HEIGHT then
                    return false
                end
                
                -- Only check collision if the position is within the grid and we're not animating
                if gridY > 0 and not grid.isAnimating and grid[gridY][gridX].occupied then
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
    local completeLines = {}
    
    -- Find complete lines
    for y = Config.GRID_HEIGHT, 1, -1 do
        local complete = true
        for x = 1, Config.GRID_WIDTH do
            if not grid[y][x].occupied then
                complete = false
                break
            end
        end
        if complete then
            table.insert(completeLines, y)
        end
    end
    
    if #completeLines > 0 then
        Grid.startClearAnimation(grid, completeLines)
    end
    
    return 0  -- Lines cleared will be returned by updateAnimation
end

function Grid.startClearAnimation(grid, completeLines)
    grid.clearingLines = completeLines
    grid.isAnimating = true
    grid.animationTimer = 0

    -- Create particles for each block in clearing lines
    for _, y in ipairs(completeLines) do
        for x = 1, Config.GRID_WIDTH do
            if grid[y][x].occupied then
                local px = (x - 1) * Config.GRID_SIZE + Config.GRID_SIZE / 2
                local py = (y - 1) * Config.GRID_SIZE + Config.GRID_SIZE / 2
                grid.particles:emit(px, py, grid[y][x].color, 30)
            end
        end
    end
end

function Grid.updateAnimation(grid, dt)

    -- Update particles even if not animating
    grid.particles:update(dt)

    if not grid.isAnimating then return 0 end
    
    grid.animationTimer = grid.animationTimer + dt
    local FLASH_DURATION = 0.5  -- Duration of the flash effect
    local DROP_DURATION = 0.3   -- Duration of the dropping animation
    
    -- After flash effect, perform the line clear
    if grid.animationTimer >= FLASH_DURATION then
        -- Clear the lines and drop blocks
        local linesCleared = #grid.clearingLines
        table.sort(grid.clearingLines)  -- Sort lines from top to bottom
        
        -- Count how many lines were cleared below each row
        local shiftAmount = {}
        for y = 1, Config.GRID_HEIGHT do
            shiftAmount[y] = 0
            for _, clearY in ipairs(grid.clearingLines) do
                if clearY > y then
                    shiftAmount[y] = shiftAmount[y] + 1
                end
            end
        end
        
        -- Move blocks down
        for y = Config.GRID_HEIGHT, 1, -1 do
            if not grid.clearingLines[y] then  -- If this line isn't being cleared
                local targetY = y + shiftAmount[y]
                if targetY <= Config.GRID_HEIGHT then
                    for x = 1, Config.GRID_WIDTH do
                        grid[targetY][x] = grid[y][x]
                    end
                end
            end
        end
        
        -- Clear top lines
        for i = 1, linesCleared do
            for x = 1, Config.GRID_WIDTH do
                grid[i][x] = {occupied = false, color = nil}
            end
        end
        
        -- Reset animation state
        grid.clearingLines = {}
        grid.isAnimating = false
        grid.animationTimer = 0
        
        return linesCleared
    end
    
    return 0
end

return Grid