Dart-HTML5-canvas-game-sample
=============================

This is a simple exemple of how you can create a game with google Dart by interacting with a canvas.
You can see the exemple live there : http://bit.ly/Pazlw2

Basic FAQ :
=============================

1. What is Dart ?
Dart is a programming language created by google, still in alpha (or beta ?) stage.
It is meant to be somewhere between scripting languages (like Javascript) and more strict languages like Java. The goal is to make people able to scale their application while keeping the power of scripting.
More informations here : http://www.dartlang.org/

2. Why Dart ?
Don't know. I just thought it could be interesting to try it.


Code explanation :
=============================

If you have never made any games, you should read this :

1. Spritesheet
In 2D games, we use spritesheets. A spritesheet is an image containing all the image corresponding to each position of the character (look at img/player.png and you'll understand). We draw a certain part of the spritesheet depending on the player's action to animate his avatar.
Generally, the horizontal axis is for avancing in time, while the vertical is for separate animations (here : the four direction you can walk).

2. Gameplay Loop
A gameplayLoop makes the game able to run smoothly. Instead of moving each time you press a key, there is an infinite loop which continuously checks which keys you are pressing and updates the game accordingly.
This loop calls the other main functions (which are my way of doing but you can create others) :

	update : It manages all the game's logic. Like AI, movement, collisions and stuff
	animate : It manages... Animations. For exemple spritesheet management
	render : All the drawing stuff

3. Drawing
The drawing code can seem tricky :
ctx.drawImage(img, imgSizeX * stateX, imgSizeY * stateY, imgSizeX, imgSizeY, x, y, imgSizeX, imgSizeY);
  /*
   * The drawImage is an instruction to draw an image on a canvas. 
   * Basically, you are taking a rectangle window from the image and putting it on your canvas.
   * The first parameter is the image
   * The four others define the rectangle you take (x start position, y start position, x size, y size).
   * The last four define the target rectangle (x destination position, y destination position, x size, y size)
   */
  ctx.drawImage(img, imgSizeX * stateX, imgSizeY * stateY, imgSizeX, imgSizeY, x, y, imgSizeX, imgSizeY);

Here, we are taking a window on the image which starts on the current anim state. That means, 32 * our column, and 48 * our line. Which is imgSizeX * stateX and imgSizeY * stateY

The target size is simply 32 and 48 (our mario's size), which are imgSizeX and imgSizeY

Then, we want to draw it at x and y which are our player's position on the screen, and with the same size as what we are taken. We could draw it two times bigger if we wanted by multiplying the last two parameters by two.