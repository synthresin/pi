class MusicController {
  Music m[];

  boolean activated = false;

  void init() {
    activated = true;
    m = new Music[3]; // array init
    for(int i = 0; i < m.length; i++) {
      m[i] = new Music();
    } 
    
  }
  
  void draw() {
      fill(255,255,255,255);
      rect(10,20,30,40);  
  }
  
  void mousePressed() {

  }
 
} 
