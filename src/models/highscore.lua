-- src/models/highscore.lua
local HighScore = {}

local SAVE_FILE = "tetris_highscores.txt"
local MAX_SCORES = 5 -- Store top 5 scores

function HighScore.load()
  local scores = {}
  if love.filesystem.getInfo(SAVE_FILE) then
    local content = love.filesystem.read(SAVE_FILE)
    -- Simple line-by-line format: one score per line
    for score in content:gmatch("[^\r\n]+") do
      table.insert(scores, tonumber(score))
    end
  end
  return scores
end

function HighScore.save(scores)
  -- Convert scores to string format (one per line)
  local content = ""
  for _, score in ipairs(scores) do
    content = content .. tostring(score) .. "\n"
  end
  love.filesystem.write(SAVE_FILE, content)
end

function HighScore.isHighScore(score)
  local scores = HighScore.load()
  if #scores < MAX_SCORES then
    return true
  end
  for _, highScore in ipairs(scores) do
    if score > highScore then
      return true
    end
  end
  return false
end

function HighScore.addScore(newScore)
  local scores = HighScore.load()
  table.insert(scores, newScore)
  -- Sort in descending order
  table.sort(scores, function(a, b) return a > b end)
  -- Keep only top MAX_SCORES
  while #scores > MAX_SCORES do
    table.remove(scores)
  end
  HighScore.save(scores)
  return scores
end

return HighScore
