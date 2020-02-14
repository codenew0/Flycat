/*
  Fish CLASS:
  -----------
  A fish is produced randomly. When it is eaten by player, a skill will be released.
  
  VARIABLES:
  ----------
  img:          fish's image
  x, y:         fish's position
  w:            fish image's width
  
  FUNCTION:
  ---------
  isCatched:    if fish is catched by player.
  display:      show a fish
*/
class Fish {
  float x, y, w;
  PImage img;
  Fish(String img_path) {
    img = loadImage(path + "/" + img_path);
    x = random(20, width * 2 / 3);
    y = random(20, height * 2 / 3);
    w = img.width;
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
    image(img, x, y);
  }
}
