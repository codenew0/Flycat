class Star {
  float x, y;
  float w;
  float speed;
  float direction;
  float theta;
  PVector[] point;
  PVector line_p;
  color c;
  Star(float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
    theta = 0;
    speed = random(1, 2);
    c = color(random(255), random(255), random(255));
    if (x > width / 2 && y > height / 2) {    //IV
      direction = random(270, 360);
    } else if (x >= width / 2 && y <= height / 2) {   // I
      direction = random(0, 90);
    } else if (x < width / 2 && y <= height / 2) {    // II
      direction = random(90, 180);
    } else {        // III
      direction = random(180, 270);
    }
    line_p = new PVector(w * cos(radians(direction)), 
                         -w * sin(radians(direction)));
    point = new PVector[10];
    float inner = w / (tan(radians(36)) / tan(radians(18)) + 1) / 
                            cos(radians(36));
    point[0] = new PVector(0, - w);
    point[1] = new PVector(cos(radians(54)) * inner,
                           -sin(radians(54)) * inner);
    point[2] = new PVector(cos(radians(18)) * w,
                           -sin(radians(18)) * w);
    point[3] = new PVector(cos(radians(18)) * inner,
                           sin(radians(18)) * inner);
    point[4] = new PVector(cos(radians(54)) * w,
                           sin(radians(54)) * w);
    point[5] = new PVector(0, inner);
    point[6] = new PVector(-cos(radians(54)) * w,
                           sin(radians(54)) * w);
    point[7] = new PVector(-cos(radians(18)) * inner,
                           sin(radians(18)) * inner);
    point[8] = new PVector(-cos(radians(18)) * w,
                           -sin(radians(18)) * w);
    point[9] = new PVector(-cos(radians(54)) * inner,
                           -sin(radians(54)) * inner);
  }
  boolean reachedBottom() {
    if (y > height + w || y < -w || x > width + w || x < -w) {
      return true; 
    } else {
      return false;
    }
  }
  
  boolean isCollided(Player player) {
    float x = player.position.x + player.img.width / 1.8;
    float y = player.position.y + player.img.width / 2;
    float w = player.img.width / 5;
    if (x - w < this.x + this.w && x + w > this.x - this.w &&
        y - w < this.y + this.w && y + w > this.y - this.w) {
        return true;
    }
    return false;
  }
  
  void move() {
    x -= speed * cos(radians(direction));
    y += speed * sin(radians(direction));
  }
  
  void display() {
    stroke(0);
    strokeWeight(3);
    pushMatrix();
    fill(c);
    translate(x, y);
    rotate(theta);
    beginShape();
    for (int i = 0; i < 10; i++) {
      vertex(point[i].x, point[i].y);
    }
    vertex(point[0].x, point[0].y);
    endShape();
    popMatrix();
    line(x + line_p.x, y + line_p.y,
         x + 2 * line_p.x, y + 2 * line_p.y);
    line(x + line_p.x - line_p.y * 0.6, y + line_p.y + line_p.x * 0.6,
         x + 2 * line_p.x - line_p.y * 0.6, y + 2 * line_p.y + line_p.x * 0.6);
    line(x + line_p.x + line_p.y * 0.6, y + line_p.y - line_p.x * 0.6,
         x + 2 * line_p.x + line_p.y * 0.6, y + 2 * line_p.y - line_p.x * 0.6);
    theta += 0.04;
  }
  
  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void stick() {
    stroke(0);
    strokeWeight(3);
    pushMatrix();
    translate(x, y);
    beginShape();
    endShape();
    vertex(w/2, 0);
    vertex(w/-2, 0);
    vertex(2*w, 2*w);
    vertex(1.5*w, 2.5*w);
    vertex(w/2, 0);
    beginShape();
    for (int i = 0; i < 10; i++) {
      vertex(point[i].x, point[i].y);
    }
    vertex(point[0].x, point[0].y);
    endShape();
    popMatrix();
  }
}
