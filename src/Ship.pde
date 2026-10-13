class Ship {
  int x, y, health, turretCount;
  PImage ship01;

  Ship() {
    x = width/2;
    y = height/2;
    health = 100;
    turretCount = 1;
    ship01 = loadImage("SpaceShip.png");
  }

  void display() {
    imageMode(CENTER);
    image(ship01, x, y);
  }

  void move(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }
}
