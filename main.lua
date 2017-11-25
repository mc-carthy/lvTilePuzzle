gridSizeX = 4
gridSizeY = 4
cellSize = 100

function love.load()
    setup()
end

function love.update()

end

function love.draw()
    drawTiles()
end

function setup()
    love.graphics.setNewFont(36)
end

function drawTiles()
    for x = 1, gridSizeX do
        for y = 1, gridSizeY do
            love.graphics.setColor(0, 191, 191)
            love.graphics.rectangle(
                'fill',
                (x - 1) * cellSize,
                (y - 1) * cellSize,
                cellSize - 1,
                cellSize - 1
            )
            love.graphics.setColor(255, 255, 255)
            love.graphics.print(
                x + ((y - 1) * 4),
                (x - 1) * cellSize + 5,
                (y - 1) * cellSize + 5
            )
        end
    end
end