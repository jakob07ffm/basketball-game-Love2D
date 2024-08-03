function love.load()
    love.window.setTitle("Advanced Basketball Game")
    love.window.setMode(800, 600, {resizable=false})

    white = {1, 1, 1}
    red = {1, 0, 0}
    green = {0, 1, 0}
    black = {0, 0, 0}
    
    ball = {
        x = 400,
        y = 300,
        radius = 15,
        dx = 0,
        dy = 0,
        speed = 300,
        gravity = 800,
        jumpStrength = -400
    }
    
    hoop = {
        x = 700,
        y = 100,
        width = 100,
        height = 10
    }
    
    backboard = {
        x = hoop.x - 10,
        y = hoop.y - 50,
        width = 10,
        height = 100
    }
    
    score = 0
    isJumping = false

    sounds = {
        score = love.audio.newSource("score.wav", "static"),
        hit = love.audio.newSource("hit.wav", "static")
    }
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        ball.dx = -ball.speed
    elseif love.keyboard.isDown("right") then
        ball.dx = ball.speed
    else
        ball.dx = 0
    end
    
    if love.keyboard.isDown("space") and not isJumping then
        ball.dy = ball.jumpStrength
        isJumping = true
    end
    
    ball.dy = ball.dy + ball.gravity * dt
    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt
    
    if ball.y + ball.radius > love.graphics.getHeight() then
        ball.y = love.graphics.getHeight() - ball.radius
        ball.dy = 0
        isJumping = false
    end

    if ball.x + ball.radius > hoop.x and ball.x - ball.radius < hoop.x + hoop.width and
       ball.y + ball.radius > hoop.y and ball.y - ball.radius < hoop.y + hoop.height then
        score = score + 1
        sounds.score:play()
        ball.x = 400
        ball.y = 300
        ball.dy = 0
        isJumping = false
    end
    
    if ball.x + ball.radius > backboard.x and ball.x - ball.radius < backboard.x + backboard.width and
       ball.y + ball.radius > backboard.y and ball.y - ball.radius < backboard.y + backboard.height then
        ball.dx = -ball.dx
        sounds.hit:play()
    end
end

function love.draw()
    love.graphics.setColor(black)
    love.graphics.rectangle("fill", backboard.x, backboard.y, backboard.width, backboard.height)
    
    love.graphics.setColor(red)
    love.graphics.rectangle("fill", hoop.x, hoop.y, hoop.width, hoop.height)
    
    love.graphics.setColor(green)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    
    love.graphics.setColor(white)
    love.graphics.print("Score: " .. score, 10, 10)
end

function love.keypressed(key)
    if key == "r" then
        score = 0
        ball.x = 400
        ball.y = 300
        ball.dy = 0
        isJumping = false
    end
end
