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
  
  void update(float freq) {
    // modun particle update
    for (int i = particles.size(); i > 0; i--) { 
      Particle p = (Particle) particles.get(i-1);
      p.update(freq);
    }
  }
  
  void draw() {
   
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

