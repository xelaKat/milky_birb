//// !!! Variables !!! ////

//fonts
PFont font1;
PFont font2;

//music
import processing.sound.*;
SoundFile intro_music;
SoundFile game_music;
SoundFile jump;

//bird (the playable character) initialization and images
Bird[] bird;
int chosen = 1; //determines which bird is playing

//character 1
PImage moonfish;
PImage moonfish_death; //moonfish but upside down
PImage big_moonfish; //big moonfish for the character selection screen
//character 2
PImage axolotl;
PImage axolotl_death; //axolotl but upside down
PImage big_axolotl; //big axolotl for the character selection screen
//character 3
PImage chick;
PImage chick_death; //chick but upside down
PImage big_chick; //big chick for the character selection screen
//character 4
PImage earth;
PImage earth_death; //earth but upside down
PImage big_earth; //big earth for the character selection screen

//walls
ArrayList<Wall> walls;
PImage wall1;
PImage wall2;
PImage wall3;

//fog - floats in the background for aesthetics
ArrayList<Fog> fog;
int fog_count = 0; //counter for when to create fog
PImage fog1;
PImage fog2;
PImage fog3;
PImage fog4;

//boundary images
PImage void1;
PImage void2;

//background image
PImage milky;

float score = 0; //your score
float highscore = 0; //your highscore

//sequence booleans - determines which phase of the game you are in
boolean pregame = true; //title screen
boolean selection = false; //character selection screen
boolean game_start = false; //actual gameplay screen
boolean game_over = false; //end screen
boolean wait = false; //controls when to start spawning walls (after the player first jumps)

//collision variables for the player
boolean collision_x;
boolean collision_y;

void setup(){
  size(800,800);

  //font text
  font1 = createFont("YouthTouch.ttf",24); //imports font
  font2 = createFont("StylishCalligraphy.ttf",24); //another font
  textFont(font1); //sets the font
  textAlign(CENTER);
  
  //music
  intro_music = new SoundFile(this, "sound/The_Hitchhiker's_Guide_To_The_Galaxy.mp3");
  game_music = new SoundFile(this, "sound/Across_The_Void.mp3");
  game_music.amp(0.2); //makes this music quieter
  jump = new SoundFile(this, "sound/jump.mp3");
  intro_music.loop(); //starts the music

  noStroke();
  pixelDensity(1);

  //bird / player images
  //character 1
  moonfish = loadImage("images/moonfish.png");
  moonfish_death = loadImage("images/moonfish_death.png");
  big_moonfish = loadImage("images/big_moonfish.png");
  big_moonfish.resize(290,290); //the png is a little too big so it is resized

  //character 2
  axolotl = loadImage("images/axolotl.png");
  axolotl_death = loadImage("images/axolotl_death.png");
  big_axolotl = loadImage("images/big_axolotl.png");

  //character 3
  chick = loadImage("images/chick.png");
  chick_death = loadImage("images/chick_death.png");
  big_chick = loadImage("images/big_chick.png");

  //character 4
  earth = loadImage("images/earth.png");
  earth_death = loadImage("images/earth_death.png");
  big_earth = loadImage("images/big_earth.png");

  //creates the actual birds - go to the birb file to see the Bird class
  Bird p1 = new Bird(moonfish);
  Bird p2 = new Bird(axolotl);
  Bird p3 = new Bird(chick);
  Bird p4 = new Bird(earth);

  Bird[] b = {p1, p2, p3, p4}; //local array to manually add each bird
  bird = b; //transfers the local array into the global array (initialized at the top)

  //initializing and declaring arraylists
  walls = new ArrayList<Wall>();
  fog = new ArrayList<Fog>();

  //adding some fog in the beginning
  for(int i = 0; i < 10; i++){
    fog.add(new Fog(random(0,800)));
  }

  //other images
  wall1 = loadImage("images/wall1.png");
  wall2 = loadImage("images/wall2.png");
  wall3 = loadImage("images/wall3.png");

  fog1 = loadImage("images/fog1.png");
  fog2 = loadImage("images/fog2.png");
  fog3 = loadImage("images/fog3.png");
  fog4 = loadImage("images/fog4.png");

  void1 = loadImage("images/void1.png");
  void2 = loadImage("images/void2.png");

  milky = loadImage("images/milky.png");
}

void draw(){ //for game events that are just a function, check the sequence tab
  if(selection){ //selection screen - comes before title screen to make sure it won't get skipped by the mouseclick logic when switching screens
    selection();
  }

  else if(pregame){ //title screen
    pregame();

    //music
    if(game_music.isPlaying()){ //stops the game_music if it is playing
      game_music.pause();
    }
  }

  else if(game_start){ //actual game screen
    //music
    if(intro_music.isPlaying()){ //stops the intro_music if it is playing
      intro_music.pause();
    }
    if(!game_music.isPlaying()){ //starts the game_music if it is not playing
      game_music.loop();
    }

    background(0); //in case the image fails lol
    background(milky);

    // FOG!!! This plays on all screens //
    if(fog_count%300==0){
      fog.add(new Fog()); //creates fog every 5 seconds
    }

    for(int i = fog.size()-1; i>-1; i--){ //displays all fog, moves them, and deletes them
      fog.get(i).display();
      fog.get(i).move();

      if(fog.get(i).x < -250){ //removes fog that goes off screen
        fog.remove(i);
      }
    }

    //Walls
    //basically the same code as fog
    if(frameCount%90==30){ //creats new walls every 1.5 seconds - modulo == 30 because then the walls will spawn half a second after starting
      float _y = random(-500, 0);
      walls.add(new Wall(_y));
      walls.add(new Wall(_y+800));
    }

    for(int i = walls.size()-1; i>-1; i--){ //displays all walls, moves them, and deletes them
      walls.get(i).move();
      walls.get(i).display();

      if(walls.get(i).x < -walls.get(i).w){ //removes walls that go off screen
        walls.remove(i);
      }
    }

    //bounds - if you go out of bounds, you die
    if(bird[chosen].y-bird[chosen].size<=0 || bird[chosen].y+bird[chosen].size>=height){
      bird[chosen].speed = 10; //resets the speed to the bird will immediately fall

      game_start = false;
      game_over = true;
      delay(100); //waits 0.1 seconds - delay is calculated using thousandths of a second
    }

    if(wait){ //wait is triggered when the game starts/restarts. It makes the walls and gravity wait until the player presses the space bar to jump, just like the original game
      fill(255);
      textSize(40);
      text("SPACE bar to jump", 350,400);
      frameCount = 0;
    }
    else{ //if the waiting time is over, gravity is applied, the score is shown, and the walls start appearing - they didn't earlier because wait kept the frameCount at 0, and walls rely on the frameCount to be generated
      bird[chosen].down(); //applies gravity

      //display score
      textFont(font2);
      textSize(80);
      fill(255);
      text(int(score), 400, 150);
      textFont(font1);
    }

    bird[chosen].display(); //displays the bird

    //collision logic and score system
    //this logic is at the very end so that the player can see all the elements on screen and accurately judge the distance between hitboxes before the bird gets hit
    for (Wall w : walls) {
      if (bird[chosen].x == w.x + w.w){ //score code
        score+=0.5; //adds 0.5 because there are two walls for each column
        if(score>highscore){ //sets your highscore
          highscore = score;
        }
      }

      //collision code
      collision_x = w.x <= bird[chosen].x + bird[chosen].size && w.x + w.w >= bird[chosen].x - bird[chosen].size; //if the x coords collide
      collision_y = w.y <= bird[chosen].y + bird[chosen].size && w.y + w.h >= bird[chosen].y - bird[chosen].size; //if the y coords collide
      if(collision_x && collision_y){ //if collide, game over
        game_start = false;
        game_over = true;
        delay(100); //wait tenth a second - delay calculates using thousanths of a second
      }
    }
  } 

  else if(game_over){ //end screen
    game_over();
  }

  fog_count++; //fog_count controls when to spawn fog - increases every frame

  //the void AKA bounds (there are images so the player knows that they can't hit the top or bottom of the screen)
  image(void1, 0,-75);
  image(void2, 0,650);
}

void keyPressed(){
  if(key==' '){
    if(game_start){
      bird[chosen].up(); //jump!
      jump.play(); //sound effect
    }
    if(wait){
      wait = false; //turns off wait when you jump
    }
  }
}
