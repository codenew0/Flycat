import processing.sound.*;

/*
  Initiate window, objects
  Player, Rain, Skill(Claw), Boss, Stars(StarRain), Timer
*/
void setup() {
  // get the resource's path
  path = dataPath("");
  size(800, 600);
  frameRate(60);
  // Create a thread to load sounds
  thread("loadSound");
  // initiate objects(presetup file)
  setupObjects();
}

/*
  loadingUI -> startUI -> gameUI -> winUI/loseUI -> gameUI
*/
void draw() {
  // Enter lodingUI until sounds are loaded completely
  if (!soundLoaded) {
    loadingUI();
    return;
  }
  // Enter startUI until "space" key is pressed
  if (!gameStarted) {
    startUI();
    return;
  }
  // Game start until a result(win/lose) has came out
  if (!isWinning && !isLosing) {
    gameRunning();
  }
  // Enter winUI if winning
  if (isWinning) {
    winUI();
  } 
  // Enter loseUI if losing
  if (isLosing) {
    loseUI();
  }
  // Play again if "enter" key is pressed in win/lose UI
  if (isReplaying) {
    isWinning = false;
    isLosing = false;
    isReplaying = false;
    // reset objects
    setupObjects();
  }
}

/* 
  Wait for loading sounds
*/
void loadingUI() {
  background(c[c_i]);
  fill(0);
  // show text
  textFont(font, 100);
  textAlign(LEFT);
  text(loading, text_x, height/2);
  text_x -= 3;
  float w = textWidth(loading);
  if (text_x < -w) {
    c_i = (c_i + 1) % c.length;
    text_x = width;
  }
  // a rotating icon
  pushMatrix();
  translate(10 + icon.width / 2, height - icon.height / 2 - 10);
  rotate(icon_theta);
  image(icon, icon.width / -2, icon.height / -2);
  icon_theta += 0.05;
  popMatrix();
  // set mouse image as a stick
  mouse.setPosition(mouseX, mouseY);
  mouse.stick();
}

/*
  Waiting for player to start game
*/
void startUI() {
  background(c[c_i]);
  fill(0);
  // show text
  textFont(font, 100);
  textAlign(CENTER);
  text(flycat_text, width / 2, height / 2);
  textFont(font, 30);
  text(starting, width / 2, height * 0.75);
  // show player image
  player.display();
}

/*
  Main gameUI
*/
void gameRunning() {
  background(c[c_i]);
  // show player
  player.display();
  // show player's lifes
  player.displayLifes();
  // show boss
  boss.display();
  // show rain
  rain.start();
  // show stars
  stars.start();
  // show fish
  if (!fishes.isEmpty()) {
    fishes.get(0).display();
  }
  // player dead, enter loseUI
  if (player.isDead()) {
    if (!isLosing && !attackedSound.isPlaying()) {
      isLosing = true;
      failSound.play();
    }
    stars.stop();
    mouse.setPosition(mouseX, mouseY);
    mouse.stick();
    return;
  }
  // player is collided by stars -> lose health, change background
  if (!player.isDead() && stars.isCollided(player)) {
    attackedSound.play();
    player.beAttacked();
    c_i = (c_i + 1) % c.length;
  }
  // fish is catched by player
  if (!fishes.isEmpty() && fishes.get(0).isCatched(player)) {
    // remove catched fish, add new fish
    fishes.remove(0);
    if (boss.life > 2) {
      fishes.add(new Fish(fish_img));
    }
    skillSound.play();
    // release skill(claw)
    claws.add(new Claw(claw_img));
    // skill aims to boss
    claws.get(claws.size() - 1).lockTarget(player, boss.x + boss.w / 2, boss.y + boss.h / 2);
    // add frequency of occurrence of stars
    star_freq -= 10;
  }
  // boss is hitted by claw
  for (int i = 0; i < claws.size(); i++) {
    Claw claw = claws.get(i);
    claw.display();
    if (claw.isHitted(boss)) {
      claws.remove(i);
      // reduce boss's health
      boss.beHitted();
    }
  }
  // the final health of boss should be reduced by player
  if (boss.life == 1) {
    // show hint text
    catchHint();
    // fish doesn't occur at all
    if (!fishes.isEmpty()) {
      fishes.remove(0);
    }
    // boss is catched by player -> enter winUI
    if (boss.isCatched(player)) {
      isWinning = true;
      winSound.play();
      return;
    }
  }
  // set timer to produce stars
  if (timer.isFinished()) {
    stars.setTime(star_freq);
    timer.start();
  }
  // set mouse image in gameUI
  mouse.setPosition(mouseX, mouseY);
  mouse.stick();
}

/*
  Show hint text while boss remains only one health
*/
void catchHint() {
  textFont(font, 30);
  textAlign(RIGHT, BOTTOM);
  text(hint, width, height);
}

/*
  Win the game
*/
void winUI() {
  background(c[c_i]);
  fill(0);
  // show texts
  textFont(font, 100);
  textAlign(CENTER);
  text(win_text, width / 2, height / 2);
  textFont(font, 50);
  text(congra_text, width / 2, height * 0.75);
  textFont(font, 30);
  textAlign(CENTER, BOTTOM);
  text(replay_text, width / 2, height);
  // show player
  player.display();
  // show mouse image
  mouse.setPosition(mouseX, mouseY);
  mouse.stick();
}

/*
  Lose the game
*/
void loseUI() {
  background(c[c_i]);
  fill(0);
  // show boss
  boss.display();
  // show texts
  textFont(font, 100);
  textAlign(CENTER);
  text(lose_text, width / 2, height / 2);
  textFont(font, 30);
  textAlign(CENTER, BOTTOM);
  text(replay_text, width / 2, height);
  //show mouse image
  mouse.setPosition(mouseX, mouseY);
  mouse.stick();
}

/*
  Load all sounds in this game
*/
void loadSound() {
  bgMusic = new SoundFile(this, path + "/RAVELA - Cotton Candy.mp3");
  attackedSound = new SoundFile(this, path + "/attacked.mp3");
  failSound = new SoundFile(this, path + "/fail.mp3");
  skillSound = new SoundFile(this, path + "/skill.mp3");
  winSound = new SoundFile(this, path + "/catched.mp3");
  soundLoaded = true;
  bgMusic.play();
  bgMusic.loop();
}

/*
  Click stars to destory them
*/
void mousePressed() {
  stars.removeClicked(mouseX, mouseY);
}

/*
  "UP(w)/DOWN(s)/RIGHT(d)/LEFT(a)" to contorl player
  "space" to start game
  "enter" to restart game
*/
void keyPressed() {
  switch (keyCode) {
    case UP:
    case 'W':
       player.move(0, -1);
       break;
    case DOWN:
    case 'S':
       player.move(0, 1);
       break;
    case LEFT:
    case 'A':
       player.move(-1, 0);
       break;
    case RIGHT:
    case 'D':
       player.move(1, 0);
       break;
    case ' ':
       if (!gameStarted) {
         gameStarted = true;
       }
       break;
    case ENTER:
       if ((isLosing || isWinning) && !isReplaying) {
         isReplaying = true;
       }
       break;
  }
}
