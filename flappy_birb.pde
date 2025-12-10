//// Variables ////

//bird/the player character
Bird[] bird;
int chosen = 3; //determines which bird is playing
PImage chick;
PImage chick_death; //chick but upside down
PImage big_chick; //big chick for the character selection screen

//walls
ArrayList<Wall> walls;
PImage wall1;
PImage wall2;
PImage wall3;

//fog
ArrayList<Fog> fog;
int fog_count = 0; //counter for when to create fog
PImage fog1;
PImage fog2;
PImage fog3;
PImage fog4;

//other images
PImage void1;
PImage void2;

PImage milky;
PImage way;

float score = 0; //your score
float highscore = 0; //your highscore

boolean pregame = true;
boolean selection = false;
boolean game_start = false;
boolean game_over = false; //shows the end screen
boolean wait = false; //waits to start spawning walls until the player starts

boolean collision_x; //collision variables for the player
boolean collision_y;

void setup(){
  size(800,800);
  textAlign(CENTER);
  noStroke();
  pixelDensity(1);

  //players
  chick = loadImage("chick.png");
  chick_death = loadImage("chick_death.png");
  big_chick = loadImage("big_chick.png");
  Bird p1 = new Bird(color(255, 0, 0));
  Bird p2 = new Bird(color(0, 255, 0));
  Bird p3 = new Bird(chick);
  Bird p4 = new Bird(color(200, 200, 0));

  Bird[] b = {p1, p2, p3, p4};
  bird = b;

  //initializing and declaring arraylists
  walls = new ArrayList<Wall>();
  fog = new ArrayList<Fog>();

  //adding some fog in the beginning
  for(int i = 0; i < 10; i++){
    fog.add(new Fog(random(0,800)));
  }

  //Images
  wall1 = loadImage("wall1.png");
  wall2 = loadImage("wall2.png");
  wall3 = loadImage("wall3.png");
  fog1 = loadImage("fog1.png");
  fog2 = loadImage("fog2.png");
  fog3 = loadImage("fog3.png");
  fog4 = loadImage("fog4.png");
  void1 = loadImage("void1.png");
  void2 = loadImage("void2.png");
  milky = loadImage("milky.png");
  way = loadImage("way.png");
}

void draw(){
  if(pregame){ //title screen
    pregame();
  }
  
  if(selection){
    selection();
  }

  else if(game_start){
    background(0); //in case the image fails lol
    background(milky);

    //FOG!!! This plays on all screens
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
    if(frameCount%90==30){ //creats new walls every 1.5 seconds - modulo == 30 because then the walls will spawn half a second after the player presses the space bar
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
      bird[chosen].speed = 10;
      game_start = false;
      game_over = true;
      delay(500);
    }

    if(wait){ //wait is triggered when the game starts/restarts. It makes the walls and gravity wait until the player presses the space bar to jump, just like the original game
      fill(255);
      textSize(24);
      text("SPACE bar to jump", 350,400);
      frameCount = 0;
    }
    else{ //if the waiting time is over, gravity is applied, the score is shown, and the walls start appearing - they didn't earlier because wait kept the frameCount at 0, and walls rely on the frameCount to be generated
      bird[chosen].down(); //applies gravity

      //display score
      textSize(50);
      fill(255);
      text(int(score), 400, 100);
    }

    bird[chosen].display(); //displays the bird

    //collision logic and score system
    //this logic is at the very end so that the player can see all the elements on screen and accurately judge the distance between hitboxes
    for (Wall w : walls) {
      if (bird[chosen].x == w.x + w.w){ //score
        score+=0.5; //adds 0.5 because there are two walls for each 'whole' column
      }

      //collision
      collision_x = w.x <= bird[chosen].x + bird[chosen].size && w.x + w.w >= bird[chosen].x - bird[chosen].size;
      collision_y = w.y <= bird[chosen].y + bird[chosen].size && w.y + w.h >= bird[chosen].y - bird[chosen].size;
      if (collision_x && collision_y){
        game_start = false;
        game_over = true;
        if(score>highscore){ //sets your highscore
          highscore = score;
        }
        delay(500); //wait half a second - delay calculates using thousanths of a second
      }
    }
  } 

  else if(game_over){ //end screen
    game_over();
  }

  fog_count++;

  //the void AKA visible boundaries so the player knows
  image(void1, 0,-75);
  image(void2, 0,650);
}

void keyPressed(){
  if(key==' ' && game_start){
    bird[chosen].up(); //jump!
  }

  if(wait){
    wait = false; //turns off wait
  }
}
