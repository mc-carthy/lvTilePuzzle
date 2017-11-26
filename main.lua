gridSizeX = 2
gridSizeY = 2
cellSize = 100
numShuffles = 1000

function love.load()
    setup()
    createGrid()
    shuffleTiles(numShuffles)
end

function love.update()

end

function love.draw()
    drawTiles()
end

function love.keypressed(key)
    moveDirection(key)
    checkIfComplete()
end

function setup()
    love.graphics.setNewFont(36)
end

function createGrid()
    grid = {}
    for x = 1, gridSizeX do
        grid[x] = {}
        for y = 1, gridSizeY do
            grid[x][y] = getInitialValue(x, y)
        end
    end
end

function shuffleTiles(numShuffles)
    for moveNumber=1, numShuffles do
        local roll = love.math.random(4)
        if roll == 1 then
            moveDirection('right')
        elseif roll == 2 then
            moveDirection('up')
        elseif roll == 3 then
            moveDirection('left')
        elseif roll == 4 then
            moveDirection('down')
        end
    end
    makeBottomRightTileEmpty()
end

function makeBottomRightTileEmpty()
    for moveNumber = 1, gridSizeX - 1 do
        moveDirection('left')
    end

    for moveNumber = 1, gridSizeY - 1 do
        moveDirection('up')
    end
end

function moveDirection(direction)
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

    if direction == 'right' then
        newEmptyX = emptyX - 1
    elseif direction == 'up' then
        newEmptyY = emptyY + 1
    elseif direction == 'left' then
        newEmptyX = emptyX + 1
    elseif direction == 'down' then
        newEmptyY = emptyY - 1
    end

    if grid[newEmptyX] and grid[newEmptyX][newEmptyY] then
        grid[newEmptyX][newEmptyY], grid[emptyX][emptyY] = 
            grid[emptyX][emptyY], grid[newEmptyX][newEmptyY]
    end
end

function checkIfComplete()
    local complete = true

    for x = 1, gridSizeX do
        for y = 1, gridSizeY do
            if grid[x][y] ~= getInitialValue(x, y) then
                complete = false
            end
        end
    end

    if complete then
        love.load()
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

function getInitialValue(x, y)
    return x + ((y - 1) * gridSizeX)
end