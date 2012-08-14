/* Google Dart HTML5 game template sample - Anthony Pigeot (anthony.pigeot[at]gmail.com | @Malharhak | www.anthonypigeot.com)
*
*   This is a simple gameloop which runs continuously and update a player's position, then draws it on the canvas.
*   With the code shown here you have the basics informations needed to create any game you like. Please show me if you create something thanks to this :)
*   A complete tutorial (with a real game) will come soon on my website for more information.
*   Sorry for the ugly code, but this is just a basic sample.
* 
* 
*/
#library('gameTuto');

#import('dart:html');

// Canvas' size
final SCREEN_SIZE_X = 800;
final SCREEN_SIZE_Y = 600;

// Base image folder
final IMG_FOLDER = "img/";

// Player's spritesheet
final PLAYER_IMAGE = "player.png";

final CANVAS_ID = "#canvas";

// Player position
var x = SCREEN_SIZE_X / 2;
var y = SCREEN_SIZE_Y / 2;

// Spritesheet's size
var animSizeX = 4;
var animSizeY = 4;

// Player animation state
var stateX = 0;
var stateY = 0;

// Player image size
var imgSizeX = 32;
var imgSizeY = 48;

// Player image container
ImageElement img;

// Time between keyframes
var animTimer = 120;

// Frames Per Second
final FPS = 30;
var updateTimer = 0;

// Boolean to check if the player has moved in a frame
bool moved = false;

// Timer containers
int lastAnim = 0;
int lastUp = 0;


// Canvas's context. Used to draw stuff
var ctx;
// Canvas container
CanvasElement canvas;

// Booleans to know which keys are up or down
bool  left = false,
      right = false,
      up = false,
      down = false;

// Player's speed
var speed = 5;

main() {
  

  init();
}

// Launches the game and create necessary variables
void init(){
  
  // Get the canvas ant it's context
  canvas = query("#canvas");
  ctx = canvas.context2d;  
  
  // Creates the player image and launch the game once loaded.
  img = new Element.tag('img');
  img.src = "${IMG_FOLDER}${PLAYER_IMAGE}";
  img.on.load.add((event){
    window.requestAnimationFrame(run);
  });
  
  // Adds event handler for key press
  document.body.on.keyDown.add((e) {
    
    onKeyDown(e);
  });
  document.body.on.keyUp.add((e) {
    
    onKeyUp(e);
  });
  
  // Calculates time between updates depending on chosen FPS
  updateTimer = 1000 / FPS;
  
}

// Main gameplay Loop. Triggered at each frame
bool run(int time){
  
  if (time == null) {
    // time can be null for some implementations of requestAnimationFrame
    time = new Date.now().millisecond;
  }
  
  update(time);
  animate(time);
  render();
  
  // Will launch this function at the next frame
  window.requestAnimationFrame(run);
}

// Game logics triggered at each frame
void update(int time){
  
  
  if (time - lastUp > updateTimer){
    
    // Reinitializes the timer
    lastUp = new Date.now().millisecondsSinceEpoch;
    
    movePlayer();
    
  }
}

// Animates the player (aka choosing what to draw)
void animate(int time){
  
  if (moved && time - lastAnim > animTimer){
    
    // Move a case on the animation
    stateX += 1;
    stateX %= animSizeX;
    
    // Reinitialize the timer
    lastAnim = new Date.now().millisecondsSinceEpoch;
  }
  //print('${time} - ${lastAnim}');
}

// Draws the player
void render(){
  
  /*
   * The drawImage is an instruction to draw an image on a canvas. 
   * Basically, you are taking a rectangle window from the image and putting it on your canvas.
   * The first parameter is the image
   * The four others define the rectangle you take (x start position, y start position, x size, y size).
   * The last four define the target rectangle (x destination position, y destination position, x size, y size)
   */
  ctx.drawImage(img, imgSizeX * stateX, imgSizeY * stateY, imgSizeX, imgSizeY, x, y, imgSizeX, imgSizeY);
  
}

// Checks if player is on the screen
bool checkCollision(dx, dy){
  
  if (x + dx + imgSizeX > SCREEN_SIZE_X
      || x + dx < 0
      || y + dy + imgSizeY > SCREEN_SIZE_Y
      || y + dy < 0){
    return false;
  }else{
    return true;
  }
}

// Moves the player
void movePlayer(){
  
  // Temporary variables containing the value of the movement
  int dx = 0;
  int dy = 0;
  if (left){
    dx -= speed;
  }
  if (up){
    dy -= speed;
  }
  if (right){
    dx += speed;
  }
  if (down){
    dy += speed;
  }
  if ((dx != 0 || dy != 0)
      && checkCollision(dx,dy)){
    
    // If we can move, then let's move
    x+=dx;
    y+=dy;
    moved = true;
  }else{
    moved = false;
  }  
}

// Checks which key has been pressed, and changes the player animation accordingly.
void onKeyDown(e){
  
  switch(e.keyCode){
    
    case 37 :
      left = true;
      stateY = 1;
    break;
    case 38:
      up = true;
      stateY = 3;
    break;
    case 39:
      right = true;
      stateY = 2;
    break;
    case 40:
      down = true;
      stateY = 0;
    break;
  }
}

void onKeyUp(e){
  
  switch(e.keyCode){
    
    case 37 :
      left = false;
    break;
    case 38:
      up = false;
    break;
    case 39:
      right = false;
    break;
    case 40:
      down = false;
    break;
  }  
}
