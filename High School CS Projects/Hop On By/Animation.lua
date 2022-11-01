Animation = {}
Animation.__index = Animation

local animation = nil

function Animation:create(parameter)
    local this = {
        sprite = parameter.char,

        frames = parameter.frames or {},

        time = parameter.interval or 0.05,

        timer = 0,

        currentFrame = 1,

        animation = animation
    }

    setmetatable(this, self)

    return this
end

function Animation:getcurrentFrame()
    return self.frames[self.currentFrame]
end

function Animation:restart()
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(dt)
    self.timer = self.timer + dt
    self.animation = self.animation

    --rotate through animations

    while self.timer > self.time do
        self.timer = self.timer - self.time
        self.currentFrame = (self.currentFrame + 1) %  #self.frames
        if self.currentFrame == 0 then 
            self.currentFrame = 1
        end
    end
end