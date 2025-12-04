//This is where all game events, except for the actual game code, is located

void pregame(){ //the title screen
    background(milky);

    textSize(90);
    fill(255);
    text("FLAPPY BIRD", 400,200);

    textSize(60);
    text("but it's the milky way", 400,350);

    //start button
    fill(0);
    rect(400-textWidth("start"),540,2*textWidth("start"),90);
    fill(255);
    text("START", 400,600);

    //if the mouse hovers over the start button: inverse the colors
    if(mouseX>=400-textWidth("start") && mouseX<=400+textWidth("start") && mouseY>=540 && mouseY<=630){
      fill(255);
      rect(400-textWidth("start"),540,2*textWidth("start"),90);
      fill(0);
      text("START", 400,600);

      if(mousePressed){ //if the button is clicked, start the game
        delay(500); //wait half asecond
        pregame = false;
        game_start = true;
      }
    }
}

//void selection{} //character selection screen

void game_over(){
    background(milky);

    for(Wall w: walls){ //displays all walls
        w.display();
    }

    bird[chosen].death(); //the bird dies :(
    bird[chosen].display(); //displays the bird

    fill(255);
    textSize(90);
    text("GAME OVER", 400, 300); //GAME OVER text

    ////restart button////
    textSize(60);
    fill(0);
    rect(400-textWidth("restart"),490,2*textWidth("restart"),90);
    fill(255);
    text("RESTART", 400,550);

    //if the mouse hovers over the restart button: inverse the colors
    if(mouseX>=400-textWidth("restart") && mouseX<=400+textWidth("restart") && mouseY>=490 && mouseY<=580){
      fill(255);
      rect(400-textWidth("restart"),490,2*textWidth("restart"),90);
      fill(0);
      text("RESTART", 400,550);

      if(mousePressed){ //if you press the restart button, restart the game
        //resets the variables
        frameCount = 0;
        score = 0;
        bird[chosen].y = 400;
        bird[chosen].speed = bird[chosen].base_s;
        for (int i = walls.size()-1; i>-1; i--) { //removes all walls
            walls.remove(i);
        }

        delay(500); //wait half asecond
        game_start = true;
        game_over = false;
      }
    }

    ////exit button////
    textSize(60);
    fill(0);
    rect(400-textWidth("exit"),590,2*textWidth("exit"),90);
    fill(255);
    text("EXIT", 400,650);

    //if the mouse hovers over the restart button: inverse the colors
    if(mouseX>=400-textWidth("exit") && mouseX<=400+textWidth("exit") && mouseY>=590 && mouseY<=680){
      fill(255);
      rect(400-textWidth("exit"),590,2*textWidth("exit"),90);
      fill(0);
      text("EXIT", 400,650);

      if(mousePressed){ //if you press the exit button, exit the game
        //resets all the variables
        frameCount = 0;
        score = 0;
        bird[chosen].y = 400;
        bird[chosen].speed = bird[chosen].base_s;
        for (int i = walls.size()-1; i>-1; i--) { //removes all walls
            walls.remove(i);
        }

        delay(500); //wait half asecond
        pregame = true;
        game_over = false;
      }
    }
}
