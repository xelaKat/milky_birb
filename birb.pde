class Bird{
    float x = 200;
    float y = 400;

    //speed
    float base_s = -6; //the default speed
    float speed = base_s; //speed that gets added to the bird's y, which is how it moves and how gravity works
    float gravity = 0.3; //changes the speed
    
    //aesthetics
    float size;
    color body_color;

    Bird(color c){ //choose the color
        size = 25; //RADUIS of the bird, which is a circle
        body_color = c;
    }

    void display(){
        fill(body_color);
        circle(x,y,size*2+5); //+5 makes it easier for the player to judge distance
    }

    void down(){
        y+=speed;
        if(speed<10){
            speed += gravity;
        }
    }

    void up(){
        speed = base_s;
        y+=speed;
    }
}
