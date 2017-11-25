gridSizeX = 4
gridSizeY = 4
cellSize = 100

function love.load()
    setup()
    createGrid()
end

function love.update()

end

function love.draw()
    drawTiles()
end

function love.keypressed(key)
    local emptyX
    local emptyY

    for x = 1, gridSizeX do
        for y = 1, gridSizeY do
            if grid[x][y] == gridSizeX * gridSizeY then
                emptyX = x
                emptyY = y
            end
        end
    end

    local newEmptyX = emptyX
    local newEmptyY = emptyY

    if key == 'right' then
        newEmptyX = emptyX + 1
    elseif key == 'up' then
        newEmptyY = emptyY - 1
    elseif key == 'left' then
        newEmptyX = emptyX - 1
    elseif key == 'down' then
        newEmptyY = emptyY + 1
    end

    if grid[newEmptyX] and grid[newEmptyX][newEmptyY] then
        grid[newEmptyX][newEmptyY], grid[emptyX][emptyY] = 
            grid[emptyX][emptyY], grid[newEmptyX][newEmptyY]
    end
end

function setup()
    love.graphics.setNewFont(36)
end

function createGrid()
    grid = {}
    for x = 1, gridSizeX do
        grid[x] = {}
        for y = 1, gridSizeY do
            grid[x][y] = x + ((y - 1) * gridSizeX)
        end
    end
end

function drawTiles()
    for x = 1, gridSizeX do
        for y = 1, gridSizeY do
            if grid[x][y] ~= gridSizeX * gridSizeY then
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
                    grid[x][y],
                    (x - 1) * cellSize + 5,
                    (y - 1) * cellSize + 5
                )
            end
        end
    end
end