class Bird{
    float x,y;

    //speed
    float base_s;
    float speed;
    float gravity;
    
    //aesthetics
    float size;
    color body_color;

    Bird(){ //default
        x = 200;
        y = 400;
        base_s = -7;
        speed = 4;
        size = 50;
        gravity = 0.3;
        body_color = color(200,200,0);
    }

    void display(){
        fill(body_color);
        circle(x,y,50);
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