
-- break sheet into table of quads
function generateQuads(sheet, tilewidth, tileheight)
    local sheetheight = sheet:getHeight() / tileheight
    local sheetwidth = sheet:getWidth() / tilewidth

    local counter  = 1
    local quads = {}

    for y = 0, sheetheight - 1 do
        for x = 0, sheetwidth - 1 do 
            quads[counter] = love.graphics.newQuad(x * tilewidth, y  * tileheight, tilewidth, tileheight, sheet:getDimensions())
            counter = counter + 1
        end
    end

    return quads
end
