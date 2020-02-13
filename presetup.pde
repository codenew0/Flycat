void setupFont() {
  font = createFont("Arial", 16, true);
  text_x = width;
}

void setupPlayer() {
  player = new Player(0, height / 2, player_img, player_dead_img, icon_img);
}

void setupFishes() {
  fishes = new ArrayList<Fish>();
  fishes.add(new Fish(fish_img));
}

void setupClaws() {
  claws = new ArrayList<Claw>();
}

void setupStars() {
  stars = new StarRain(star_freq);
}

void setupRain() {
  rain = new Rain(10);
}

void setupCursor() {
  noCursor();
  mouse = new Star(mouseX, mouseY, 5);
}

void setupTimer() {
  timer = new Timer(1000);
  timer.start();
}

void setupIcon() {
  icon = loadImage("icon.png");
  surface.setIcon(icon);
}

void setupBoss() {
  boss = new Boss(boss_img);
}
