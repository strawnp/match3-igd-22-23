---@diagnostic disable: missing-parameter
--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}
paletteColors = {
  [1] = {
    ['r'] = 99,
    ['g'] = 155,
    ['b'] = 255
  },
  [2] = {
    ['r'] = 106,
    ['g'] = 190,
    ['b'] = 47
  },
  [3] = {
    ['r'] = 217,
    ['g'] = 87,
    ['b'] = 99
  },
  [4] = {
    ['r'] = 215,
    ['g'] = 123,
    ['b'] = 186
  },
  [5] = {
    ['r'] = 251,
    ['g'] = 242,
    ['b'] = 54
  }
}

function Tile:init(x, y, color, variety)
  -- board positions
  self.gridX = x
  self.gridY = y

  -- coordinate positions
  self.x = (self.gridX - 1) * 32
  self.y = (self.gridY - 1) * 32

  -- tile appearance/points
  self.color = color
  self.variety = variety
    -- particle system
  self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)
  self.psystem:setParticleLifetime(0.5, 1)
  self.psystem:setLinearAcceleration(-15, 0, 15, 80)
  self.psystem:setEmissionArea('normal', 10, 10)
end

function Tile:match()
  self.psystem:setColors(
    paletteColors[1].r / 255,
    paletteColors[1].g / 255,
    paletteColors[1].b / 255,
    1,
    paletteColors[2].r / 255,
    paletteColors[2].g / 255,
    paletteColors[2].b / 255,
    0
  )
  self.psystem:emit(64)
end 

function Tile:update(dt)
  self.psystem:update(dt)
end 

function Tile:render(x, y)
  -- draw shadow
  love.graphics.setColor(34, 32, 52, 255)
  love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
    self.x + x + 2, self.y + y + 2)

    -- draw tile itself
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
    self.x + x, self.y + y)
end 

function Tile:renderParticles()
    love.graphics.draw(self.psystem, self.x, self.y)
end 