// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  // The Mover tracks position, velocity, and acceleration 
  PVector position;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed;
  float closeFaceX = 0;
  float closeFaceY = 0;

  Mover() {
    // Start in the center
    position = new PVector(random(width),random(height));
    velocity = new PVector(0,0);
    topspeed = 5;
  }

  void update(Rectangle f) {
    
    
    //if( faceList.size() > 0 ){
    //  for (Face f : faceList) {
    //   // Find faces[index] that is closest to face f
    //   // set used[index] to true so that it can't be used twice
    //   float record = 50000;
    //   int index = -1;
    //   for (int i = 0; i < faces.length; i++) {
    //     float d = dist(faces[i].x,faces[i].y,position.x, position.y);
    //     if (d < record) {
    //       record = d;
    //       index = i;
    //       closeFaceX = faces[i].x;
    //       closeFaceY = faces[i].y;
    //     } 
    //   }
    //  }
      
    //}
    
    // Compute a vector that points from position to mouse
    PVector mouse = new PVector( f.x, f.y );
    acceleration = PVector.sub(mouse,position);
    // Set magnitude of acceleration
    //acceleration.setMag(0.2);
    acceleration.normalize();
    acceleration.mult(0.2);
    
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // position changes by velocity
    position.add(velocity);
  }

  void display(color c) {
    noStroke();
    fill(c);
    ellipse(position.x,position.y,10,10);
  }

}