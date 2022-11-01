require 'Animation'

--creating dino table and reference
Dino = {}
Dino.__index = Dino

--initialising variables
local WALK_SPEED = -300
local JUMP = 80
local MINI_JUMP = 55
local diff = 10

--dino object creation
function Dino:create(map)
    local this = {
        x = 0,
        y = 0,
        width = 32,
        height = 32,

        offsetX = 16,
        offsetY = 16,

        map = map,
        char = love.graphics.newImage('NES - Jurassic Park - Velociraptor.png'),

        state = 'idle',

        direction = 'left',

        currentframes = nil,

        flagframes = nil,

        animation = nil,

        flaganimation = nil,
        
        dx = 0,
        dy = 0,

        animations = {},

        winflag = false,

        flagsheet = love.graphics.newImage("PC Computer - Mega Man Maker - Checkpoint Flag re.png"),

        diff = 10
    }

    --set intial coords
    this.y = map.tileheight * (math.floor(map.mapHeight / 3) - 4) - this.height
    this.x = map.tilewidth * 10

    this.frames = {
        love.graphics.newQuad(32, 32, 32, 32, this.char:getDimensions())
    }


    --fill statewise animations
    this.animations = {
        ['idle'] = Animation:create( {
            char = this.char,
            frames = {
                love.graphics.newQuad(64, 64, 32, 32, this.char:getDimensions())
            }
        }),

        ['walking'] = Animation:create( {
            char = this.char,
            frames = {
            love.graphics.newQuad(0, 32, 32, 32, this.char:getDimensions()),
            love.graphics.newQuad(32, 32, 32, 32, this.char:getDimensions()),
            love.graphics.newQuad(64, 64, 32, 32, this.char:getDimensions()),
            },
        
        
            interval = 0.15
        
        }),


        ['jumping'] = Animation:create({
            char = this.char,
            frames = {
                love.graphics.newQuad(0, 0, 32, 32, this.char:getDimensions()),
                love.graphics.newQuad(32, 0, 32, 32, this.char:getDimensions()),
                love.graphics.newQuad(128, 0, 32, 32, this.char:getDimensions())
            },

            interval = 0.5
        }),

    }


    --fill flag animations
    this.flaganimations = {
        --possible, thought unnecessary
        --[[['flag'] = Animation:create({
            char = this.flagsheet,
            frames = {
                --[[love.graphics.newQuad(12,25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(24,25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(36,25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(48,25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(60,25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(72,25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(84,25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(96,25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(108,25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(120, 25, 12, 25, this.flagsheet:getDimensions()),
                love.graphics.newQuad(132, 25, 12, 25, this.flagsheet:getDimensions())
            },

            interval = 0.05
        }),]]

        ['risen'] = Animation:create({
            char = this.flagsheet,
            frames = {
                love.graphics.newQuad(40, 25, 12, 25, this.flagsheet:getDimensions())
            }
        })
    }
    

    --update intial frames
    this.animation = this.animations['idle']
    this.currentframes = this.animation:getcurrentFrame()

    this.flaganimation = this.flaganimations['risen']
    this.flagframes = this.animation:getcurrentFrame()

    --dino behavious states
    this.behaviours = {
        ['idle'] = function (dt)

            if love.keyboard.isDown("right") then
                this.direction = 'right'
                this.dx = WALK_SPEED
                this.state = 'walking'
                this.animations['walking']:restart()
                this.animation = this.animations['walking']
            elseif love.keyboard.isDown("left") then
                this.direction = "left"
                this.dx = -WALK_SPEED
                this.state = 'walking'
                this.animations['walking']:restart()
                this.animation = this.animations['walking']   
            else
                this.dx = 0
            end

            function love.keypressed(key, scancode, isrepeat)
                if key == 'space' and this.y == 428 then
                    this.dy = -JUMP
                    this.state = 'jumping'
                    this.animation = this.animations['jumping']
                elseif key == 'up' and this.y == 428 then
                    this.dy = -MINI_JUMP
                    this.state = 'jumping'
                    this.animation = this.animations['jumping']
                elseif scancode == 'e' then
                    diff = 5000
                elseif scancode == 'h' then
                    diff = 1
                elseif scancode == 'n' then
                    diff = 250
                end
            end
        end,

        ['walking'] = function(dt)

            if love.keyboard.isDown('left') then
                direction = 'left'
                this.dx = -WALK_SPEED
            elseif love.keyboard.isDown('right') then
                direction = 'right'
                this.dx = WALK_SPEED
            else
                this.dx = 0
                this.state = 'idle'
                this.animation = this.animations['idle']    
            end

            function love.keypressed(key, scancode, isrepeat)
                if key == 'space' and this.y == 428 then
                    this.dy = -JUMP
                    this.state = 'jumping'
                    this.animation = this.animations['jumping']
                elseif key == 'up' and this.y == 428 then
                    this.dy = -MINI_JUMP
                    this.state = 'jumping'
                    this.animation = this.animations['jumping']
                elseif scancode == 'e' then
                    diff = 300
                elseif scancode == 'h' then
                    diff = 2
                elseif scancode == 'n' then
                    diff = 250
                end
            end

        end,

        ['jumping'] = function(dt)
            if love.keyboard.isDown('left') then
                this.direction = 'left'
                this.dx = -WALK_SPEED
            elseif love.keyboard.isDown('right') then
                this.direction = 'right'
                this.dx = WALK_SPEED
            end
            
            function love.keypressed(key, scancode, isrepeat)
                if scancode == 'e' then
                    diff = 300
                elseif scancode == 'h' then
                    diff = 2
                elseif scancode == 'n' then
                    diff = 250
                end
            end

            this.dy = this.dy + this.map.gravity

        end


    }

    setmetatable(this, self)

    return this
end

-- utility functions
function Dino:update(dt)
    self.behaviours[self.state](dt)

    self.animation:update(dt)
    self.currentframes = self.animation:getcurrentFrame()

    self.flaganimation:update(dt)
    self.flagframes = self.flaganimation:getcurrentFrame()

    --self.diff = diff 
    --map.diff = self.diff

    -- barriers (including win)
    map.deltaX = math.min(math.max(map.deltaX  - self.dx * dt, 0), #map.tiles / 12 - map.tilewidth * 10 - 30, 1400)
    self.x = math.min(math.max(self.x - self.dx * dt, 30), #map.tiles / 12 - map.tilewidth * 10 )
    
    self.y = self.y + self.dy

    if self.y > 428 then
        dino.dy = 0
        self.y = 428
        self.state = 'idle'
        self.animation = self.animations['idle']
    end

    if self.x > 1400 then
        self.dx = 0
        self.x = 1400
        self.state = 'idle'
        self.animation = self.animations['idle']
        self.winflag = true
    end

end

function Dino:render()
    -- flipping if necessary
    local scaling

    if self.direction == 'right' then
        scaling = -1
    elseif self.direction == 'left' then 
        scaling = 1
    else
        scaling = 1
    end

    love.graphics.draw(self.char, self.currentframes, self.x + self.offsetX, self.y + self.offsetY, 0, scaling, 1, self.offsetX, self.offsetY)
    if self.x > 900 then
        love.graphics.draw(self.flagsheet, self.flagframes, 1400, 428, 0, 1, 1)
    end
end



