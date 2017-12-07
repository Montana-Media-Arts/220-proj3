// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

    // The Mover tracks position, velocity, and acceleration
    PVector position;
    PVector velocity;
    PVector acceleration;
    PVector destination;
    // The Mover's maximum speed
    float topspeed;
    float closeFaceX = 0;
    float closeFaceY = 0;
    int index = -1;
    float record = 50000;

    color col = color(255, 255, 255, 40);

    Mover() {
        // Start in the center
        position = new PVector(random(width),random(height));
        velocity = new PVector(0,0);
        topspeed = 10;
    }

    void update(ArrayList<Face> faceList, boolean dataNew) {

        if( dataNew ) {
            index = -1;
        }


        if( faceList.size() > 0 ){
            record = 50000;
            for (Face f : faceList) {

                float d = dist(f.loc.x,f.loc.y,position.x, position.y);
                if (d < record) {
                    record = d;

                    closeFaceX = f.loc.x;
                    closeFaceY = f.loc.y;
                    col = f.col;
                    index = f.id;
                }
            }
            // Compute a vector that points from position to mouse
            destination = new PVector( closeFaceX, closeFaceY );
            topspeed = 10;
        }

        if( index == -1 || record >= 50000 ) {
            col = color(255, 255, 255, 60);
            // Compute a vector that points from position to destination
            destination = new PVector( random(-width, width*2), random(-height, height*2) );
            topspeed = 100;
        }

        acceleration = PVector.sub(destination,position);
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
        fill( col );
        noStroke();
        ellipse(position.x,position.y,20,20);
    }

}
