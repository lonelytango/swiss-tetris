-- src/utils/random_bag.lua

local RandomBag = {}
RandomBag.__index = RandomBag

function RandomBag.new(itemCount)
  local self = setmetatable({}, RandomBag)
  self.itemCount = itemCount
  self.currentBag = {}
  self.nextBag = {}
  self:initBags()
  return self
end

function RandomBag:shuffle(array)
  local counter = #array
  while counter > 1 do
    local index = love.math.random(counter)
    array[index], array[counter] = array[counter], array[index]
    counter = counter - 1
  end
  return array
end

function RandomBag:createBag()
  local bag = {}
  for i = 1, self.itemCount do
    table.insert(bag, i)
  end
  return self:shuffle(bag)
end

function RandomBag:initBags()
  self.currentBag = self:createBag()
  self.nextBag = self:createBag()
end

function RandomBag:next()
  if #self.currentBag == 0 then
    self.currentBag = self.nextBag
    self.nextBag = self:createBag()
  end
  return table.remove(self.currentBag, 1)
end

return RandomBag
