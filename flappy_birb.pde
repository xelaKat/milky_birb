//Variables
Bird p1 = new Bird();
ArrayList<Wall> walls;

void setup(){
    size(800,800);

    //initializing and declaring the walls
    walls = new ArrayList<Wall>();
    for(int i = 0; i < 10; i++){
        walls.add(new Wall(100,100));
    }
}

void draw(){
    background(20,5,125); //dark blue

    ////MAKE A CHARACTER SELECTION SCREEN!!!////

    for(Wall w: walls){ //displays all walls
        w.display();
    }

    p1.display(); //displays bird
    p1.down(); //applies gravity
}

void keyPressed(){
    if(key == ' '){
        p1.up(); //jump!
    }

}
