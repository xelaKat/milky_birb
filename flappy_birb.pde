//Variables
Bird[] bird;
int chosen = 3; //determines which bird is playing

//walls
ArrayList<Wall> walls;
PImage wall1;
PImage wall2;
PImage wall3;
PImage fog; //change fog to something better
PImage milky;
PImage way;
float f_x = 800; //xcoord for the fog

float score = 0;

boolean pregame = true;
boolean game_start = false;
boolean game_over = false; //shows the end screen

boolean exit_button = false;

void setup(){
  size(800, 800);
  textAlign(CENTER);
  pixelDensity(1);

  //players
  Bird p1 = new Bird(color(255, 0, 0));
  Bird p2 = new Bird(color(0, 255, 0));
  Bird p3 = new Bird(color(0, 0, 255));
  Bird p4 = new Bird(color(200, 200, 0));

  Bird[] b = {p1, p2, p3, p4};
  bird = b;

  //initializing and declaring the walls
  walls = new ArrayList<Wall>();

  //Images
  wall1 = loadImage("wall1.png");
  wall2 = loadImage("wall2.png");
  wall3 = loadImage("wall3.png");
  fog = loadImage("fog.png");
  milky = loadImage("milky.png");
  way = loadImage("way.png");
}

void draw(){
  if(pregame){ //title screen
    pregame();
  }
  //if(selection){
  //  selection();
  //}
  else if(game_start){
    background(0); //in case the image fails lol
    background(milky);

    //Walls
    if (frameCount>=60 && frameCount%90==0) { //creats new walls every 1.5 second
      float _y = random(-500, 0);
      walls.add(new Wall(_y));
      walls.add(new Wall(_y+800));
    }

    for (int i = walls.size()-1; i>-1; i--) { //displays all walls, moves them, and deletes them
      walls.get(i).display();
      walls.get(i).move();

      if (walls.get(i).x < -walls.get(i).w) {
        walls.remove(i);
      }
    }

    bird[chosen].display(); //displays the bird

    //collision logic and score system
    for (Wall w : walls) {
      if (bird[chosen].x == w.x + w.w){ //score
        score+=0.5; //adds 0.5 because for some reason this runs twice whenever it is true
      }

      //collision
      boolean collision_x = w.x <= bird[chosen].x + bird[chosen].size && w.x + w.w >= bird[chosen].x - bird[chosen].size;
      boolean collision_y = w.y <= bird[chosen].y + bird[chosen].size && w.y + w.h >= bird[chosen].y - bird[chosen].size;
      if (collision_x && collision_y){
        game_start = false;
        game_over = true;
        delay(500); //wait half a second - delay calculates using thousanths of a second
      }
    }

    bird[chosen].down(); //applies gravity
    textSize(50);
    text(int(score), 400, 100);
  } 
  else if(game_over){ //end screen
    game_over();
  }
}



void keyPressed(){
  bird[chosen].up(); //jump!
}
