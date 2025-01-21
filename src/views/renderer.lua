-- src/views/renderer.lua
local Config = require('src.constants.config')
local Input = require('src.controllers.input')

local Renderer = {}

function Renderer.drawGrid(grid)
    for y = 1, Config.GRID_HEIGHT do
        for x = 1, Config.GRID_WIDTH do
            -- Draw grid lines
            love.graphics.setColor(0.3, 0.3, 0.3)
            love.graphics.rectangle("line", 
                (x-1) * Config.GRID_SIZE, 
                (y-1) * Config.GRID_SIZE, 
                Config.GRID_SIZE, 
                Config.GRID_SIZE)
            
            -- Draw locked pieces
            if grid[y][x].occupied then
                love.graphics.setColor(grid[y][x].color)
                love.graphics.rectangle("fill", 
                    (x-1) * Config.GRID_SIZE, 
                    (y-1) * Config.GRID_SIZE, 
                    Config.GRID_SIZE-1, 
                    Config.GRID_SIZE-1)
                    
                -- Add 3D effect
                love.graphics.setColor(
                    grid[y][x].color[1] * 1.2,
                    grid[y][x].color[2] * 1.2,
                    grid[y][x].color[3] * 1.2
                )
                love.graphics.line(
                    (x-1) * Config.GRID_SIZE,
                    (y-1) * Config.GRID_SIZE,
                    (x-1) * Config.GRID_SIZE + Config.GRID_SIZE-1,
                    (y-1) * Config.GRID_SIZE
                )
                love.graphics.line(
                    (x-1) * Config.GRID_SIZE,
                    (y-1) * Config.GRID_SIZE,
                    (x-1) * Config.GRID_SIZE,
                    (y-1) * Config.GRID_SIZE + Config.GRID_SIZE-1
                )
            end
        end
    end
end

function Renderer.drawCurrentPiece(piece, shadowY)
    if not piece then return end
    
    local pieceShape = piece.shape[1]
    
    -- Draw shadow piece
    love.graphics.setColor(piece.shape.color[1], 
                         piece.shape.color[2], 
                         piece.shape.color[3], 
                         0.3)
    for y = 1, #pieceShape do
        for x = 1, #pieceShape[1] do
            if pieceShape[y][x] == 1 then
                love.graphics.rectangle("fill",
                    (piece.x + x - 1) * Config.GRID_SIZE,
                    (shadowY + y - 2) * Config.GRID_SIZE,
                    Config.GRID_SIZE-1,
                    Config.GRID_SIZE-1)
            end
        end
    end
    
    -- Draw current piece with 3D effect
    love.graphics.setColor(piece.shape.color)
    for y = 1, #pieceShape do
        for x = 1, #pieceShape[1] do
            if pieceShape[y][x] == 1 then
                -- Main block
                love.graphics.rectangle("fill",
                    (piece.x + x - 1) * Config.GRID_SIZE,
                    (piece.y + y - 2) * Config.GRID_SIZE,
                    Config.GRID_SIZE-1,
                    Config.GRID_SIZE-1)
                
                -- Highlight edges for 3D effect
                love.graphics.setColor(
                    piece.shape.color[1] * 1.2,
                    piece.shape.color[2] * 1.2,
                    piece.shape.color[3] * 1.2
                )
                love.graphics.line(
                    (piece.x + x - 1) * Config.GRID_SIZE,
                    (piece.y + y - 2) * Config.GRID_SIZE,
                    (piece.x + x - 1) * Config.GRID_SIZE + Config.GRID_SIZE-1,
                    (piece.y + y - 2) * Config.GRID_SIZE
                )
                love.graphics.line(
                    (piece.x + x - 1) * Config.GRID_SIZE,
                    (piece.y + y - 2) * Config.GRID_SIZE,
                    (piece.x + x - 1) * Config.GRID_SIZE,
                    (piece.y + y - 2) * Config.GRID_SIZE + Config.GRID_SIZE-1
                )
            end
        end
    end
end

function Renderer.drawUI(score, level, gameOver)
    -- Draw score and level
    love.graphics.setColor(1, 1, 1)
    local font = love.graphics.getFont()
    local scoreText = "Score: " .. score
    local levelText = "Level: " .. level
    
    love.graphics.print(scoreText, 
        Config.BUTTON_X, 
        Config.BUTTON_Y + Config.BUTTON_HEIGHT + 20, 
        0, 
        1.2, 
        1.2)
        
    love.graphics.print(levelText,
        Config.BUTTON_X,
        Config.BUTTON_Y + Config.BUTTON_HEIGHT + 60,
        0,
        1.2,
        1.2)
        
    -- Draw game over message if needed
    if gameOver then
        love.graphics.print("Game Over!", 
            Config.GRID_WIDTH * Config.GRID_SIZE / 2 - 30, 
            Config.GRID_HEIGHT * Config.GRID_SIZE / 2)
    end
end

function Renderer.drawButton()
    local mouseX, mouseY = love.mouse.getPosition()
    local isHovered = Input.isMouseOverButton(mouseX, mouseY)
    
    -- Button background
    if isHovered then
        love.graphics.setColor(0.8, 0.8, 0.8)
    else
        love.graphics.setColor(0.7, 0.7, 0.7)
    end
    love.graphics.rectangle("fill", 
        Config.BUTTON_X, 
        Config.BUTTON_Y, 
        Config.BUTTON_WIDTH, 
        Config.BUTTON_HEIGHT)
    
    -- Button border
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("line", 
        Config.BUTTON_X, 
        Config.BUTTON_Y, 
        Config.BUTTON_WIDTH, 
        Config.BUTTON_HEIGHT)
    
    -- Button text
    love.graphics.setColor(0, 0, 0)
    local font = love.graphics.getFont()
    local text = "Reset Game"
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()
    love.graphics.print(text,
        Config.BUTTON_X + (Config.BUTTON_WIDTH - textWidth) / 2,
        Config.BUTTON_Y + (Config.BUTTON_HEIGHT - textHeight) / 2)
end

function Renderer.draw(gameState)
    -- Draw the game grid
    Renderer.drawGrid(gameState.grid)
    
    -- Draw current piece and shadow if game is not over
    if not gameState.gameOver then
        local shadowY = gameState:getShadowY()
        Renderer.drawCurrentPiece(gameState.currentPiece, shadowY)
    end
    
    -- Draw UI elements
    Renderer.drawUI(gameState.score, gameState.level, gameState.gameOver)
    Renderer.drawButton()
    
    -- Reset color
    love.graphics.setColor(1, 1, 1)
end

return Renderer