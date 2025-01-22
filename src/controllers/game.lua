-- src/controllers/game.lua
local Config = require('src.constants.config')
local Grid = require('src.models.grid')
local Piece = require('src.models.piece')
local HighScore = require('src.models.highscore')

local Game = {
    grid = nil,
    currentPiece = nil,
    nextPiece = nil, -- Add next piece
    score = 0,
    level = 1,
    dropTimer = 0,
    gameOver = false,
    linesForNextLevel = 0,
    currentDropTime = Config.INITIAL_DROP_TIME,
    highScores = {},
    newHighScore = false
}

function Game:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Game:init()
    self.grid = Grid.new()
    self.nextPiece = Piece.new()
    self.currentPiece = nil
    self.highScores = HighScore.load()
    self:spawnNewPiece()
end

function Game:reset()
    self.grid = Grid.new()
    self.score = 0
    self.level = 1
    self.dropTimer = 0
    self.gameOver = false
    self.linesForNextLevel = 0
    self.currentDropTime = Config.INITIAL_DROP_TIME
    self.nextPiece = Piece.new()
    self.currentPiece = nil
    self:spawnNewPiece()
end

function Game:spawnNewPiece()
    self.currentPiece = {
        shape = self.nextPiece.shape,
        x = math.floor(Config.GRID_WIDTH / 2) - 1,
        y = 1
    }
    -- Generate new next piece
    self.nextPiece = Piece.new()
    
    if not Grid.isValidPosition(self.grid, self.currentPiece) then
        self.gameOver = true
        -- Check for high score when game ends
        if HighScore.isHighScore(self.score) then
            self.highScores = HighScore.addScore(self.score)
            self.newHighScore = true
        end
    end
end

function Game:update(dt)
    if self.gameOver then return end
    
    -- Update grid animations first
    local linesCleared = Grid.updateAnimation(self.grid, dt)
    if linesCleared > 0 then
        self.linesForNextLevel = self.linesForNextLevel + linesCleared
        self:updateScore(linesCleared)
        
        if self.linesForNextLevel >= Config.LEVEL_LINES_REQUIREMENT then
            self:levelUp()
        end
    end
    
    -- Only update drop timer if not animating
    if not self.grid.isAnimating then
        self.dropTimer = self.dropTimer + dt
        if self.dropTimer >= self.currentDropTime then
            self.dropTimer = 0
            self:movePieceDown()
        end
    end
end

function Game:movePieceDown()
    self.currentPiece.y = self.currentPiece.y + 1
    if not Grid.isValidPosition(self.grid, self.currentPiece) then
        self.currentPiece.y = self.currentPiece.y - 1
        Grid.lockPiece(self.grid, self.currentPiece)
        self:checkLines()
        self:spawnNewPiece()
    end
end

function Game:movePiece(direction)
    if self.gameOver then return end
    
    local oldX = self.currentPiece.x
    self.currentPiece.x = self.currentPiece.x + direction
    
    if not Grid.isValidPosition(self.grid, self.currentPiece) then
        self.currentPiece.x = oldX
    end
end

function Game:rotatePiece()
    if self.gameOver then return end
    
    local oldShape = self.currentPiece.shape[1]
    self.currentPiece.shape[1] = Piece.rotate(self.currentPiece)
    
    if not Grid.isValidPosition(self.grid, self.currentPiece) then
        self.currentPiece.shape[1] = oldShape
    end
end

function Game:hardDrop()
    if self.gameOver then return end
    
    while Grid.isValidPosition(self.grid, self.currentPiece) do
        self.currentPiece.y = self.currentPiece.y + 1
    end
    self.currentPiece.y = self.currentPiece.y - 1
    Grid.lockPiece(self.grid, self.currentPiece)
    self:checkLines()
    self:spawnNewPiece()
end

function Game:checkLines()
    local linesCleared = Grid.clearLines(self.grid)
    
    if linesCleared > 0 then
        self.linesForNextLevel = self.linesForNextLevel + linesCleared
        self:updateScore(linesCleared)
        
        if self.linesForNextLevel >= Config.LEVEL_LINES_REQUIREMENT then
            self:levelUp()
        end
    end
end

function Game:updateScore(linesCleared)
    self.score = self.score + (100 * linesCleared * self.level)
    if linesCleared >= 4 then
        self.score = self.score + (400 * self.level)
    elseif linesCleared >= 3 then
        self.score = self.score + (200 * self.level)
    elseif linesCleared >= 2 then
        self.score = self.score + (100 * self.level)
    end
end

function Game:levelUp()
    self.level = self.level + 1
    self.linesForNextLevel = self.linesForNextLevel - Config.LEVEL_LINES_REQUIREMENT
    self.currentDropTime = Config.INITIAL_DROP_TIME * (Config.SPEED_INCREASE_FACTOR ^ (self.level - 1))
    if self.currentDropTime < 0.1 then
        self.currentDropTime = 0.1
    end
end

function Game:getShadowY()
    local originalY = self.currentPiece.y
    local shadowY = originalY
    
    while true do
        shadowY = shadowY + 1
        self.currentPiece.y = shadowY
        if not Grid.isValidPosition(self.grid, self.currentPiece) then
            shadowY = shadowY - 1
            break
        end
    end
    
    self.currentPiece.y = originalY
    return shadowY
end

return Game