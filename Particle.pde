class Particle {
  int posX;
  int posY;
  
  Particle(int _posX, int _posY) {
    posX = _posX;
    posY = _posY;
  }
  void update() {
   
  }
  void draw() {
    ellipse(posX, posY, 7, 7);
  }

}

