class Drop {
  float x, y;
  float speed;
  color c;
  float r;
  
  Drop() {
    r = 5;
    x = random(width);
    y = -r * 4;
    speed = random(3, 5);
    c = color(50, 100, 150);
  }
  
  Drop(float r) {
    this.r = r;
    x = random(width);
    y = -r * 4;
    speed = random(3, 5);
    c = color(50, 100, 150);
  }
  
  void move() {
    y += speed;
  }
  
  boolean reachedBottom() {
    if (y > height + r * 4) {
      return true; 
    } else {
      return false;
    }
  }
  
  void display() {
    noStroke();
    fill(c);
    for (int i = 2; i < r; i++) {
      ellipse(x, y + i * 4, i * 2, i * 2);
    }
  }
}
