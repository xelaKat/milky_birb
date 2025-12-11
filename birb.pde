class Bird{
    float x = 200;
    float y = 400;
    float size;

    //speed
    float base_s = -7; //the default speed
    float speed = base_s; //speed that gets added to the bird's y, which is how it moves and how gravity works
    float gravity = 0.4; //changes the speed


    Bird(PImage i){ //doesn't actually use the image; image parameter is mainly to make sure I know which character is which bird in the main cide
        size = 25; //measurement used for collision logic
    }

    void display(){
        if(chosen==0){
            image(moonfish, x-size-5, y-size-5); //wierd coordinates because the image is 60x60 while the bird is 50x50. the bird is also a circle, so the square png coords have to be adjusted
            if(game_over){
                image(moonfish_death, x-size-5, y-size-5);
            }
        }
        else if(chosen==1){
            image(axolotl, x-size-5, y-size-5);
            if(game_over){
                image(axolotl_death, x-size-5, y-size-5);
            }
        }
        else if(chosen==2){ 
            image(chick, x-size-5,y-size-5);
            if(game_over){
                image(chick_death, x-size-5, y-size-5);
            } 
        }
        else if(chosen==3){
            image(earth, x-size-5, y-size-5);
            if(game_over){
                image(earth_death, x-size-5, y-size-5);
            }
        }
        else{ //in case the image fails lol
            fill(255);
            circle(x,y,size*2);
        }
    }

    void down(){
        y+=speed;
        if(speed<15){
            speed += gravity;
        }
    }

    void up(){
        speed = base_s;
        y+=speed;
    }

    void death(){
        if(y<=850){
            y+=speed;
            speed+=gravity*2; //makes the bird die faster
        }
    }
}
