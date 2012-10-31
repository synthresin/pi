class Particle {
  int posX;
  int posY;
  
  Particle(int _posX, int _posY) {
    posX = _posX;
    posY = _posY;
  }
  void update(float freq, int mx, int my) {
    
    posX = (int)random(-freq, freq);
    posY = (int)random(-freq, freq);
    
  }
  void draw() {
    
    ellipse(posX, posY, 6, 6);
  }

}

