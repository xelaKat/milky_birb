class Wall{
    float x = 800; //spawns at the edge of the screen
    float y;
    float w = 51; //width and height are used for collision logic
    float h = 600;
    
    int random = int(random(0,3)); //determines the image of the wall

    Wall(float _y){ //creats wall - only controls y variable, x controls itself
        y = _y;
    }

    void display(){
        if(random == 0){
            image(wall1, x,y);
        }
        if(random == 1){
            image(wall2, x,y);
        }
        if(random == 2){
            image(wall3, x,y);
        }
    }

    void move(){ //walls move to create the illusion that the player is going forward
        x-=3;
    }
}
