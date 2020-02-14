/*
  Drop CLASS:
  -----------
  A drop is deformed by r filled circles.
  Only a background, no actual role.
  
  VARIABLES:
  ----------
  x, y:         drop's position
  speed:        drop's droping speed
  c:            drop's color
  r:            how many circles defrom a drop
  
  FUNCTION:
  ---------
  move:           move drop to another position
  reachedBottom:  judge if a drop is reaching the bottom of window
  display:        show a drop
*/
class Drop {
  float x, y;
  float speed;
  color c;
  float r;
  
  // A drop is produced from the top by random "x"
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
