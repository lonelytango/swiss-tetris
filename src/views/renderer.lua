-- src/views/renderer.lua
local Config = require('src.constants.config')
local Input = require('src.controllers.input')
local Theme = require('src.themes.theme')
local Color = require('src.utils.color')

local Renderer = {}

local function drawButton(component, text, colors)
    local mouseX, mouseY = love.mouse.getPosition()
    local isHovered = Input.isMouseOverComponent(mouseX, mouseY, component)

    -- Button background
    love.graphics.setColor(isHovered and colors.hover or colors.normal)
    love.graphics.rectangle("fill",
        component.X,
        component.Y,
        component.WIDTH,
        component.HEIGHT)

    -- Button border
    love.graphics.setColor(colors.border)
    love.graphics.rectangle("line",
        component.X,
        component.Y,
        component.WIDTH,
        component.HEIGHT)

    -- Button text
    love.graphics.setColor(colors.text)
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()
    love.graphics.print(text,
        component.X + (component.WIDTH - textWidth) / 2,
        component.Y + (component.HEIGHT - textHeight) / 2)
end
function Renderer.drawGrid(grid)
    for y = 1, Config.GRID_HEIGHT do
        for x = 1, Config.GRID_WIDTH do
            -- Draw grid lines
            love.graphics.setColor(Theme.current.grid)
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
    love.graphics.setColor(piece.color[1],
        piece.color[2],
        piece.color[3],
        0.4)
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
    love.graphics.setColor(piece.color)
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
                    piece.color[1] * 1.2,
                    piece.color[2] * 1.2,
                    piece.color[3] * 1.2
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
    -- Draw score
    love.graphics.setColor(1, 1, 1)
    local scoreText = "Score: " .. score
    love.graphics.print(scoreText,
        Config.COMPONENTS.SCORE.X,
        Config.COMPONENTS.SCORE.Y,
        0,
        1.2,
        1.2)

    -- Draw level
    local levelText = "Level: " .. level
    love.graphics.print(levelText,
        Config.COMPONENTS.LEVEL.X,
        Config.COMPONENTS.LEVEL.Y,
        0,
        1.2,
        1.2)

    -- Draw game over message if needed
    if gameOver then
        love.graphics.print("Game Over!",
            Config.GAME_AREA.WIDTH / 2 - 30,
            Config.GAME_AREA.HEIGHT / 2)
    end
end

function Renderer.drawButtons()
    -- Draw Reset button
    drawButton(
        Config.COMPONENTS.RESET_BUTTON,
        "Reset Game",
        {
            normal = { 0.7, 0.7, 0.7 },
            hover = { 0.8, 0.8, 0.8 },
            border = { 0.3, 0.3, 0.3 },
            text = { 0, 0, 0 }
        }
    )

    -- Draw Quit button
    drawButton(
        Config.COMPONENTS.QUIT_BUTTON,
        "Quit Game",
        {
            normal = { 0.7, 0.1, 0.1 },
            hover = { 0.8, 0.2, 0.2 },
            border = { 0.3, 0.3, 0.3 },
            text = { 1, 1, 1 }
        }
    )
end

function Renderer.drawPreviewPiece(piece)
    if not piece then return end

    local component = Config.COMPONENTS.NEXT_PIECE
    local pieceShape = piece.shape[1]

    -- Draw preview box background
    love.graphics.setColor(0.1, 0.1, 0.1, 0.3)
    love.graphics.rectangle("fill",
        component.X,
        component.Y,
        component.WIDTH,
        component.HEIGHT
    )

    -- Draw "Next Piece" text
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Next Piece",
        component.X,
        component.Y,
        0,
        1.2,
        1.2
    )

    -- Calculate piece size and position
    local gridSize = component.WIDTH / Config.PREVIEW_SIZE / 2
    local pieceWidth = #pieceShape[1]
    local pieceHeight = #pieceShape

    -- Center the piece in the preview box
    local offsetX = component.X + (component.WIDTH - pieceWidth * gridSize) / 2
    local offsetY = component.Y + 20 + (component.HEIGHT - pieceHeight * gridSize) / 2

    -- Draw the piece
    love.graphics.setColor(piece.color)
    for y = 1, #pieceShape do
        for x = 1, #pieceShape[1] do
            if pieceShape[y][x] == 1 then
                love.graphics.rectangle("fill",
                    offsetX + (x - 1) * gridSize,
                    offsetY + (y - 1) * gridSize,
                    gridSize - 1,
                    gridSize - 1
                )
            end
        end
    end
end

function Renderer.drawHighScores(scores, currentScore, gameOver)
    local component = Config.COMPONENTS.HIGH_SCORES
    -- Draw high scores header
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("HIGH SCORES",
        component.X,
        component.Y,
        0,
        1.2,
        1.2)

    -- Draw each high score
    for i, score in ipairs(scores) do
        local isNewHighScore = gameOver and currentScore == score and
            (not scores[i + 1] or currentScore > scores[i + 1])

        love.graphics.setColor(isNewHighScore and { 1, 1, 0 } or { 1, 1, 1 })
        love.graphics.print(
            string.format("%d.  %d", i, score),
            component.X,
            component.Y + (i * 25) + 30,
            0,
            1,
            1
        )
    end

    if #scores == 0 then
        love.graphics.setColor(0.7, 0.7, 0.7)
        love.graphics.print(
            "No scores yet!",
            component.X,
            component.Y + 30,
            0,
            1,
            1
        )
    end
end

function Renderer.drawQuitButton()
    local mouseX, mouseY = love.mouse.getPosition()
    local isHovered = Input.isMouseOverQuitButton(mouseX, mouseY)

    -- Button background
    if isHovered then
        love.graphics.setColor(0.8, 0.2, 0.2) -- Lighter red when hovered
    else
        love.graphics.setColor(0.7, 0.1, 0.1) -- Dark red normally
    end
    love.graphics.rectangle("fill",
        Config.QUIT_BUTTON_X,
        Config.QUIT_BUTTON_Y,
        Config.BUTTON_WIDTH,
        Config.BUTTON_HEIGHT)

    -- Button border
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("line",
        Config.QUIT_BUTTON_X,
        Config.QUIT_BUTTON_Y,
        Config.BUTTON_WIDTH,
        Config.BUTTON_HEIGHT)

    -- Button text
    love.graphics.setColor(1, 1, 1) -- White text
    local font = love.graphics.getFont()
    local text = "Quit Game"
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()
    love.graphics.print(text,
        Config.QUIT_BUTTON_X + (Config.BUTTON_WIDTH - textWidth) / 2,
        Config.QUIT_BUTTON_Y + (Config.BUTTON_HEIGHT - textHeight) / 2)
end

function Renderer.draw(gameState)
    -- Set background color
    love.graphics.setColor(Theme.current.background)
    love.graphics.rectangle("fill", 0, 0, Config.WINDOW.WIDTH, Config.WINDOW.HEIGHT)
    -- Draw the game grid
    Renderer.drawGrid(gameState.grid)

    -- Draw current piece and shadow if game is not over
    if not gameState.gameOver then
        local shadowY = gameState:getShadowY()
        Renderer.drawCurrentPiece(gameState.currentPiece, shadowY)
    end

    -- Draw UI elements
    Renderer.drawUI(gameState.score, gameState.level, gameState.gameOver)
    Renderer.drawPreviewPiece(gameState.nextPiece)
    Renderer.drawHighScores(gameState.highScores, gameState.score, gameState.gameOver)
    Renderer.drawButtons()

    -- Draw particles
    gameState.grid.particles:draw()
    -- Reset color
    love.graphics.setColor(1, 1, 1)
end

return Renderer