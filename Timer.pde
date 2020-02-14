/*
  Timer CLASS:
  ------------
  A new behavior will be excuted after a round of timer
  
  VARIABLES:
  ----------
  savedTime:    save current time
  totalTime:    a whole round time
  
  FUNCTION:
  ---------
  start:          start timer
  setTotaltime:   set a whole round time
  isFinished:     check if timer has passed a round
*/
class Timer {
  int savedTime;
  int totalTime;
  
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }
  
  void start() {
    savedTime = millis();
  }
  
  void setTotaltime(int time) {
    totalTime = time;
  }
  
  boolean isFinished() {
    int passedTime = millis() - savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
