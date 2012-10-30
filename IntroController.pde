class IntroController {

  PImage img[];
  
  int      sectionNum = 2;
  int      current_section = 0;
  boolean  activated = true; 
  
  void setup() {
    img = new PImage[sectionNum];
    for(int i = 0; i < sectionNum; i++) {
    img[i] = loadImage("unit_info0" + i + ".png");
    }
  }
  
  void draw() {
    fill(0,0,0,180); 
    rect(0,0,1024,768);
    
    // render each section img
    for(int i = 0; i< sectionNum; i++) {
      if (current_section == i) {
        image(img[i], width/2,height/2,383,303);
      }
    }
  }
  
  void mousePressed() {
    println("x: " + mouseX + ", y: " + mouseY);
    if(mouseX > 479 && mouseX < 544 && mouseY > 227 && mouseY < 263) {
      decrSection();
    } else if(mouseX > 479 && mouseX < 544 && mouseY > 503 && mouseY < 538) {
      incrSection();
    }
  }
 
 void incrSection() {
   if(current_section >= sectionNum -1) {
     current_section = 0;
   } else current_section++;
   println("incred section: " + current_section);
 }

 void decrSection() {
   if(current_section <= 0) {
     current_section = sectionNum -1;
   } else current_section--;
   println("decred section: " + current_section);
 } 
 
 void deactivate() {
   activated = false;
 }
 
 
} 
