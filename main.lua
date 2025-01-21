-- main.lua
local Game = require('src.controllers.game')
local Input = require('src.controllers.input')
local Renderer = require('src.views.renderer')

local gameState

function love.load()
    gameState = Game:new()
    gameState:init()
end

function love.update(dt)
    gameState:update(dt)
end

function love.draw()
    Renderer.draw(gameState)
end

function love.keypressed(key)
    Input.handleKeyPressed(key, gameState)
end

function love.mousepressed(x, y, button)
    Input.handleMousePressed(x, y, button, gameState)
end