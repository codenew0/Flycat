/*
  Boss CLASS:
  -----------
  Boss is on the right side of window. It will be minimized by hitting a skill(claw).
  The boss will be beated while it has only one life, and be catched by player.
  
  VARIABLES:
  ----------
  img:          boss image
  x, y:         boss image's center coordinate
  w, h:         boss image's width, height
  origin_w:     boss image's first width (boss's size is changing during the game)
  life:         boss's current health
  life_weight:  boss's full health
  
  FUNCTION:
  ---------
  beHitted:     boss is effectively hit and the health will be reduced
  isCatched:    judge if boss is catched by player
  display:      show boss, resize boss according to boss's health
*/
class Boss {
  PImage img;
  float x, y;
  float origin_w;
  float w, h;
  int life;
  int life_weight;
  
  Boss(String img_path) {
    img = loadImage(path + "/" + img_path);
    w = img.width;
    h = img.height;
    origin_w = w;
    x = width - w / 2;
    y = height - h;
    life = 20;
    life_weight = life;
  }
  
  void beHitted() {
    life--;
  }
  
  boolean isCatched(Player player) {
    float x = player.position.x + player.img.width / 1.8;
    float y = player.position.y + player.img.width / 2;
    float w = player.img.width / 5;
    if (x - w < this.x + this.w && x + w > this.x - this.w &&
        y - w < this.y + this.w && y + w > this.y - this.w) {
        return true;
    }
    return false;
  }
  
  void display() {
    if (life > 0) {
      img.resize((int)(life * origin_w / life_weight), (int)(life * origin_w / life_weight));
      w = img.width;
      h = img.height;
      x = width - w / 2;
      y = height - w - 50;
    }
    image(img, x, y);
  }
}
