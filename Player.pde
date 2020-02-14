/*
  Player CLASS:
  -------------
  The movement can be contorlled by a real player.
  Player can eat fish and be hitted by stars.
  When it is hitted, the life will be reduced.
  
  VARIABLES:
  ----------
  img:            player's image
  img_dead:       player's dead image
  life_img:       icon to show the remain life of player
  position:       player's position
  life:           player's life
  speed:          player's final speed
  current_speed:  current speed to reach final speed
  life_icons:     an array to store player's life. For removing easily
  x_off, y_off:   direction of movement. 1 for DOWN/RIGHT, -1 for UP/LEFT
  
  
  FUNCTION:
  ---------
  isDead:         if player is dead
  move:           change player's movement parameters
  beAttacked:     judge if player is hit by stars
  reachedBottom:  judge if player has reached bottom(if player is dead, it will fall down)
  displayLifes:   show player's life icons
  display:        show player
*/
class Player {
  PImage img, img_dead, life_img;
  PVector position;
  int life;
  float speed, current_speed;
  int x_off, y_off;
  ArrayList<PImage> life_icons;
  
  Player(float x, float y, String img, String img_dead, String life_img) {
    position = new PVector(x, y);
    this.img = loadImage(path + "/" + img);
    this.img_dead = loadImage(path + "/" + img_dead);
    this.life_img = loadImage(path + "/" + life_img);
    life = 5;
    life_icons = new ArrayList<PImage>();
    for (int i = 0; i < life; i++) {
      life_icons.add(this.life_img);
    }
    speed = 10;
  }
  
  boolean isDead() {
    if (life <= 0) {
      return true;
    }
    return false;
  }
  
  void move(int x_offset, int y_offset) {
    current_speed = 1;
    x_off = x_offset;
    y_off = y_offset;
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
      if (current_speed < speed) {
        position.x += current_speed * x_off;
        position.x = constrain(position.x, img.width / -2, width - img.width / 2);
        position.y += current_speed * y_off;
        position.y = constrain(position.y, img.height / -2, height - img.height / 2);
        current_speed += 2;
      }
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
