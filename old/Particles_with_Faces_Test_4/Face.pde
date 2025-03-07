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

  // Am I available to be matched?
  boolean available;

  // Should I be deleted?
  boolean delete;

  // How long should I live if I have disappeared?
  int timer = 127;

  // Assign a number to each face
  int id;

  Mover[] movers = new Mover[1000];


  // particle color
  color part_color = color(random(255), random(255), random(255), 120);

  // Make me
  Face(int newID, int x, int y, int w, int h) {
    r = new Rectangle(x, y, w, h);
    available = true;
    delete = false;
    id = newID;
    for (int i = 0; i < movers.length; i++) {
      movers[i] = new Mover();
    }
  }

  // Show me
  void display() {
    fill(0, 0, 0, timer);
    ellipse(r.x, r.y, r.width, r.height);
    //rect(r.x*scl,r.y*scl,r.width*scl, r.height*scl);
    fill(0, timer*2);
    text(""+id, r.x+10, r.y+30);
    //text(""+id,r.x*scl+10,r.y*scl+30);
    //text(""+id,r.x*scl+10,r.y*scl+30);

    for (int i = 0; i < movers.length; i++) {
      movers[i].update(r);
      movers[i].display(part_color);
    }
  }

  // Give me a new location / size
  // Oooh, it would be nice to lerp here!
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
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