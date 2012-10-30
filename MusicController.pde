class MusicController {
  Music m[];
  AudioPlayer in;

  boolean activated = false;

  void init(Minim minim) {
    activated = true;
    m = new Music[1]; // array init
    for(int i = 0; i < m.length; i++) {
      m[i] = new Music();
      m[i].init(i);
    } 
    in = minim.loadFile("music0.mp3");
    in.play(0);
  }
  
  void draw() {
      fill(255,255,255,255);
      rect(10,20,30,40);  
  }
  
  void mousePressed() {

  }
 
} 
