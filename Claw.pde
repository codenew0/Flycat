/*
  Claw CLASS:
  -----------
  A skill of player will be released while player ate a fish.
  The skill is always aiming to boss, and hit it to reduce its life.
  
  VARIABLES:
  ----------
  img:          claw image
  x, y:         claw image's position
  speed:        claw's moving speed
  theta:        the theta from release position(player) to boss's position.
  
  FUNCTION:
  ---------
  lockTarget:   calculate the theta of object
  isHitted:     judge if boss is hit by claw
  display:      show claw
*/
class Claw {
  PImage img;
  float x, y;
  float speed;
  float theta;
  
  Claw(String img_path) {
    img = loadImage(path + "/" + img_path);
    x = 0;
    y = 0;
    speed = 5;
  }
  
  void lockTarget(Player player, float target_x, float target_y) {
    x = player.position.x;
    y = player.position.y;
    theta = atan((target_y - y) / (target_x - x));
  }
  
  boolean isHitted(Boss boss) {
    float w = img.width;
    if (x + w > boss.w / 5 + boss.x) {
        return true;
    }
    return false;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(theta);
    x += speed * cos(theta);
    y += speed * sin(theta);
    image(img, 0, 0);
    popMatrix();
  }
}
