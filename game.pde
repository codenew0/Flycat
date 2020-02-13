import processing.sound.*;

void setup() {
  path = dataPath("");
  size(800, 600);
  setupIcon();
  frameRate(60);
  thread("loadSound");
  setupFont();
  setupPlayer();
  setupFishes();
  setupClaws();
  setupBoss();
  setupStars();
  setupRain();
  setupCursor();
  setupTimer();
}

void draw() {
  if (!soundLoaded) {
    loadingText();
    return;
  }
  background(c[c_i]);
  player.display();
  player.displayLifes();
  boss.display();
  rain.start();
  if (player.isDead()) {
    if (!isPlayed_fail && !attackedSound.isPlaying()) {
      isPlayed_fail = true;
      failSound.play();
    }
    stars.stop();
    mouse.setPosition(mouseX, mouseY);
    mouse.stick();
    return;
  }
  stars.start();
  fishes.get(0).display();
  if (!player.isDead() && stars.isCollided(player)) {
    attackedSound.play();
    player.beAttacked();
    c_i = (c_i + 1) % c.length;
  }
  if (player.isDead()) {
    if (!isPlayed_fail && !attackedSound.isPlaying()) {
      isPlayed_fail = true;
      failSound.play();
    }
    stars.stop();
  }
  
  if (fishes.get(0).isCatched(player)) {
    fishes.remove(0);
    fishes.add(new Fish(fish_img));
    skillSound.play();
    claws.add(new Claw(claw_img));
    claws.get(claws.size() - 1).lockTarget(player, boss.x + boss.w / 2, boss.y + boss.h / 2);
    star_freq -= 10;
  }
  for (int i = 0; i < claws.size(); i++) {
    Claw claw = claws.get(i);
    claw.display();
    if (claw.isHitted(boss)) {
      claws.remove(i);
      boss.beHitted();
    }
  }

  if (timer.isFinished()) {
    stars.setTime(star_freq);
    timer.start();
  }
  mouse.setPosition(mouseX, mouseY);
  mouse.stick();
}

void loadingText() {
  background(c[c_i]);
  fill(0);
  textFont(font, 100);
  textAlign(LEFT);
  text(loading, text_x, height/2);
  text_x -= 3;
  float w = textWidth(loading);
  if (text_x < -w) {
    c_i = (c_i + 1) % c.length;
    text_x = width;
  }
  pushMatrix();
  translate(10 + icon.width / 2, height - icon.height / 2 - 10);
  rotate(icon_theta);
  image(icon, icon.width / -2, icon.height / -2);
  icon_theta += 0.05;
  popMatrix();
  mouse.setPosition(mouseX, mouseY);
  mouse.stick();
}

void loadSound() {
  attackedSound = new SoundFile(this, path + "/attacked.mp3");
  failSound = new SoundFile(this, path + "/fail.mp3");
  skillSound = new SoundFile(this, path + "/skill.mp3");
  bgMusic = new SoundFile(this, path + "/RAVELA - Cotton Candy.mp3");
  soundLoaded = true;
  bgMusic.play();
  bgMusic.loop();
}

void mousePressed() {
  stars.removeClicked(mouseX, mouseY);
  //c_i = (c_i + 1) % c.length;
}

void keyPressed() {
  if (player.isDead()) {
    return ;
  }
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
  }
}
