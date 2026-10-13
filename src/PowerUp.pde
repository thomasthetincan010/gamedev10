class PowerUp {
  int x, y, size, speed;
  char type;
  PImage r1;

  PowerUp(int x, int y) {
    this.x = x;
    this.y = y;
    size = int(random(30, 60));
    speed = int(random(2, 6));
    r1 = loadImage("reallybadstar.png");

    float pValue = random(3);
    if (pValue > 2.0) {
      type = 'h'; // Health
    } else if (pValue > 1.0) {
      type = 't'; // Turret (the amoun)
    } else {
      type = 's'; // Speed (laser speed)
    }
  }

  void display() {
    imageMode(CENTER);
    if (r1 != null) {
      image(r1, x, y, size, size);
    }
    fill(255);
    textSize(16);
    textAlign(CENTER, CENTER);
    text(type, x, y);
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
    if (d < 40) {
      return true;
    } else {
      return false;
    }
  }
}
