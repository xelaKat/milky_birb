class Fog{
    float x,y;
    int random; //decides which fog image to display

    Fog(){ //creates fog randomly throughout the screen - used for creating fog in the very beginning
        x = 800;
        y = random(-200,700);
        random = int(random(3));
    }

    Fog(float _x){ //controllable fog creation
        x = _x;
        y = random(-200,700);
        random = int(random(3));
    }

    void display(){ //displays fog based on the random int
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

    void move(){ //slowly slowly slowly floats through the screen
        x-=0.1;
    }
}
