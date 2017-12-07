/**
* Which Face Is Which
* Daniel Shiffman
* http://shiffman.net/2011/04/26/opencv-matching-faces-over-time/
*
* Modified by Jordi Tost (call the constructor specifying an ID)
* @updated: 01/10/2014
*/

class Face {

    // A Rectangle
    Rectangle r;
    PVector loc;

    // Am I available to be matched?
    boolean available;

    // Should I be deleted?
    boolean delete;

    // How long should I live if I have disappeared?
    int timer = 127;

    // Assign a number to each face
    int id;

    // assign a random color
    color col;

    // Make me
    Face(int newID, int x, int y, int w, int h) {
        r = new Rectangle(x, y, w, h);
        loc = new PVector(x, y);
        available = true;
        delete = false;
        id = newID;
        col = color(random(150, 255), random(150, 255), random(150, 255), 60 );
    }

    // Show me
    void display() {
        pushMatrix();
        scale(xScl, yScl);
        scale(-1, 1);
        translate(-width/xScl, 0);
        fill(0, 0, 255, timer);
        stroke(0, 0, 255);
        rect(r.x, r.y, r.width, r.height);

        //rect(r.x*scl,r.y*scl,r.width*scl, r.height*scl);
        fill(255, timer*2);
        text(""+id, r.x+10, r.y+30);
        //text(""+id,r.x*scl+10,r.y*scl+30);
        //text(""+id,r.x*scl+10,r.y*scl+30);
        popMatrix();
    }

    // Give me a new location / size
    // Oooh, it would be nice to lerp here!
    void update(Rectangle newR) {
        r = (Rectangle) newR.clone();
    }

    void updateForMovers() {
        loc.x = r.x + r.width*0.5;
        loc.y = r.y + r.height*0.5;

        loc.x = width - (loc.x * xScl);
        loc.y = loc.y * yScl;
    }

    // Count me down, I am gone
    void countDown() {
        timer--;
    }

    // I am deed, delete me
    boolean dead() {
        if (timer < 0) return true;
        return false;
    }
}
