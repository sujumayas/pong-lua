# PONG 
Game retro style made with Lua & Love <3.  
Inspired by CS50 Harvard University online Classes

## Repo from Harvard: 

[Github repo](https://github.com/cs50/gd50/tree/master/pong)
[Lectures Code](https://cdn.cs50.net/games/2018/spring/lectures/0/src0/pong/)

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


### PONG-4: The ball update

- `math.randomseed(num)` > Seeds the random number generator used by Lua (math.random) with some value such that its randomness is dependant on that supplied value, allowing us to pass in different numbers each playthrough to guarantee non-consistency across different program executions (or uniformity if we want consistent behavior for testing). 
- `os.time()` > Lua function that returns, in seconds, the time since 00:00:00 UTC, January 1, 1970, also known as Unix epoch time. 
- `math.random(min, max)` > Returns a random number, dependent on the seeded random number generator, between min and max, inclusive. 
- `math.min(num1, num2)` > returns the smallest of two values
- `math.max(num1, num2)` > returns the biggest of two values


### PONG-5: The Class Update <3

#### What is a class?

A class is way of taking data and putting it together in a container and add some methods to that same container so we can encapsulate all the logic of an "object" in a blueprint to use it later for ease of use. 

- Its a blueprint for creating bundles of data and code that are related
- A "Car" class can have attributes that describe its brand, model, color, miles, and anything else descriptive; these are also known as "fields" or "attributes". 
- A "Car" class can also have "methods" that define its behavior, succh as "accelerate, "turn", "honk", and more, which take the form of functions. 
- Objects are instantiated from these class blueprints, and it's these concrete objects that are the physical "cars" you see on the road, as opposed to the blueprints that may exist in the factory. 
- Our Paddles and Ball are perfect simple use cases for taking some of our code and bundling it together into classes and objects. 


#### Steps

1. Require class library ( [https://github.com/vrld/hump/class.lua](https://github.com/vrld/hump/class.lua) )
2. Separate logic for Paddle and Ball classes (use capitalize for class files) and require those files also.
3. Initialize the variables player1, player2 and ball with the classes init method. 
4. Use update, reset and render methods from within their instances instead of directly in main.lua. <3


### PONG-6: The FPS update

- `love.window.setTitle(title)` > Sets a title to the window. :D
- `love.timer.getFPS()` > Return the current FPS of our application, making it easy to monitor when printed. 


### PONG-7: The Collision update

#### AABB Collision Detection, p.1

AABB Collision relies on all colliding entities to have "alix-aligned bounding boxes", which simply means their collision boxes contain no rotation in our world space, which allows us to use a simple math formula to test for collision. 

```lua
if rect1.x is not > rect2.x + rect2.width and
   rect1.x + rect1.width is not < rect2.x and
   rect1.y is not > rect2.y + rect2.height and
   rect1.y + rect1.height is not < rect2.y:
      collision is true
else
   collision is false
```



### PONG-8: The score Update




### PONG-9: Scoring the goals


### PONG-10: Refactoring?


### PONG-11: The audio Update




-----

## For later: 

[Love2d Build Automation with itch.io, Gitlab, Docker & love-release](https://github.com/oniietzschan/blog/issues/1#issue-236375017)