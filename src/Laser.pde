class Laser {
  int x, y, w, h, speed, size;
  PImage r1;

  Laser (int x, int y) {
    this.x = x;
    this.y = y;
    w = 12;
    h = 16;
    this.speed = laserSpeed;
    size = 2;
    r1 = loadImage("laser.png");
  }

  void display() {
    imageMode(CENTER);
    if (r1 != null) {
      image(r1, x, y, w, h);
    }
  }

  void move() {
    y = y - speed;
  }

  boolean isOffScreen() {
    if (y < -20) {
      return true;
    } else {
      return false;
    }
  }

  boolean isHit(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d < 20) {
      return true;
    } else {
      return false;
    }
  }
}
