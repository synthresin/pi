class MusicController {
  Music m[];
  int current_music = 0;
 

  boolean activated = false;

  void init(Minim minim) {
    activated = true;
    m = new Music[3]; // array init
    for(int i = 0; i < m.length; i++) {
      m[i] = new Music();
      m[i].init(i, minim);
      
    } 
    m[current_music].play();
    
  }
  
  void draw() {
      for(int i=0; i < m.length; i++) {
        if (current_music == i) {
        m[i].draw();
        }
      } 
  }
  
  void mousePressed() {

  }
 
} 
