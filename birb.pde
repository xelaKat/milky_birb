class Bird{
    float x = 200; //x coord is constant
    float y = 400; //spawns at 400
    float size; //the radius of the collision circle of the bird

    //speed
    float base_s = -7; //the default speed - constant
    float speed = base_s; //variable which gets added to the bird's y, which is how it jumps and how gravity works
    float gravity = 0.4; //changes the speed


    Bird(PImage i){ //doesn't actually use the image; image parameter is mainly to make sure I know which character is which bird in the main cide
        size = 25; //measurement used for collision logic
    }

    void display(){
        if(chosen==0){
            image(moonfish, x-size-5, y-size-5); //wierd coordinates because the image is 60x60 while the bird is 50x50. the bird coords are also based on a circle, so the square png coords have to be adjusted
            if(game_over){
                image(moonfish_death, x-size-5, y-size-5); //death
            }
        }
        else if(chosen==1){
            image(axolotl, x-size-5, y-size-5); //wierd coordinates because the image is 60x60 while the bird is 50x50. the bird coords are also based on a circle, so the square png coords have to be adjusted
            if(game_over){
                image(axolotl_death, x-size-5, y-size-5); //death
            }
        }
        else if(chosen==2){ 
            image(chick, x-size-5,y-size-5); //wierd coordinates because the image is 60x60 while the bird is 50x50. the bird coords are also based on a circle, so the square png coords have to be adjusted
            if(game_over){
                image(chick_death, x-size-5, y-size-5); //death
            } 
        }
        else if(chosen==3){
            image(earth, x-size-5, y-size-5); //wierd coordinates because the image is 60x60 while the bird is 50x50. the bird coords are also based on a circle, so the square png coords have to be adjusted
            if(game_over){
                image(earth_death, x-size-5, y-size-5); //death
            }
        }
        else{ //in case the image fails lol
            fill(255);
            circle(x,y,size*2); //for reference, this is the collision circle
        }
    }

    void down(){ //function applies the speed to the birb and also includes the gravity code
        y+=speed;

        if(speed<15){ //gravity stops at speed 15 or else you'll fall too fast
            speed += gravity;
        }
    }

    void up(){ //jump
        speed = base_s; //resets the speed
        y+=speed;
    }

    void death(){
        if(y<=850){
            y+=speed;
            speed+=gravity*2; //makes the bird die faster
        }
    }
}
