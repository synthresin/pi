class MusicController {
  Music m[];
  int current_music = 0;
  PImage playBtn;
  PImage pauseBtn;
  PImage pBar;
  int musicNum = 3;
 

  boolean activated = false;
  void setup() {
    playBtn = loadImage("play.png");
    pauseBtn = loadImage("pause.png");
    pBar = loadImage("bar.png");
  }
  
  void init(Minim minim) {
    
    
    
    
    activated = true;
    
    m = new Music[musicNum]; // array init
    for(int i = 0; i < m.length; i++) {
      m[i] = new Music();
      m[i].init(i, minim);
      
    } 
    m[current_music].activate();
    
  }
  
  void draw() {
      // Bar
      float BarPosX = map(m[current_music].in.position(), 0, m[current_music].in.length(),0,1024);
      image(pBar, BarPosX, height/2, 5,875);
    
      // UI
      if(m[current_music].playing) {
        image(pauseBtn, 967,92,26,71);
      } else {
        image(playBtn, 967,92,26,71);
      }

      for(int i=0; i < m.length; i++) {
        if (current_music == i) {
        m[i].draw();
        }
      } 
  }
  
  void togglePlay() {
    if(m[current_music].playing) {
        m[current_music].stop();
    } else {
        m[current_music].play();
    }
  }
  
  void nextMusic() {
    m[current_music].stop();
    
   if(current_music >= musicNum -1) {
     current_music = 0;
   } else current_music++;
   
   m[current_music].activate();
   println("incred music: " + current_music);
 }

 void prevMusic() {
   m[current_music].stop();
   
   if(current_music <= 0) {
     current_music = musicNum -1;
   } else current_music--;
   
   m[current_music].activate();
   println("decred music: " + current_music);
 } 
  
  void mousePressed() {
    println("x: " + mouseX + ", y: " + mouseY);
    if(mouseX > 956 && mouseX < 980 && mouseY > 58 && mouseY < 80) {
      togglePlay();
    } else if(mouseX > 956 && mouseX < 980 && mouseY > 80 && mouseY < 102) {
      nextMusic();
    } else if(mouseX > 956 && mouseX < 980 && mouseY > 102 && mouseY < 127) {
      prevMusic();
    }
  }
  
  
 
} 
