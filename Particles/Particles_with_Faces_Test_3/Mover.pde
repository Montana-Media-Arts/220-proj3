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
  int index;

  color col;

  Mover() {
    // Start in the center
    position = new PVector(random(width),random(height));
    velocity = new PVector(0,0);
    topspeed = 5;
  }

  void update(ArrayList<Face> faceList) {


    if( faceList.size() > 0 ){
      for (Face f : faceList) {
       // Find faces[index] that is closest to face f
       // set used[index] to true so that it can't be used twice
       float record = 50000;
       index = -1;
       for (int i = 0; i < faces.length; i++) {
         float d = dist(faces[i].x,faces[i].y,position.x, position.y);
         if (d < record) {
           record = d;
           index = i;
           closeFaceX = faces[i].x;
           closeFaceY = faces[i].y;
           
         }
       }
      }

    }
    
    col = faceList[index];

    // Compute a vector that points from position to mouse
    PVector mouse = new PVector( closeFaceX, closeFaceY );
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

  void display() {
    //Controls color of the floaters, 4th number controls opacity
    fill(col);
    // fill(255,255,255,60);
    noStroke();
    ellipse(position.x,position.y,9,9);
  }

}