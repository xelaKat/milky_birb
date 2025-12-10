//This is where all game events, except for the actual game code, is located

void pregame(){ //the title screen
    background(milky);

    //FOG!!! This plays on all screens
    if(fog_count%300==0){
      fog.add(new Fog()); //creates fog every 5 seconds
    }

    for(int i = fog.size()-1; i>-1; i--){ //displays all fog, moves them, and deletes them
      fog.get(i).display();
      fog.get(i).move();

      if(fog.get(i).x < -250){ //removes fog that goes off screen
        fog.remove(i);
      }
    }

    //Title
    textSize(140);
    fill(255);
    text("FLAPPY BIRD", 400,200);

    textSize(80);
    text("but it's the milky way", 400,270);

    //Description
    textFont(font2);
    textSize(35);
    text("Navigate the universe without crashing and bending", 400,395);
    text("the space-time continuum!", 400,435);
    textFont(font1);

    //start button
    textSize(80);
    fill(0);
    rect(400-textWidth("start "),540,2*textWidth("start "),90);
    fill(255);
    text("START", 400,600);

    //if the mouse hovers over the start button: inverse the colors
    if(mouseX>=400-textWidth("start ") && mouseX<=400+textWidth("start ") && mouseY>=540 && mouseY<=630){
      fill(255);
      rect(400-textWidth("start "),540,2*textWidth("start "),90);
      fill(0);
      text("START", 400,600);

      if(mousePressed){ //if the button is clicked, go to character selection screen
        pregame = false;
        selection = true;
        delay(500); //wait half asecond
      }
    }
}

void selection(){ //character selection screen
  background(milky);

  //FOG!!! This plays on all screens
  if(fog_count%300==0){
    fog.add(new Fog()); //creates fog every 5 seconds
  }

  for(int i = fog.size()-1; i>-1; i--){ //displays all fog, moves them, and deletes them
    fog.get(i).display();
    fog.get(i).move();

    if(fog.get(i).x < -250){ //removes fog that goes off screen
      fog.remove(i);
    }
  }

  //Character selection
    textSize(80);
    fill(255);
    text("Choose your character", 400,420);

    //character cards:

    //// CHARACTER 1 ////
    stroke(255);
    noFill();
    rect(50,50,300,300,30); //the last 30 gives the rect rounded corners - same for all the other character rectangles
    image(big_moonfish, 55,55); // character 1

    if(mouseX>=50 && mouseX<=350 && mouseY>=50 && mouseY<=350){ //if mouse hovers over this character
      fill(255,50);
      rect(50,50,300,300,30);
      if(mousePressed){ //chooses the character and starts the game
        chosen = 0;
        noStroke();
        
        delay(500); //waits half a second
        selection = false;
        game_start = true;
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }

    //// CHARACTER 2 ////
    noFill();
    rect(450,50,300,300,30);
    //character 2

    if(mouseX>=450 && mouseX<=750 && mouseY>=50 && mouseY<=350){ //if mouse hovers over this character
      fill(255,50);
      rect(450,50,300,300,30);
      if(mousePressed){ //chooses the character and starts the game
        chosen = 1;
        noStroke();
        
        delay(500); //waits half a second
        selection = false;
        game_start = true;
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }

    //// CHARACTER 3 ////
    noFill();
    rect(50,450,300,300,30);
    image(big_chick,50,450); //character 3

    if(mouseX>=50 && mouseX<=350 && mouseY>=450 && mouseY<=750){ //if mouse hovers over this character
      fill(255,50);
      rect(50,450,300,300,30);
      if(mousePressed){ //chooses the character and starts the game
        chosen = 2;
        noStroke();
        
        delay(500); //waits half a second
        selection = false;
        game_start = true;
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }

    //// CHARACTER 4 ////
    noFill();
    rect(450,450,300,300,30);
    //character 4

    if(mouseX>=450 && mouseX<=750 && mouseY>=450 && mouseY<=750){ //if mouse hovers over this character
      fill(255,50);
      rect(450,450,300,300,30);
      if(mousePressed){ //chooses the character and starts the game
        chosen = 3;
        noStroke();
        
        delay(500); //waits half a second
        selection = false;
        game_start = true;
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }

}

void game_over(){
    background(milky);

    //FOG!!! This plays on all screens
    if(fog_count%300==0){
      fog.add(new Fog()); //creates fog every 5 seconds
    }

    for(int i = fog.size()-1; i>-1; i--){ //displays all fog, moves them, and deletes them
      fog.get(i).display();
      fog.get(i).move();

      if(fog.get(i).x < -250){ //removes fog that goes off screen
        fog.remove(i);
      }
    }

    for(Wall w: walls){ //displays all walls
        w.display();
    }

    bird[chosen].death(); //the bird dies :(
    bird[chosen].display(); //displays the bird

    //GAME OVER text
    fill(255);
    textSize(120);
    text("GAME OVER", 400,250);

    //final score and highscore
    fill(255,30);
    stroke(255);
    rect(200,290,400,150,30);
    noStroke();

    fill(255);
    textFont(font2);
    textSize(50);
    text("Final Score: " + int(score), 400,350);
    text("Highscore: " + int(highscore), 400,400);
    textFont(font1);

    ////restart button////
    textSize(80);
    fill(0);
    rect(400-textWidth("restart "),490,2*textWidth("restart "),90);
    fill(255);
    text("RESTART", 400,550);

    //if the mouse hovers over the restart button: inverse the colors
    if(mouseX>=400-textWidth("restart ") && mouseX<=400+textWidth("restart ") && mouseY>=490 && mouseY<=580){
      fill(255);
      rect(400-textWidth("restart "),490,2*textWidth("restart "),90);
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
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }

    ////exit button////
    textSize(80);
    fill(0);
    rect(400-textWidth("exit "),590,2*textWidth("exit "),90);
    fill(255);
    text("EXIT", 400,650);

    //if the mouse hovers over the exit button: inverse the colors
    if(mouseX>=400-textWidth("exit ") && mouseX<=400+textWidth("exit ") && mouseY>=590 && mouseY<=680){
      fill(255);
      rect(400-textWidth("exit "),590,2*textWidth("exit "),90);
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

        delay(500); //wait half a second
        pregame = true;
        game_over = false;
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }
}
