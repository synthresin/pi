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
  
  void setup(int musicNum, Minim minim) {
    in = minim.loadFile("music" + musicNum +".mp3", 1024);
    fft = new FFT( in.bufferSize(), in.sampleRate() );
    icons = new ArrayList();
    pBar = loadImage("bar.png");
    
    pController = new ParticleController[3]; 
    pController[0] = new ParticleController(206, 383, "white",50);
    pController[1] = new ParticleController(512, 383, "gray",50);
    pController[2] = new ParticleController(816, 383, "red",50);
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
      fft.forward( in.mix );
      //Particle Controller
      float low = fft.calcAvg(60, 300);
      float mid = fft.calcAvg(300, 2000);
      float high = fft.calcAvg(2000, 7000);
      println("low: " + low +", mid: " + mid + ", high: " + high );
      
      pController[0].update(low * 2.4);
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
  
  void activate() {
    this.in.rewind();
    this.in.loop();
    this.playing = true;
  }
}
