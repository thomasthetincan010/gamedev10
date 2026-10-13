class Boss {
  int x, y, w, h, duration, health, speed, lvl;
  boolean isHit;
  PImage b1;

  Boss(int x, int y, int lvl) {
    this.x = x;
    this.y = y;
    this.lvl = lvl;
    w = 250;
    h = 250;
    duration = 6000;
    health = 5000;
    speed = 1;
    isHit = false;
    if (lvl == 1) {
      b1 = loadImage("lvl1Boss.png");
    } else {
      if (lvl == 2)
        b1 = loadImage("lvl1Boss.png");
    }
  }

  void display() {
    fill(255, 6, 99);
    ellipse(x, y, w, h);
    fill(255);
    textAlign(CENTER, CENTER);
    text(health, x, y);
  }

  void move() {
    x += speed;
  }
}
