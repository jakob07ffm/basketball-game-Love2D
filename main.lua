
function love.load()
    -- Window setup
    love.window.setTitle("Simple Basketball Game")
    love.window.setMode(800, 600, {resizable=false})

    white = {1, 1, 1}
    red = {1, 0, 0}
    green = {0, 1, 0}

    ball = {
        x = 400,
        y = 300,
        radius = 15,
        dx = 0,
        dy = 0,
        speed = 300
    }
    

    hoop = {
        x = 700,
        y = 100,
        width = 100,
        height = 10
    }
    

    score = 0
end

function love.update(dt)

    if love.keyboard.isDown("left") then
        ball.dx = -ball.speed
    elseif love.keyboard.isDown("right") then
        ball.dx = ball.speed
    else
        ball.dx = 0
    end
    
    if love.keyboard.isDown("up") then
        ball.dy = -ball.speed
    elseif love.keyboard.isDown("down") then
        ball.dy = ball.speed
    else
        ball.dy = 0
    end
    
    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt
    

    if ball.x + ball.radius > hoop.x and ball.x - ball.radius < hoop.x + hoop.width and
       ball.y + ball.radius > hoop.y and ball.y - ball.radius < hoop.y + hoop.height then
        score = score + 1
        -- Reset ball position
        ball.x = 400
        ball.y = 300
    end
end

function love.draw()

    love.graphics.setColor(red)
    love.graphics.rectangle("fill", hoop.x, hoop.y, hoop.width, hoop.height)
    

    love.graphics.setColor(green)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    

    love.graphics.setColor(white)
    love.graphics.print("Score: " .. score, 10, 10)
end
