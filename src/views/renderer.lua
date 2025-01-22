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
            
            -- Check if this line is being cleared
            local isClearing = false
            if grid.clearingLines then
                for _, clearY in ipairs(grid.clearingLines) do
                    if clearY == y then
                        isClearing = true
                        break
                    end
                end
            end
            
            -- Draw locked pieces with animation effects
            if grid[y][x].occupied then
                local color = grid[y][x].color
                if isClearing then
                    -- Flash effect for clearing lines
                    local flashIntensity = math.abs(math.sin((grid.animationTimer or 0) * 15))
                    love.graphics.setColor(
                        1,
                        1,
                        1,
                        flashIntensity
                    )
                else
                    love.graphics.setColor(color)
                end
                
                love.graphics.rectangle("fill", 
                    (x-1) * Config.GRID_SIZE, 
                    (y-1) * Config.GRID_SIZE, 
                    Config.GRID_SIZE-1, 
                    Config.GRID_SIZE-1)
                    
                -- Add 3D effect (only for non-clearing blocks)
                if not isClearing then
                    love.graphics.setColor(
                        color[1] * 1.2,
                        color[2] * 1.2,
                        color[3] * 1.2
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

function Renderer.drawPreviewPiece(piece)
    if not piece then return end

    local pieceShape = piece.shape[1]
    local pieceWidth = #pieceShape[1]
    local pieceHeight = #pieceShape

    -- Calculate center position for the preview piece
    local centerX = Config.PREVIEW_X + (Config.PREVIEW_SIZE * Config.GRID_SIZE * Config.PREVIEW_SCALE) / 2
    local centerY = Config.PREVIEW_Y + (Config.PREVIEW_SIZE * Config.GRID_SIZE * Config.PREVIEW_SCALE) / 2

    -- Draw preview box background
    love.graphics.setColor(0.1, 0.1, 0.1, 0.3)
    love.graphics.rectangle("fill",
        Config.PREVIEW_X,
        Config.PREVIEW_Y,
        Config.PREVIEW_SIZE * Config.GRID_SIZE * Config.PREVIEW_SCALE,
        Config.PREVIEW_SIZE * Config.GRID_SIZE * Config.PREVIEW_SCALE
    )

    -- Draw "Next Piece" text
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Next Piece",
        Config.PREVIEW_X,
        Config.PREVIEW_Y - 25,
        0,
        1.2,
        1.2
    )

    -- Draw the preview piece
    love.graphics.setColor(piece.shape.color)
    for y = 1, #pieceShape do
        for x = 1, #pieceShape[1] do
            if pieceShape[y][x] == 1 then
                -- Calculate offset to center the piece
                local offsetX = centerX - (pieceWidth * Config.GRID_SIZE * Config.PREVIEW_SCALE) / 2
                local offsetY = centerY - (pieceHeight * Config.GRID_SIZE * Config.PREVIEW_SCALE) / 2

                -- Draw each block of the piece
                love.graphics.rectangle("fill",
                    offsetX + (x - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE,
                    offsetY + (y - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE,
                    Config.GRID_SIZE * Config.PREVIEW_SCALE - 1,
                    Config.GRID_SIZE * Config.PREVIEW_SCALE - 1
                )

                -- Add 3D effect
                love.graphics.setColor(
                    piece.shape.color[1] * 1.2,
                    piece.shape.color[2] * 1.2,
                    piece.shape.color[3] * 1.2
                )
                love.graphics.line(
                    offsetX + (x - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE,
                    offsetY + (y - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE,
                    offsetX + (x - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE + Config.GRID_SIZE * Config
                    .PREVIEW_SCALE - 1,
                    offsetY + (y - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE
                )
                love.graphics.line(
                    offsetX + (x - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE,
                    offsetY + (y - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE,
                    offsetX + (x - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE,
                    offsetY + (y - 1) * Config.GRID_SIZE * Config.PREVIEW_SCALE + Config.GRID_SIZE * Config
                    .PREVIEW_SCALE - 1
                )
            end
        end
    end
end
function Renderer.drawHighScores(scores, currentScore, gameOver)
    -- Draw high scores header
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("HIGH SCORES",
        Config.HIGHSCORE_X,
        Config.HIGHSCORE_Y,
        0,
        1.2,
        1.2)

    -- Draw each high score
    for i, score in ipairs(scores) do
        -- Determine if this score is the new high score that was just achieved
        local isNewHighScore = gameOver and currentScore == score and
            (not scores[i + 1] or currentScore > scores[i + 1])

        -- Set color (yellow for new high score, white for others)
        if isNewHighScore then
            love.graphics.setColor(1, 1, 0) -- Yellow
        else
            love.graphics.setColor(1, 1, 1) -- White
        end

        -- Draw score with rank
        love.graphics.print(
            string.format("%d.  %d", i, score),
            Config.HIGHSCORE_X,
            Config.HIGHSCORE_Y + (i * 25) + 30,
            0,
            1,
            1
        )
    end

    -- If there are no scores yet, show a message
    if #scores == 0 then
        love.graphics.setColor(0.7, 0.7, 0.7) -- Gray color
        love.graphics.print(
            "No scores yet!",
            Config.HIGHSCORE_X,
            Config.HIGHSCORE_Y + 30,
            0,
            1,
            1
        )
    end

    -- Reset color
    love.graphics.setColor(1, 1, 1)
end
function Renderer.draw(gameState)
    -- Draw the game grid
    Renderer.drawGrid(gameState.grid)
    
    -- Draw current piece and shadow if game is not over
    if not gameState.gameOver then
        local shadowY = gameState:getShadowY()
        Renderer.drawCurrentPiece(gameState.currentPiece, shadowY)
    end
    -- Draw preview piece
    Renderer.drawPreviewPiece(gameState.nextPiece)
    
    -- Draw UI elements
    Renderer.drawUI(gameState.score, gameState.level, gameState.gameOver)
    Renderer.drawHighScores(gameState.highScores, gameState.score, gameState.gameOver)
    Renderer.drawButton()
    
    -- Reset color
    love.graphics.setColor(1, 1, 1)
end

return Renderer