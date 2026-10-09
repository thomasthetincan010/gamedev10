class Laser {
  // Member Variables
  int x, y, w, h, speed, size;
  PImage r1;
  // Consutructor

  Laser (int x, int y) {
    this.x=x;
    this.y=y;
    w = 12;
    h = 16;
    this.speed=laserSpeed;
    size = 2;
   
  }
  // Member Methods

  void display() {
    //fill (0, 0, 255);
    //rectMode(CENTER);
    //rect(x, y, w, h);
    r1 = loadImage("laser.png");
    imageMode(CENTER);
    image(r1, x, y, w, h);
  }

  void move() {
    y = y - speed;
  }
  boolean isOffScreen() {
    if (y>height+20) {
      return true;
    } else {
      return false;
    }
  }
  boolean isHit(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<20) {
      return true;
    } else {
      return false;
    }
  }
}
