//Variables
Bird[] bird;
int chosen = 3; //determines which bird is playing

ArrayList<Wall> walls;

boolean pregame = true;
boolean game_start = false;
boolean game_over = false; //shows the end screen

void setup(){
    size(800,800);
    textAlign(CENTER);

    //players
    Bird p1 = new Bird(color(255,0,0));
    Bird p2 = new Bird(color(0,255,0));
    Bird p3 = new Bird(color(0,0,255));
    Bird p4 = new Bird(color(200,200,0));

    Bird[] b = {p1, p2, p3, p4};
    bird = b;

    //initializing and declaring the walls
    walls = new ArrayList<Wall>();
}

void draw(){
    if(pregame){
        pregame = false;
        game_start = true;
    }
    else if(game_start){
        background(20,5,125); //dark blue

        ////MAKE A CHARACTER SELECTION SCREEN!!!////


        //Walls
        if(frameCount>=120 && frameCount%90==0){ //creats new walls every 1.5 second
            float _y = random(-500,0);
            walls.add(new Wall(_y));
            walls.add(new Wall(_y+800));
        }

        for(int i = walls.size()-1; i>-1; i--){ //displays all walls
            walls.get(i).display();
            walls.get(i).move();

            if(walls.get(i).x < -walls.get(i).w){
            walls.remove(i);
            }
        }

        bird[chosen].display(); //displays bird
        bird[chosen].down(); //applies gravity

        //collision logic
        for(Wall w: walls){
            boolean collision_x = w.x <= bird[chosen].x + bird[chosen].size && w.x + w.w >= bird[chosen].x - bird[chosen].size;
            boolean collision_y = w.y <= bird[chosen].y + bird[chosen].size && w.y + w.h >= bird[chosen].y - bird[chosen].size;
            if(collision_x && collision_y){
                game_start = false;
                game_over = true;
            }
        }
    }
    else if(game_over){
        noLoop();
        textSize(24);
        text("GAME OVER", 400,400);
    }
}

void keyPressed(){
    if(key == ' '){
        bird[chosen].up(); //jump!
    }

}
