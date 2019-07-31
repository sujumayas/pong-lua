--[[
    GD50 2018 
    Pong Remake

    -- Main Program -- 

    Based on Colton Ogden repo:
    https://github.com/games/pong
    cogden@cs50.harvard.edu


]]
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


--[[ 
    Runs when the game first starts up, only once; used to initialize the game
]]
function love.load()
    -- use nearest-neighbor filtering on upscaling and downscaling to make real the low-res feeling.      
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- Replaces window.setMode function and sets a virtual resolution with new w/h 
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    -- Without push implementation
    -- love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    --     fullscreen = false,
    --     resizable = false,
    --     vsync = true
    -- })
end


--[[
  Keyboard handling, called by LOVE2D each frame;
  passes in the key we pressed so we can access.
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end



--[[
    Called after update by LOVE2D, used to draw anything 
]]

function love.draw()
    -- Begin rendering at virtual resolution
    push:apply('start')
    

    
    love.graphics.printf(
        'Hello Pong',            -- Text to render           
        0,                       -- Starting X (0 since we are going to center it)
        VIRTUAL_HEIGHT / 2 - 6,   -- Starting Y (halfway down the screen)                  
        VIRTUAL_WIDTH,            -- number of pixels to center within (entire screen)     
        'center'                 -- alignment mode, can be 'center', 'left', 'right'.
    )
    
    -- end rendering at virtual resolution
    push:apply('end')
end