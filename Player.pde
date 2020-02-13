import processing.sound.*;

class Player {
  PImage img, img_dead, life_img;
  PVector position;
  int life;
  float speed;
  ArrayList<PImage> life_icons;
  
  Player(float x, float y, String img, String img_dead, String life_img) {
    position = new PVector(x, y);
    this.img = loadImage(path + "/" + img);
    this.img_dead = loadImage(path + "/" + img_dead);
    this.life_img = loadImage(path + "/" + life_img);
    life = 100;
    life_icons = new ArrayList<PImage>();
    for (int i = 0; i < life; i++) {
      life_icons.add(this.life_img);
    }
    speed = 20;
  }
  
  boolean isDead() {
    if (life <= 0) {
      return true;
    }
    return false;
  }
  
  void move(int x_offset, int y_offset) {
    position.x += speed * x_offset;
    position.x = constrain(position.x, img.width / -2, width - img.width / 2);
    position.y += speed * y_offset;
    position.y = constrain(position.y, img.height / -2, height - img.height / 2);
  }
  
  void beAttacked() {
    life--;
    life_icons.remove(life);
  }
  
  void displayLifes() {
    for (int i = 0; i < life_icons.size(); i++) {
      pushMatrix();
      translate((i + 1) * (10 + life_img.width / 2), height - life_img.height / 2 - 10);
      image(life_img, life_img.width / -2, life_img.height / -2);
      popMatrix();
    }
  }
  
  void display() {
    if (isDead()) {
      img = loadImage(player_dead_img);
      position.y += 10;
      position.y = constrain(position.y, 0, height);
      image(img, position.x, position.y);
    } else {
      image(img, position.x, position.y);
    }
  }
  
  boolean reachedBottom() {
    if (position.y > height) {
      return true; 
    } else {
      return false;
    }
  }
}  
