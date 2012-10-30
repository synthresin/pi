class Icon {

  int type;
  int posX, posY;
  int iSize = 38;
  
  Icon(int _t, int _x, int _y) {
    type = _t;
    posX = _x;
    posY = _y;
    
  }
  
  void draw() {
    fill(255,255,255);
    ellipse(posX, posY, 38, 38);
  }
 
}
