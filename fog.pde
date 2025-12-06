class Fog{
    float x,y;
    int random;

    Fog(){
        x = 800;
        y = random(-200,700);
        random = int(random(3));
    }

    Fog(float _x){
        x = _x;
        y = random(-200,700);
        random = int(random(3));
    }

    void display(){
        if(int(random)==0){
            image(fog1, x,y);
        }
        else if(int(random)==1){
            image(fog2, x,y);
        }
        else if(int(random)==2){
            image(fog3, x,y);
        }
        else if(int(random)==3){
            image(fog4, x,y);
        }
    }

    void move(){
        x-=0.1;
    }
}