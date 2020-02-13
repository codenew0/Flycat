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
