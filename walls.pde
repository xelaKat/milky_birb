class Wall{
    float x = 800;
    float y;
    float w = 50;
    float h = 600;

    Wall(float _y){
        y = _y;
    }

    void display(){
        fill(255);
        rect(x, y, w, h);
    }

    void move(){
        x-=3;
    }
}
