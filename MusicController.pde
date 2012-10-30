class MusicController {
  Music m[];
  int current_music = 0;
  PImage playBtn;
  PImage pauseBtn;
  int musicNum = 3;
 

  boolean activated = false;
  void setup() {
    playBtn = loadImage("play.png");
    pauseBtn = loadImage("pause.png");
    
    m = new Music[musicNum]; // array init
    for(int i = 0; i < m.length; i++) {
      m[i] = new Music();
      m[i].setup(i, minim);
      
    } 
    
    // add icons to first object
    m[0].icons.add(new Icon(3, 520, 342));
    m[0].icons.add(new Icon(3, 420, 142));
    m[0].icons.add(new Icon(3, 320, 242));
    m[0].icons.add(new Icon(3, 220, 642));
    m[0].icons.add(new Icon(3, 120, 642));
  }
  
  void init(Minim minim) {
    
    activated = true;
    
    
    m[current_music].activate();
    //println(m[current_music].icons.size());
    
    
    
  }
  
  void draw() {
      
      
    
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
