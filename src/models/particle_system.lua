local ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem.new()
    local system = {
        particles = {},
        active = false
    }
    setmetatable(system, ParticleSystem)
    return system
end

local function createParticle(x, y, color)
    local angle = love.math.random() * math.pi * 2
    local speed = love.math.random(100, 200)
    
    return {
        x = x,
        y = y,
        vx = math.cos(angle) * speed,
        vy = math.sin(angle) * speed,
        life = love.math.random(0.3, 0.6),
        maxLife = love.math.random(0.3, 0.6),
        color = color,
        size = love.math.random(2, 4),
        rotation = love.math.random() * math.pi * 2,
        rotationSpeed = love.math.random(-10, 10)
    }
end

function ParticleSystem:emit(x, y, color, count)
    count = count or 10
    self.active = true
    
    for i = 1, count do
        table.insert(self.particles, createParticle(x, y, color))
    end
end

function ParticleSystem:update(dt)
    if not self.active then return end
    
    for i = #self.particles, 1, -1 do
        local p = self.particles[i]
        
        -- Update position
        p.x = p.x + p.vx * dt
        p.y = p.y + p.vy * dt
        
        -- Add gravity
        p.vy = p.vy + 500 * dt
        
        -- Update rotation
        p.rotation = p.rotation + p.rotationSpeed * dt
        
        -- Update life
        p.life = p.life - dt
        
        -- Remove dead particles
        if p.life <= 0 then
            table.remove(self.particles, i)
        end
    end
    
    -- Deactivate system if no particles remain
    if #self.particles == 0 then
        self.active = false
    end
end

function ParticleSystem:draw()
    if not self.active then return end
    
    for _, p in ipairs(self.particles) do
        love.graphics.push()
        
        -- Set color with fade out
        love.graphics.setColor(
            p.color[1],
            p.color[2],
            p.color[3],
            p.life / p.maxLife
        )
        
        -- Draw particle
        love.graphics.translate(p.x, p.y)
        love.graphics.rotate(p.rotation)
        love.graphics.rectangle("fill", -p.size/2, -p.size/2, p.size, p.size)
        
        love.graphics.pop()
    end
end

return ParticleSystem