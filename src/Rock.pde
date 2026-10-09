class Rock {
  // Member Method
  int x, y, w, h, health, hitPoints, speed;
  boolean isHit;
  color c1, c2;
  PImage r1;
  // Constructor
  Rock(int x, int y) {
    this.x = x;
    this.y = y;
    w = int(random(20, 100));
    h = int(random(20, 100));
    health = 100;
    hitPoints = 100;
    isHit = false;
    speed = int(random(1, 6));
    c1 = color(#869AA2);
    c2 = color(#869AA9);

    if (random(2) > 1) {
      r1 = loadImage("supposedlyUnRock.png");
    } else {
      r1 = loadImage("justAnotherRock.png");
    }
  }
  // Member Methods

  void display() {
    if (health > 50) {
      fill(c2);
    } else {
      fill(c1);
    }
    if (r1 != null) {
      image(r1, x, y, w, h);
    }
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
