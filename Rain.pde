/*
  Rain CLASS:
  -----------
  Rain is deformed by drops.
  Controll all drops to start, stop, restart
  
  VARIABLES:
  ----------
  frequency:    drops' falling frequency
  timer:        controll the falling quantity of drops by frequency
  drops:        an array to store all drops. For removing easily
  isStop:       check if the rain has stopped
  
  FUNCTION:
  ---------
  start:          start raining
  stop:           stop raining
  restart:        restart raining after stopping
*/
class Rain {
  int frequency;
  Timer timer;
  ArrayList<Drop> drops;
  boolean isStop;
  
  Rain(int frequency) {
    this.frequency = frequency;
    drops = new ArrayList<Drop>();
    timer = new Timer(frequency);
    isStop = false;
  }
  
  void start() {
    if (isStop) {
      return ;
    }
    if (timer.isFinished()) {
      drops.add(new Drop());
      
      for (int i = 0; i < drops.size(); i++) {
        Drop drop = drops.get(i);
        if (drop.reachedBottom()) {
          drops.remove(i);
        }
      }
      timer.start();
    }
    
    for (int i = 0; i < drops.size(); i++) {
      drops.get(i).move();
      drops.get(i).display();
    }
  }
  
  void stop() {
    isStop = true;
    for (int i = 0; i < drops.size(); i++) {
      drops.remove(i);
    }
  }
  
  void restart() {
    isStop = false;
  }
}
