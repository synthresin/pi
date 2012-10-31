import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import megamu.mesh.*; 
import ddf.minim.spi.*; 
import ddf.minim.signals.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.ugens.*; 
import ddf.minim.effects.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class pi extends PApplet {









PImage bg;

//intro controller
IntroController intro = new IntroController();
//music controller
MusicController musics = new MusicController();
Minim minim;

public void setup() {
  
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

public void draw() {
  // draw background
  image(bg, width/2,height/2,1024,768);
  
  // draw intro
  if(intro.activated) intro.draw();
  
  // draw music
  if(musics.activated) musics.draw();
}

public void mousePressed() {
  
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
  
  public void draw() {
    fill(255,255,255);
    image(img,posX,posY,img.width,img.height);
    drawPopup();
  }
  
  public void drawPopup() {
    if(mouseX > posX - img.width/2 && mouseX < posX + img.width/2 && mouseY > posY - img.height/2 && mouseY < posY + img.height/2) {
      image(popup,posX,posY,popup.width,popup.height);
    }
  }
  
  
 
}
class IntroController {

  PImage img[];
  
  int      sectionNum = 2;
  int      current_section = 0;
  boolean  activated = true; 
  
  public void setup() {
    img = new PImage[sectionNum];
    for(int i = 0; i < sectionNum; i++) {
    img[i] = loadImage("unit_info0" + i + ".png");
    }
  }
  
  public void draw() {
    fill(0,0,0,180); 
    rect(0,0,1024,768);
    
    // render each section img
    for(int i = 0; i< sectionNum; i++) {
      if (current_section == i) {
        image(img[i], width/2,height/2,383,303);
      }
    }
  }
  
  public void mousePressed() {
    println("x: " + mouseX + ", y: " + mouseY);
    if(mouseX > 479 && mouseX < 544 && mouseY > 227 && mouseY < 263) {
      decrSection();
    } else if(mouseX > 479 && mouseX < 544 && mouseY > 503 && mouseY < 538) {
      incrSection();
    }
  }
 
 public void incrSection() {
   if(current_section >= sectionNum -1) {
     current_section = 0;
   } else current_section++;
   println("incred section: " + current_section);
 }

 public void decrSection() {
   if(current_section <= 0) {
     current_section = sectionNum -1;
   } else current_section--;
   println("decred section: " + current_section);
 } 
 
 public void deactivate() {
   activated = false;
 }
 
 
} 
class Music {
  
  AudioPlayer in;
  FFT         fft;
  boolean     playing;
  ArrayList   icons;
  PImage pBar;
  float barPosX;
  ParticleController pController[];
  
  Music() {
    
  }
  
  public void setup(int musicNum, Minim minim) {
    in = minim.loadFile("music" + musicNum +".mp3", 1024);
    fft = new FFT( in.bufferSize(), in.sampleRate() );
    icons = new ArrayList();
    pBar = loadImage("bar.png");
    
    pController = new ParticleController[3]; 
    pController[0] = new ParticleController(206, 383, "white",50);
    pController[1] = new ParticleController(512, 383, "gray",50);
    pController[2] = new ParticleController(816, 383, "red",50);
  }
  
  public void play() {
    this.in.play();
    this.playing = true;
  }
  
  public void stop() {
    this.in.pause();
    this.playing = false;
  }
  
  public void draw() {
      fft.forward( in.mix );
      //Particle Controller
      float low = fft.calcAvg(60, 300);
      float mid = fft.calcAvg(300, 2000);
      float high = fft.calcAvg(2000, 7000);
      println("low: " + low +", mid: " + mid + ", high: " + high );
      
      pController[0].update(low * 2.4f);
      pController[1].update(mid * 10);
      pController[2].update(high * 50);
      
      for(int i =0; i<3 ;i++) {
        pController[i].draw();
      }
    
    barPosX = map(in.position(), 0, in.length(),118,906);
    image(pBar, barPosX, height/2, 5,875);
    
    
    for (int i = icons.size(); i > 0; i--) { 
      Icon icon = (Icon) icons.get(i-1);
      if(icon.posX < barPosX) icon.draw();
    }
    
    
  }
  
  public void activate() {
    this.in.rewind();
    this.in.loop();
    this.playing = true;
  }
}
class MusicController {
  Music m[];
  int current_music = 0;
  PImage playBtn;
  PImage pauseBtn;
  int musicNum = 3;
  

  boolean activated = false;
  public void setup() {
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
  
  
  
  public void init(Minim minim) {
    
    activated = true;
    
    m[current_music].activate();
    
    
    //println(m[current_music].icons.size());
    
    
    
  }
  
  
  
  public void draw() {
      
    //draw each music
    for(int i=0; i < m.length; i++) {
        if (current_music == i) {
        m[i].draw();
        }
      } 
      
      // UI
      if(m[current_music].playing) {
        image(pauseBtn, 967,92,26,71);
      } else {
        image(playBtn, 967,92,26,71);
      }
  }
  
  public void togglePlay() {
    if(m[current_music].playing) {
        m[current_music].stop();
    } else {
        m[current_music].play();
    }
  }
  
  public void nextMusic() {
    m[current_music].stop();
    
   if(current_music >= musicNum -1) {
     current_music = 0;
   } else current_music++;
   
   m[current_music].activate();
   println("incred music: " + current_music);
 }

 public void prevMusic() {
   m[current_music].stop();
   
   if(current_music <= 0) {
     current_music = musicNum -1;
   } else current_music--;
   
   m[current_music].activate();
   println("decred music: " + current_music);
 } 
  
  public void mousePressed() {
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
class Particle {
  int posX;
  int posY;
  
  Particle(int _posX, int _posY) {
    posX = _posX;
    posY = _posY;
  }
  public void update(float freq) {
    posX = (int)random(-freq, freq);
    posY = (int)random(-freq, freq);
  }
  public void draw() {
    ellipse(posX, posY, 6, 6);
  }

}

class ParticleController {
  int posX;
  int posY;
  String type;
  ArrayList   particles;
  int numParticle;
  
  ParticleController(int _posX, int _posY, String _type, int _numParticle) {
    posX = _posX;
    posY = _posY;
    particles = new ArrayList();
    type = _type;
    numParticle = _numParticle;
    
    //add particles
    for(int i = 0; i < numParticle;i ++) {
      particles.add(new Particle((int)random(-30, 30),(int)random(-30,30) ));
    }
    
  }
  
  public void update(float freq) {
    // modun particle update
    for (int i = particles.size(); i > 0; i--) { 
      Particle p = (Particle) particles.get(i-1);
      p.update(freq);
    }
  }
  
  public void draw() {
   
    pushMatrix();
    translate(posX, posY);
    
    stroke(255);
    // make line
    float[][] points = new float[numParticle][2];
    
    for(int i = 0; i < particles.size(); i++) {
      Particle p = (Particle) particles.get(i);
      points[i][0] = p.posX;
      points[i][1] = p.posY;
    }
    
    Delaunay myDelaunay = new Delaunay( points );
    float[][] myEdges = myDelaunay.getEdges();
    
    for(int i=0; i<myEdges.length; i++)
    {
      float startX = myEdges[i][0];
      float startY = myEdges[i][1];
      float endX = myEdges[i][2];
      float endY = myEdges[i][3];
      line( startX, startY, endX, endY );
    }
    
    noStroke();
    if (type == "white") {
      fill(255,255,255);
    } else if (type == "gray") {
      fill(147,149,152);
    }  else if (type == "red") {
      fill(205,58,50);
    }
    
    for (int i = particles.size(); i > 0; i--) { 
      Particle p = (Particle) particles.get(i-1);
      p.draw();
    } 
    
    
    popMatrix();
  }

}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pi" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
