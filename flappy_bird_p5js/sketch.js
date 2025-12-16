//// !!! Variables !!! ////

//fonts
let font1;
let font2;

//music
//import processing.sound.*;
let intro_music;
let game_music;
let jump;

//bird (the playable character) initialization and images
let bird = [];
let chosen = 1; //determines which bird is playing

//character 1
let moonfish;
let moonfish_death; //moonfish but upside down
let big_moonfish; //big moonfish for the character selection screen
//character 2
let axolotl;
let axolotl_death; //axolotl but upside down
let big_axolotl; //big axolotl for the character selection screen
//character 3
let chick;
let chick_death; //chick but upside down
let big_chick; //big chick for the character selection screen
//character 4
let earth;
let earth_death; //earth but upside down
let big_earth; //big earth for the character selection screen

//walls
let walls = [];
let wall1;
let wall2;
let wall3;

//fog - floats in the background for aesthetics
let fog = [];
let fog_count = 0; //counter for when to create fog
let fog1;
let fog2;
let fog3;
let fog4;

//boundary images
let void1;
let void2;

//background image
let milky;

let score = 0; //your score
let highscore = 0; //your highscore

//sequence booleans - determines which phase of the game you are in
let pregame = true; //title screen
let selection = false; //character selection screen
let game_start = false; //actual gameplay screen
let game_over = false; //end screen
let wait = false; //controls when to start spawning walls (after the player first jumps)

//collision variables for the player
let collision_x;
let collision_y;

function preload(){
    //font text
    font1 = loadFont("YouthTouch.ttf",24); //imports font
    font2 = loadFont("StylishCalligraphy.ttf",24); //another font

    //music
    intro_music = loadSound("The_Hitchhiker's_Guide_To_The_Galaxy.mp3");
    game_music = loadSound("Across_The_Void.mp3");
    jump = loadSound("jump.mp3");

    //bird / player images
    //character 1
    moonfish = loadImage("moonfish.png");
    moonfish_death = loadImage("moonfish_death.png");
    big_moonfish = loadImage("big_moonfish.png");

    //character 2
    axolotl = loadImage("axolotl.png");
    axolotl_death = loadImage("axolotl_death.png");
    big_axolotl = loadImage("big_axolotl.png");

    //character 3
    chick = loadImage("chick.png");
    chick_death = loadImage("chick_death.png");
    big_chick = loadImage("big_chick.png");

    //character 4
    earth = loadImage("earth.png");
    earth_death = loadImage("earth_death.png");
    big_earth = loadImage("big_earth.png");

    //other images
    wall1 = loadImage("wall1.png");
    wall2 = loadImage("wall2.png");
    wall3 = loadImage("wall3.png");

    fog1 = loadImage("fog1.png");
    fog2 = loadImage("fog2.png");
    fog3 = loadImage("fog3.png");
    fog4 = loadImage("fog4.png");

    void1 = loadImage("void1.png");
    void2 = loadImage("void2.png");

    milky = loadImage("milky.png");
}

function setup(){
  createCanvas(800,800);

  //font text
  textFont(font1); //sets the font
  textAlign(CENTER);
  noStroke();
  pixelDensity(1);
  
  //music
  game_music.setVolume(0.2); //makes this music quieter
  intro_music.loop(); //starts the music

  big_moonfish.resize(290,290); //the png is a little too big so it is resized

  //creates the actual birds
  bird.push(new Bird(moonfish));
  bird.push(new Bird(axolotl));
  bird.push(new Bird(chick));
  bird.push(new Bird(earth));

  //adding some fog in the beginning
  for(let i = 0; i < 10; i++){
    fog.push(new Fog(random(0,800)));
  }
}

function draw(){ //for game events that are just a function, check the sequence tab
  if(selection){ //selection screen - comes before title screen to make sure it won't get skipped by the mouseclick logic when switching screens
    selection();
  }

  else if(pregame){ //title screen
    pregame();

    //music
    if(game_music.isPlaying()){ //stops the game_music if it is playing
      game_music.pause();
    }
  }

  else if(game_start){ //actual game screen
    //music
    if(intro_music.isPlaying()){ //stops the intro_music if it is playing
      intro_music.pause();
    }
    if(!game_music.isPlaying()){ //starts the game_music if it is not playing
      game_music.loop();
    }
  } 

  else if(game_over){ //end screen
    game_over();
  }

  fog_count++; //fog_count controls when to spawn fog - increases every frame

  //the void AKA bounds (there are images so the player knows that they can't hit the top or bottom of the screen)
  image(void1, 0,-75);
  image(void2, 0,650);
}

function keyPressed(){
  if(key==' '){
    if(game_start){
      bird[chosen].up(); //jump!
      jump.play(); //sound effect
    }
    if(wait){
      wait = false; //turns off wait when you jump
    }
  }
}

// ------- sequence ------- //
// * This is where all game events are located * //

function pregame(){ //the title screen
    background(milky);

    //FOG!!! This plays on all screens//
    if(fog_count%300==0){
      fog.push(new Fog()); //creates fog every 5 seconds
    }

    for(let i = fog.length-1; i>-1; i--){ //displays all fog, moves them, and deletes them
      fog[i].display();
      fog[i].move();

      if(fog[i].x < -250){ //removes fog that goes off screen
        fog.splice(i,1);
      }
    }

    //Title
    textSize(140);
    fill(255);
    text("FLAPPY BIRD", 400,200);

    //Caption
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

      if(mouseIsPressed){ //if the button is clicked, go to character selection screen
        setTimeout(() => {
            pregame = false;
            selection = true; // This will run after a 0.5-second delay
        }, 500);
      }
    }
}

function selection(){ //character selection screen
  background(milky);

  //FOG!!! This plays on all screens//
  if(fog_count%300==0){
    fog.push(new Fog()); //creates fog every 5 seconds
  }

  for(let i = fog.length-1; i>-1; i--){ //displays all fog, moves them, and deletes them
    fog[i].display();
    fog[i].move();

    if(fog[i].x < -250){ //removes fog that goes off screen
      fog.splice(i,1);
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
    image(big_moonfish, 55,55); //character 1: moonfish

    if(mouseX>=50 && mouseX<=350 && mouseY>=50 && mouseY<=350){ //if mouse hovers over this character
      fill(255,50);
      rect(50,50,300,300,30);

      if(mouseIsPressed){ //chooses the character and starts the game
        chosen = 0;
        noStroke();
        
        setTimeout(() => {
            selection = false;
            game_start = true;
        }, 500);
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }

    //// CHARACTER 2 ////
    noFill();
    rect(450,50,300,300,30);
    image(big_axolotl, 450,50); //character 2: axolotl

    if(mouseX>=450 && mouseX<=750 && mouseY>=50 && mouseY<=350){ //if mouse hovers over this character
      fill(255,50);
      rect(450,50,300,300,30);

      if(mouseIsPressed){ //chooses the character and starts the game
        chosen = 1;
        noStroke();
        
        setTimeout(() => {
            selection = false;
            game_start = true;
        }, 500);
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }

    //// CHARACTER 3 ////
    noFill();
    rect(50,450,300,300,30);
    image(big_chick,50,450); //character 3: chick in spaceship

    if(mouseX>=50 && mouseX<=350 && mouseY>=450 && mouseY<=750){ //if mouse hovers over this character
      fill(255,50);
      rect(50,450,300,300,30);
      
      if(mouseIsPressed){ //chooses the character and starts the game
        chosen = 2;
        noStroke();
        
        setTimeout(() => {
            selection = false;
            game_start = true;
        }, 500);
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }

    //// CHARACTER 4 ////
    noFill();
    rect(450,450,300,300,30);
    image(big_earth, 450,450); //character 4: earth

    if(mouseX>=450 && mouseX<=750 && mouseY>=450 && mouseY<=750){ //if mouse hovers over this character
      fill(255,50);
      rect(450,450,300,300,30);
      if(mouseIsPressed){ //chooses the character and starts the game
        chosen = 3;
        noStroke();
        
        setTimeout(() => {
            selection = false;
            game_start = true;
        }, 500);
        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }

}

function game_start(){
    background(0); //in case the image fails lol
    background(milky);

    // FOG!!! This plays on all screens //
    if(fog_count%300==0){
      fog.push(new Fog()); //creates fog every 5 seconds
    }

    for(let i = fog.size()-1; i>-1; i--){ //displays all fog, moves them, and deletes them
      fog[i].display();
      fog[i].move();

      if(fog[i].x < -250){ //removes fog that goes off screen
        fog.splice(i,1);
      }
    }

    //Walls
    //basically the same code as fog
    if(frameCount%90==30){ //creats new walls every 1.5 seconds - modulo == 30 because then the walls will spawn half a second after starting
      let _y = random(-500, 0);
      walls.push(new Wall(_y));
      walls.push(new Wall(_y+800));
    }

    for(let i = walls.length-1; i>-1; i--){ //displays all walls, moves them, and deletes them
      walls[i].move();
      walls[i].display();

      if(walls[i].x < -walls[i].w){ //removes walls that go off screen
        walls.splice(i,1);
      }
    }

    //bounds - if you go out of bounds, you die
    if(bird[chosen].y-bird[chosen].size<=0 || bird[chosen].y+bird[chosen].size>=height){
      bird[chosen].speed = 10; //resets the speed to the bird will immediately fall

      setTimeout(() => {
            game_start = false;
            game_over = true;
        }, 100);
    }

    if(wait){ //wait is triggered when the game starts/restarts. It makes the walls and gravity wait until the player presses the space bar to jump, just like the original game
      fill(255);
      textSize(40);
      text("SPACE bar to jump", 350,400);
      frameCount = 0;
    }
    else{ //if the waiting time is over, gravity is applied, the score is shown, and the walls start appearing - they didn't earlier because wait kept the frameCount at 0, and walls rely on the frameCount to be generated
      bird[chosen].down(); //applies gravity

      //display score
      textFont(font2);
      textSize(80);
      fill(255);
      text(int(score), 400, 150);
      textFont(font1);
    }

    bird[chosen].display(); //displays the bird

    //collision logic and score system
    //this logic is at the very end so that the player can see all the elements on screen and accurately judge the distance between hitboxes before the bird gets hit
    for (let w of walls) {
      if (bird[chosen].x == w.x + w.w){ //score code
        score+=0.5; //adds 0.5 because there are two walls for each column
        if(score>highscore){ //sets your highscore
          highscore = score;
        }
      }

      //collision code
      collision_x = w.x <= bird[chosen].x + bird[chosen].size && w.x + w.w >= bird[chosen].x - bird[chosen].size; //if the x coords collide
      collision_y = w.y <= bird[chosen].y + bird[chosen].size && w.y + w.h >= bird[chosen].y - bird[chosen].size; //if the y coords collide
      if(collision_x && collision_y){ //if collide, game over
        setTimeout(() => {
            game_start = false;
            game_over = true;
        }, 100);
      }
    }
}

function game_over(){
    background(milky);

    //FOG!!! This plays on all screens//
    if(fog_count%300==0){
      fog.push(new Fog()); //creates fog every 5 seconds
    }

    for(let i = fog.length-1; i>-1; i--){ //displays all fog, moves them, and deletes them
      fog[i].display();
      fog[i].move();

      if(fog[i].x < -250){ //removes fog that goes off screen
        fog.splice(i,1);
      }
    }

    for (let w of walls){ //displays all walls
        w.display();
    }

    bird[chosen].death(); //the bird dies :(
    bird[chosen].display(); //displays the bird

    //GAME OVER text
    fill(255);
    textSize(120);
    text("GAME OVER", 400,250);

    //final score and highscore
    //rect
    fill(255,30);
    stroke(255);
    rect(200,290,400,150,30);
    noStroke();
    //text
    fill(255);
    textFont(font2);
    textSize(50);
    text("Final Score: " + floor(score), 400,350);
    text("Highscore: " + floor(highscore), 400,400);
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

      if(mouseIsPressed){ //if you press the restart button, restart the game
        //resets the variables
        frameCount = 0;
        score = 0;
        bird[chosen].y = 400;
        bird[chosen].speed = bird[chosen].base_s;
        for (let i = walls.length-1; i>-1; i--) { //removes all walls
            walls.splice(i,1);
        }

        setTimeout(() => {
            game_start = true;
            game_over = false;
        }, 500);
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

      if(mouseIsPressed){ //if you press the exit button, exit the game
        //resets all the variables
        frameCount = 0;
        score = 0;
        bird[chosen].y = 400;
        bird[chosen].speed = bird[chosen].base_s;
        for(let i = walls.length-1; i>-1; i--) { //removes all walls
            walls.splice(i,1);
        }

        setTimeout(() => {
            pregame = true;
            game_over = false;
        }, 500);
        
        game_music.stop();
        intro_music.loop();

        wait = true; //the game waits until the player starts to spawn walls and apply gravity
      }
    }
}