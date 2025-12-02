class Wall{
    float x,y;
    float w = 50;
    float h = 500;

    Wall(float _x, float _y){
        x = _x;
        y = _y;
    }

    void display(){
        rect(x, y, w, h);
    }
}