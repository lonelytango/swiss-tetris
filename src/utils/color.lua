local Color = {}

function Color.hexToRGB(hex)
  -- Remove '#' if present
  hex = hex:gsub("#", "")

  -- Convert hex to decimal and normalize to 0-1
  local r = tonumber(hex:sub(1, 2), 16) / 255
  local g = tonumber(hex:sub(3, 4), 16) / 255
  local b = tonumber(hex:sub(5, 6), 16) / 255

  return r, g, b
end

function Color.rgbToLove(r, g, b)
  -- Convert 0-255 values to 0-1
  return r / 255, g / 255, b / 255
end

return Color
