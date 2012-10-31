class Icon {
  PImage img;
  PImage popup;
  int type;
  int posX, posY;
  
  Icon(int _t, int _x, int _y,int _x2, int _y2, String _popup) {
    type = _t;
    posX = _x;
    posY = _y;
    img = loadImage("icon" + _t + ".png");
    popup = loadImage("num_popup" + _popup + ".png");
    
  }
  
  void draw() {
    fill(255,255,255);
    image(img,posX,posY,img.width,img.height);
    drawPopup();
  }
  
  void drawPopup() {
    if(mouseX > posX - img.width/2 && mouseX < posX + img.width/2 && mouseY > posY - img.height/2 && mouseY < posY + img.height/2) {
      image(popup,posX,posY,popup.width,popup.height);
    }
  }
  
  
 
}
