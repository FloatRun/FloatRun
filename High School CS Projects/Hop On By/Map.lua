require 'Util'

--creating map table and reference
Map = {}
Map.__index = Map

--variable intialisation
TILE_FLOOR = 64
TILE_EMPTY = 51
TILE_STAR = 52
CACENEMY = 42
EMERALD = 10

--creating Map object
function Map:create()
    local this = {
        spritesheet = love.graphics.newImage("Amiga Amiga CD32 - Jail Break - Blocks & Backgrounds (1) (1).png"),
        mapHeight = 150,
        mapWidth = 1500,
        tileheight = 10,
        tilewidth = 10.5,
        tiles = {},
        deltaX = 0,
        deltaY = 0,
        dinodx = 0,
        dinody = 0,
        gravity = 10,
        cacenemyX = 0,
        cacenemyY = 0,
        place = 0,
        diff = diff or 100
    }

    this.tileSprites = generateQuads(this.spritesheet, 16, 16)

    setmetatable(this, self)

    --filling table with tile types
    for y = 1, this.mapHeight do
        for x = 1, this.mapWidth do
            if x % 4 == 0 and math.random(1,20000) % 250 == 0 then
                this:setTile(x, y, TILE_STAR)
            else
                this:setTile(x, y, TILE_EMPTY)
            end
        end
    end

    
    for y = math.floor(this.mapHeight / 3) - 4, this.mapHeight do
        for x = 1, this.mapWidth do
            this:setTile(x, y, TILE_FLOOR)
        end
    end

    for y = math.floor(this.mapHeight / 3) - 4, math.floor(this.mapHeight / 3) - 4 do
        for x = 1, this.mapWidth do
            this:setTile(x, y, EMERALD)
        end
    end

    --randomly generated cacti
    local i = 20
    while i < this.mapWidth do
        if math.random(this.diff) == 1 then
            if not(((((this:getTile(i - 2, (this.mapHeight / 3) - 6)) == CACENEMY) or (this:getTile(i - 1, (this.mapHeight / 3) - 6)) == CACENEMY) or (this:getTile(i - 3, (this.mapHeight / 3) - 6)) == CACENEMY)) then
                for k = 1, 5, 1 do
                    this:setTile(i, math.floor(this.mapHeight / 3) - (k + 4), CACENEMY)
                end
            end
        end
        i = i + 1
    end

    return this

end

--utility functions
function Map:update(dt)
    
    self.cacenemyX = dino.x
    self.cacenemyY = dino.y
    --self.diff = dino.diff

end

function Map:getTile(x, y)
    return self.tiles[(y - 1) * self.mapWidth + x]
end

function Map:setTile(x, y, tile)
    self.tiles[(y - 1) * self.mapWidth + x] = tile
end

function Map:render()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            love.graphics.draw(self.spritesheet, self.tileSprites[self:getTile(x,y)], (x-1) * self.tilewidth, (y-1) * self.tileheight)
        end
    end
end



