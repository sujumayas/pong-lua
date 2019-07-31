# PONG 
Game retro style made with Lua & Love <3.  
Inspired by CS50 Harvard University online Classes

## Repo from Harvard: 

[https://github.com/cs50/gd50/tree/master/pong](https://github.com/cs50/gd50/tree/master/pong)

## What is Lua

- Means "Moon" <3 in Portuguese. Invented in Brazil in 1993. 
- Flexible, lightwight scripting language focused around "tables" (object in js, dict in python)
- Intended for emmbebed in other applications
- Very popular in video game industry
- Similar(ish) to JavaScript
- Excelent for storing data as well as code (data-driven design)


## What is LoVE2D

- Fast 2D game development framework written in C++
- Uses Lua as its scripting language
- Contains modules for graphics, keyboard input, math, audio, windowing, physics, and mucho more. 
- Completely free and portable to all major desktops and Android/iOS
- Great for prototyping!

### The game loop 

The game loop is an 'almost infinite' Loop that starts by processing user input, updating game state and then rendering the results, everything in a frame-per-second logic validated by delta-time. 

### 2D Coordinate System in Love2D

The coordinate system in Love2D is similar to what works in canvas in the web or in some other 2D systems.  

    You start at the top-left (0, 0),  
    and then you can go to top-right (width, 0)   
    or bottom-left (0, height)   
    or you can go to the opposite corner with (width, height).  

So we represent every coordinate with the X axis as first parameter and the Y axis as the second, where right direction force is positive X, left is negative X, up is negative Y and down is positive Y. 

                               Up
                            (0, -1)
            
             Left                              Right
            (-1, 0)                           (1, 0)
            
                              Down
                             (0, 1)


## Pong requirements

- Draw shapes to the screen (paddles and ball)
- Control 2D position of paddles based on input
- Collision detection between paddles and ball to deflect ball back toward opponent
- Collision detection between ball and map boundaries to keep ball within vertical bounds and to detect score (outside horizontal bounds)
- Sound effects when ball hits paddles/walls or when a point is scored for flavor. 
- Scorekeeping to determine winner. 



### PONG-0: Some Importan LOVE2D Functions

Love2d expects this functions to be implemented in main.lua and calls them internally. If we dont define them, it will still function, but our game will be fundamentally incomplete, at least if update or draw are missing!

- `love.load()` > used for initializing our game state at the very beginning of program execution
- `love.update(dt)` > Called each frame by Love2d. dt will be the elapsed time in seconds since the last frame, and we can use this to scale any changes in our game for even behavior across frame rates. 
- `love.draw()` > Called each frame by Love2d after update for drawing things to the screen once they've changed. 

Other functions that we will use in this game: 

- `love.graphics.printf(text, x, y, [width], [align])` > Versatile print function that can align text left, right, or center on the screen. 
- `love.window.setMode(width, height, params)` > Used to initialize the window's dimensions and to set parameters like vsync (vertical sync), whether we're fullscreen or not, and whether the window is resizable after startup. Actually we are going to use `push library` later. 


### PONG-1: The low res update important functions

- `love.graphics.setDefaultFilter(min, mag)` > Sets the texture scaling filter when minimizing and magnifying textures and fonts; default is bilinear, which causes blurriness, and for our use cases we will typically want nearest-neighbor filtering (`nearest`), which results in perfect pixel upscaling and downscaling, simulating retro feel. 

- `love.keypressed(key)` > A LOVE2D callback function that executes whenever we press a key, assumming we've implemented this in our main.lua, in the same vein as `love.load()`, `love.update(dt)` and `love.draw()` It recieves a key 'string'. 

- `love.event.quit()` > Simple function that terminates the application. 

### PONG-2: The rectangle update important functions

- `love.graphics.newFont(path,size)` > Loads a font file into memory at a specific path, setting it to a specific size, and storing it in an object we can use to globally change the current active font that LOVE2D is using to render text (functioning like a state machine).
- `love.graphics.setFont(font)` > Sets LOVE2D's currently active font (of which there can only be one at a time) to a passed-in font object that we can create using `love.graphics.newFont()`.
- `love.graphics.clear(r, g, b, a)` > Wipes the entire screen with a color defined by an RGBA set, each component of which being from 0-255. 
- `love.graphics.rectangle(mode, x, y, width, height)` > Draws a rectangle onto the screen using whichever our active color is (`love.graphics.setColor`, white is default). Mode can be set to 'fill' or 'line', which result in a filled or outlined rectangle, respectively, and the other four parameters are its position and size dimensions. 

- As Found on Youtube:  
```
Here was everything I needed for this to work in Love 11.2:

- method getPixelScale needs to be changed to getDPIScale
- setColor uses values between 0-1 instead of 0-255 so old values will cause white screen.
- push: setColor(1,1,1)
- main: clear(0.2, 0.21, 0.3, 1) -- this is a guessed conversion
- note: fps colors added in 7 will work as-is, but 255 can be changed to 1 for good practice

Anyone on a Retina screen may get a half-sized screen, so on push:101 set "_PSCALE" to "self._highdpi and 1" (getDPIScale throws it off)

Once you update the push file with the above updates, you can use that version in the rest of the folders.

There are lots of additions to 11 to DRY things up, but the above is what I needed to complete and run all of the code from the GitHub repo. 

https://www.youtube.com/watch?v=jZqYXSmgDuM&list=PLWKjhJtqVAbluXJKKbCIb4xd7fcRkpzoz&index=2&t=1504s
```

### PONG-3: The Paddle Update (Interactivity Yeah!)

- `love.keyboard.isDown(key)` > Returns true or false depending on whether the specified key is currently held down; differs from `love.keypressed(key)` in that this can be called arbitrarily and will continuously return true if the key is pressed down, where `love.keypressed(key)` will only fire its code once every time the key is initially pressed down. However, since we want to be able to move our paddles up and down by holding down the appropriate keys, we need a function to test for longer periods of input, hence the use of `love.isDown(key)`.

