class Music {
  
  AudioPlayer in;
  FFT         fft;
  boolean     playing;
  ArrayList   icons;
  PImage pBar;
  float barPosX;
  
  Music() {
    
  }
  
  void setup(int musicNum, Minim minim) {
    in = minim.loadFile("music" + musicNum +".mp3", 1024);
    fft = new FFT( in.bufferSize(), in.sampleRate() );
    icons = new ArrayList();
    pBar = loadImage("bar.png");
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
    barPosX = map(in.position(), 0, in.length(),118,906);
    image(pBar, barPosX, height/2, 5,875);
    
    fft.forward( in.mix );
  
    for(int i = 0; i < fft.specSize(); i++)
    {
      stroke(255);
    // draw the line for frequency band i, scaling it up a bit so we can see it
      line( i, height, i, height - fft.getBand(i)*8 );
    }
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
