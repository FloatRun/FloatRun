require 'Dino'
require 'Map'

-- variable intialisation
local speed = 100
local score = 0
local flag = false
local winflag = false
local cooldown = 2.5
local besttime = 50000
local time = 0
local victory = love.audio.newSource("zapsplat_animal_dinosuar_vocalisation_growl_006_10843.mp3", "static")
diff = 10
local difficulty = "normal"


--creating those objects
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    map = Map:create()
    dino = Dino:create(map)
    --diff = dino.diff
    --map.diff = diff
    winflag = false
end

function love.update(dt)
    score = score + 1
    map:update(dt)
    dino:update(dt)

    winflag = dino.winflag

    time = time + dt

    if map:getTile(math.floor((map.cacenemyX) / map.tileheight + 0.5) , math.floor(map.cacenemyY / map.tileheight + 0.5 )) == 42 then
        flag = true
    end

    if dino.winflag then
        cooldown = math.max(cooldown - dt,0)
    end

    --[[if diff == 25 then
        difficulty = "easy"
    elseif diff == 5 then
        difficulty = "hard"
    else
        difficulty = "normal"
    end]]

    if love.keyboard.isDown('e') then
        diff = 25
    elseif love.keyboard.isDown('h') then
        diff = 5
    elseif love.keyboard.isDown('n') then
        diff = 10
    end
end


function love.draw()

    --rendering based on play, victory or loss flags

    if not winflag then
        --moving 'camera'
        love.graphics.translate(math.floor(-map.deltaX + 0.5), math.floor(-map.deltaY + 0.5))
    end
    map:render()
    dino:render()
    if besttime < 50000 then
        love.graphics.print("Best Time:  " .. besttime, dino.x - 30, 0)
    end
    love.graphics.print("Current Time:  " .. time, dino.x - 30, 20)
    love.graphics.print("Completion:  " .. math.floor(dino.x / 1400 * 100) .. "%", dino.x + 500, 0)

    if flag == true then
        flag = false
        love.load()
    end

    if winflag then
        victory:play()
        if cooldown == 0 then
            winflag = false
            cooldown = 2.5
            
            if time < besttime then
                besttime = time
                time = 0
            end
            love.load()
        end
    end
    --data on screen always
    love.graphics.setFont(love.graphics.newFont(12))
    love.graphics.print("Here we go again...", 100, 500)
    love.graphics.print("Almost there!", 700, 500)
    love.graphics.print("And you've made it!", 1400, 500)
    --love.graphics.print(besttime)

end

