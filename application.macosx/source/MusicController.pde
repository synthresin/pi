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
    m[0].icons.add(new Icon(1, 123, 63, 123, 63, "0"));
    m[0].icons.add(new Icon(4, 167, 339, 167, 339, "0"));
    m[0].icons.add(new Icon(3, 210, 63, 210, 63, "0"));
    m[0].icons.add(new Icon(7, 210, 615, 210, 615, "0"));
    m[0].icons.add(new Icon(7, 253, 615, 253, 615, "0"));
    m[0].icons.add(new Icon(3, 295, 249, 295, 249, "0"));
    
    m[0].icons.add(new Icon(0, 338, 615, 338, 615, "0"));
    m[0].icons.add(new Icon(6, 383, 249, 383, 249, "0"));
    m[0].icons.add(new Icon(2, 426, 431, 426, 431, "0"));
    m[0].icons.add(new Icon(5, 468, 7075, 468, 707, "0"));
    m[0].icons.add(new Icon(2, 513, 155, 513, 155, "0"));
    m[0].icons.add(new Icon(4, 555, 523, 555, 523, "0"));
    m[0].icons.add(new Icon(7, 599, 431, 599, 431, "0"));
    m[0].icons.add(new Icon(0, 643, 63, 643, 63, "0"));
    m[0].icons.add(new Icon(6, 686, 155, 686, 155, "0"));
    m[0].icons.add(new Icon(3, 729, 155, 729, 155, "0"));
    m[0].icons.add(new Icon(1, 773, 247, 773, 247, "0"));
    m[0].icons.add(new Icon(1, 816, 247, 816, 247, "0"));
    m[0].icons.add(new Icon(7, 859, 615, 859, 615, "0"));
    m[0].icons.add(new Icon(6, 902, 155, 902, 155, "0"));
    
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
