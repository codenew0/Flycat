class Boss {
  PImage img;
  float x, y;
  float origin_w;
  float w, h;
  int life;
  
  Boss(String img_path) {
    img = loadImage(path + "/" + img_path);
    w = img.width;
    h = img.height;
    origin_w = w;
    x = width - w / 2;
    y = height - h;
    life = 20;
  }
  
  void beHitted() {
    life--;
  }
  
  void display() {
    if (life > 0) {
      img.resize((int)(life * origin_w / 20 ), (int)(life * origin_w / 20));
      w = img.width;
      h = img.height;
      x = width - w / 2;
      y = height - w - 50;
      image(img, x, y);
    }
  }
}
