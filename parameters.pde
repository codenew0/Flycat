Rain rain;
StarRain stars;
Timer timer;
Star mouse;
Player player;
Boss boss;

SoundFile bgMusic;
SoundFile failSound;
SoundFile attackedSound;
SoundFile skillSound;
SoundFile winSound;

PImage icon;
PFont font;
ArrayList<Fish> fishes;
ArrayList<Claw> claws;

String loading = "FLYCAT is praying";
String flycat_text = "FLYCAT";
String starting = "---------Space to start---------";
String hint = "Catch the mouse!";
String win_text = "YOU WIN!";
String congra_text = "Bickey Mouse is Catched!";
String lose_text = "YOU LOSE";
String replay_text = "---------Enter to play again---------";

String path;
String player_img = "flycat.png";
String player_dead_img = "flycat_dead.png";
String icon_img = "icon.png";
String fish_img = "fish.png";
String claw_img = "claw.png";
String boss_img = "boss.png";


int star_freq;
int life = 5;

float text_x;
float icon_theta;

boolean soundLoaded = false;
boolean gameStarted = false;
boolean isWinning = false;
boolean isLosing = false;
boolean isReplaying = false;

color[] c = {
  color(213, 245, 227),
  color(245, 203, 167),
  color(174, 214, 241),
  color(215, 189, 226),
  color(245, 183, 177)
};
int c_i = 0;
