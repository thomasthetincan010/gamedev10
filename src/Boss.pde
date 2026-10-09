class Boss {
  int x, y, w, h, duration, health, speed, lvl;
  boolean isHit;
  PImage b1;

  // Constructor
  Boss(int x, int y, int lvl) {
    this.x=x;
    this.y=y;
    this.lvl=lvl;
    w=250;
    h=250;
    duration=6000; // testing purposes only, intended 60000
    health = 5000;
    speed=1;
    isHit = false;
    if (lvl == 1) {
      b1 = loadImage("lvl1Boss.png");
    } else {
      if (lvl ==2)
        b1 = loadImage("lvl1Boss.png");
    }
  }


  void display() {
    // To-do: replace with image
    //image(b1,x,y) ONLY ACTIVATE IF IMAGE EXISTS
    fill(255, 6, 99);
    ellipse(x, y, w, h); // remove when image exists
    fill(255);
    text(health, x, y);
  }

  void move() {
    x += speed;
  }
}
