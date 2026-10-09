class PowerUp {
  // Consutructor
  int x, y, size, speed;
  color c1;
  char type;
  PImage r1;
  // Member Methods
  PowerUp(int x, int y) {
    this.x = x;
    this.y = y;
    size = int(random(25, 100));
    speed = int(random(2, 10));
    c1 = color(#869AA2);
    r1 = loadImage("reallybadstar.png");
    if (random(3) > 2.0) {
      type = 'h';
    } else if (random(2) > 1.0) {
      type = 't';
    } else {
      type = 's';
      // No really... a really bad star!
    }
  }

  // Member Methods

  void display() {
    imageMode(CENTER);
    image(r1, x, y, size, size);
    //textSize(20);
    //text(type,x,y);
  }

  void move() {
    y = y + speed;
  }

  boolean isOffScreen() {
    if (y > height + 50) {
      return true;
    } else {
      return false;
    }
  }

  boolean isHit(Ship s) {
    float d = dist(x, y, s.x, s.y);
    if (d < 50) {
      return true;
    } else {
      return false;
    }
  }
}
