class Music {
  
  AudioPlayer in;
  FFT         fft;
  boolean     playing;
  ArrayList   icons;
  PImage pBar;
  float barPosX;
  ParticleController pController[];
  ArrayList lowTone;
  ArrayList midTone;
  ArrayList highTone;
  
  Music() {
    
  }
  
  void setup(int musicNum, Minim minim) {
    in = minim.loadFile("music" + musicNum +".mp3", 1024);
    fft = new FFT( in.bufferSize(), in.sampleRate() );
    icons = new ArrayList();
    pBar = loadImage("bar.png");
    
    pController = new ParticleController[3]; 
    pController[0] = new ParticleController(206, 383, "white",1024);
    pController[1] = new ParticleController(512, 383, "gray",1024);
    pController[2] = new ParticleController(816, 383, "red",1024);
  }
  
  void play() {
    this.in.play();
    this.playing = true;
  }
  
  void stop() {
    this.in.pause();
    this.playing = false;
  }
  
  void draw() {
    
      //Particle Controller
      fft.forward( in.mix );
      
      int k =0;
      for(int i = 0; i < fft.specSize(); i++)
      {
        Particle p = (Particle) pController[0].particles.get(k);
        
        p.posX = (int)fft.getBand(i)*8;
        k++;
        stroke(255);
        // draw the line for frequency band i, scaling it up a bit so we can see it
        line( i, height, i, height - fft.getBand(i)*8 );
      }
      
      
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
  
  void activate() {
    this.in.rewind();
    this.in.loop();
    this.playing = true;
  }
}
