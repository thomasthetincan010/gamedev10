// Thomas Li | 2026 September 17 | SpaceGame
import processing.sound.*;
SoundFile laser1, pointA;
Ship c37;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();
Timer rockDist, pDist;
Boss bossh1;
float score;
int  rockCount, rocksOffScreen, laserSpeed, level1;
boolean play;

void setup () {
  size (500, 500);
  bossh1 = new Boss(-200, 200, 1);
  c37 = new Ship();
  rockDist = new Timer(int(random(1500, 4500)));
  rockDist.start();
  pDist = new Timer(int(random(5000, 15000)));
  pDist.start();
  score = 0;
  laserSpeed=5;
  rockCount = 0;
  rocksOffScreen = 0;
  play = false;
  laser1 = new SoundFile(this, "laserSound.mp3");
  pointA = new SoundFile(this, "pointsAwarded.mp3");
}

void draw () {
  noCursor();
  // Check for startscreen
  if (play == false) {
    startScreen();
    return;
  } else {
    background (20);
  }

  // Add Rocks
  if (rockDist.isFinished() == true) {
    rockDist.start();
    rocks.add(new Rock(int(random(width)), -60));
    rockCount++;
  }

  // Add Power Ups
  if (pDist.isFinished() == true) {
    pDist.start();
    powerups.add(new PowerUp(int(random(width)), -60));
  }
  bossh1.display();
  bossh1.move();
  // Movement
  c37.move(mouseX, mouseY);
  c37.display();

  // Displays and moves powerups and compares ship
  for (int i = powerups.size() - 1; i >= 0; i--) {
    PowerUp p = powerups.get(i);
    p.move();
    p.display();
    if (p.isHit(c37)) {
      c37.health += 5;
      powerups.remove(i);
    } else if (p.type == 's') {
      laserSpeed = laserSpeed +1;
      powerups.remove(i);
    } else if (p.type == 's') {
      c37.turretCount = c37.turretCount +1;
      powerups.remove(i);
    } else if (p.isOffScreen() == true) {
      powerups.remove(i);
    }
  }

  // Display and move rocks AND detect ship collision
  for (int i = rocks.size() - 1; i >= 0; i--) {
    Rock r = rocks.get(i);
    r.display();
    r.move();
    if (r.isHit(c37)) {
      rocks.remove(i);
      c37.health = c37.health - 5;
      score = score + 0.2;
      // This is intentional, you get 0.2 points for at least hitting it with your ship.
    } else if (r.isOffScreen() == true) {
      rocks.remove(i);
      rocksOffScreen++;
      c37.health = c37.health - 3;
      // This is also intentional, I need a bigger penalty for not hitting it
    }
  }

  // Display and move lasers and detect rock collision
  for (int i = lasers.size() - 1; i >= 0; i--) {
    Laser l = lasers.get(i);
    l.move();
    l.display();
    boolean laserDestroyed = false;

    for (int j = rocks.size() - 1; j >= 0; j--) {
      Rock r = rocks.get(j);
      if (l.isHit(r)) {
        lasers.remove(i);
        laserDestroyed = true;
        r.health -= (int(random(1, 40)));
        if (r.health < 1) {
          rocks.remove(j);
          score += 10;
          pointA.play();
        }
        break;
      }
    }
    // Check if laser went off screen
    if (!laserDestroyed && l.isOffScreen() == true) {
      lasers.remove(i);
    }
  }

  infoPanel();
  if (c37.health < 1 || rocksOffScreen > 9) {
    gameOver();
  }
}

void mousePressed() {
  if (play) {
    lasers.add(new Laser(c37.x, c37.y));
    laser1.play();
    if (c37.turretCount == 1) {
      lasers.add(new Laser(c37.x-10, c37.y));
   //   lasers.add(new Laser(c37.x+10, c37.y));
    }
  }
}



void infoPanel() {
  fill(127, 127);
  rectMode(CENTER);
  rect(width/2, 20, width/1.01, 40);
  fill(255);
  textAlign(LEFT, CENTER);
  text("Score: " + score, 20, 20);
  text("Rock Count: " + rockCount, 120, 20);
  text("Health: " + c37.health, 240, 20);
  text("Rocks Passed: " + rocksOffScreen, 360, 20);
}

void startScreen() {
  background(0);
  fill(255);
  text("Press any key or mouse to start!", width/2, height/2);
  if (keyPressed) {
    play = true;
  }
  if (mousePressed) {
    play = true;
  }
}



void gameOver() {
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Game Over! Well Played.", width/2, height/2);
  noLoop();
}
