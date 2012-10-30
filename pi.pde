import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

PImage bg;

//intro controller
IntroController intro = new IntroController();
//music controller
MusicController musics = new MusicController();
Minim minim;

void setup() {
  
  // basic app setup
  minim = new Minim(this);
  size(1024,768);
  background(0,0,0);
  bg = loadImage("background.png");
  imageMode(CENTER);
  ellipseMode(CENTER); 
  
  // intro setup
  intro.setup();
  musics.setup();
  
  
  
  
  
}

void draw() {
  // draw background
  image(bg, width/2,height/2,1024,768);
  
  // draw intro
  if(intro.activated) intro.draw();
  
  // draw music
  if(musics.activated) musics.draw();
}

void mousePressed() {
  
  // global action
  if(intro.activated && mouseX > 607 && mouseX < 670 && mouseY > 293 && mouseY < 320) {
    intro.deactivate();
    musics.init(minim);
  }
  // intro mouse action
  if(intro.activated) intro.mousePressed();
  
  // music mouse action
  if(musics.activated) musics.mousePressed();
}


