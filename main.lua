--[[
    GD50 2018 
    Pong Remake

    -- Main Program -- 

    Based on Colton Ogden repo:
    https://github.com/games/pong
    cogden@cs50.harvard.edu


]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[ 
    Runs when the game first starts up, only once; used to initialize the game
]]
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--[[
    Called after update by LOVE2D, used to draw anything 
]]

function love.draw()
    love.graphics.printf(
        'Hello Pong',            -- Text to render           
        0,                       -- Starting X (0 since we are going to center it)
        WINDOW_HEIGHT / 2 - 6,   -- Starting Y (halfway down the screen)                  
        WINDOW_WIDTH,            -- number of pixels to center within (entire screen)     
        'center'                 -- alignment mode, can be 'center', 'left', 'right'.
    )
end