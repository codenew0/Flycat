/*
  StarRain CLASS:
  -----------
  Controll all stars to start, stop, restart
  
  VARIABLES:
  ----------
  frequency:    stars' falling frequency
  timer:        controll the falling quantity of drops by frequency
  stars:        an array to store all stars. For removing easily
  isStop:       check if the rain has stopped
  
  FUNCTION:
  ---------
  start:          start "star raining"
  stop:           stop "star raining"
  restart:        restart "star raining"  after stopping
  setTime:        change the frequency of occurrence of stars
  isCollided:     check if player is hit by star
  removeClicked:  the star will be removed if click it
*/
class StarRain {
  int frequency;
  Timer timer;
  ArrayList<Star> stars;
  boolean isStop;
  
  StarRain(int frequency) {
    this.frequency = frequency;
    stars = new ArrayList<Star>();
    timer = new Timer(frequency);
    isStop = false;
  }
  
  void start() {
    if (isStop) {
      return ;
    }
    if (timer.isFinished()) {
      float up_down = int(random(0, 2));
      float y;
      if (up_down == 0) {
         y = random(0, 10);
      } else {
        y = random(height - 10, height);
      }
      stars.add(new Star(random(width), y, random(10, 30)));
      for (int i = 0; i < stars.size(); i++) {
        Star star = stars.get(i);
        if (star.reachedBottom()) {
          stars.remove(i);
        }
      }
      timer.start();
    }
    
    for (int i = 0; i < stars.size(); i++) {
      stars.get(i).move();
      stars.get(i).display();
    }
  }
  
  void stop() {
    isStop = true;
    for (int i = 0; i < stars.size(); i++) {
      stars.remove(i);
    }
  }
  
  void setTime(int time) {
    frequency = time;
    timer.setTotaltime(frequency);
  }
  
  boolean isCollided(Player player) {
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      if (star.isCollided(player)) {
        stars.remove(i);
        return true;
      }
    }
    return false;
  }
  
  void removeClicked(float x, float y) {
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      if (x < star.x + star.w && x > star.x - star.w &&
          y < star.y + star.w && y > star.y - star.w) {
        stars.remove(i);
        return;
      }
    }
  }
  
  void restart() {
    isStop = false;
  }
}
