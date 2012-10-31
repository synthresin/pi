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
  
  void update() {
    // modun particle update
    for (int i = particles.size(); i > 0; i--) { 
      Particle p = (Particle) particles.get(i-1);
      p.update();
    }
  }
  
  void draw() {
    noStroke();
    if (type == "white") {
      fill(255,255,255);
    } else if (type == "gray") {
      fill(147,149,152);
    }  else if (type == "red") {
      fill(205,58,50);
    }
    pushMatrix();
    translate(posX, posY);
    
    for (int i = particles.size(); i > 0; i--) { 
      Particle p = (Particle) particles.get(i-1);
      p.draw();
    } 
    
    
    popMatrix();
  }

}

