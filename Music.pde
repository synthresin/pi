class Music {
  
  AudioPlayer in;
  FFT         fft;
  boolean     playing;
  
  Music() {
    
  }
  
  void init(int musicNum, Minim minim) {
    in = minim.loadFile("music" + musicNum +".mp3", 1024);
    fft = new FFT( in.bufferSize(), in.sampleRate() );
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
  
    for(int i = 0; i < fft.specSize(); i++)
    {
      stroke(255);
    // draw the line for frequency band i, scaling it up a bit so we can see it
      line( i, height, i, height - fft.getBand(i)*8 );
    }
  }
  
  void activate() {
    this.in.play(0);
    this.playing = true;
  }
}
