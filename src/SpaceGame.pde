// Thomas Li || Sep 17 2026 || SpaceGame
import processing.sound.*;
SoundFile laser1, pointA;
Ship c37;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();
Timer rockDist, pDist;
Boss bossh1;
LevelManager levelMgr;
float score;
int rockCount, rocksOffScreen, laserSpeed;
boolean play;

void setup () {
  size (500, 500);
  bossh1 = new Boss(-200, 200, 1);
  c37 = new Ship();
  levelMgr = new LevelManager();
  rockDist = new Timer(int(random(1500, 4500)));
  rockDist.start();
  pDist = new Timer(int(random(5000, 15000)));
  pDist.start();
  score = 0;
  laserSpeed = 5;
  rockCount = 0;
  rocksOffScreen = 0;
  play = false;
 // laser1 = new SoundFile(this, "laserSound.mp3");
 // pointA = new SoundFile(this, "pointsAwarded.mp3");
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

  int previousLevel = levelMgr.level;
  levelMgr.update(score);
  if (levelMgr.level > previousLevel) {
  //  pointA.play();
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

  if (levelMgr.bossActive()) {
    bossh1.display();
    bossh1.move();
    if (bossh1.x > width + 200) {
      bossh1.x = -200; 
    }
  }

  // Movement
  c37.move(mouseX, mouseY);
  c37.display();

  // Displays and moves powerups and compares ship
  for (int i = powerups.size() - 1; i >= 0; i--) {
    PowerUp p = powerups.get(i);
    p.move();
    p.display();
    if (p.isHit(c37)) {
      if (p.type == 'h') {
        c37.health += 5;
      } else if (p.type == 's') {
        laserSpeed = laserSpeed + 1;
      } else if (p.type == 't') {
        c37.turretCount = c37.turretCount + 1;
      }
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
    } else if (r.isOffScreen() == true) {
      rocks.remove(i);
      rocksOffScreen++;
      c37.health = c37.health - 3;
      // intentional, I also need a penalty for missing. 
    }
  }

  // Display and move lasers and detect collisions (Boss & Rocks)
  for (int i = lasers.size() - 1; i >= 0; i--) {
    Laser l = lasers.get(i);
    l.move();
    l.display();
    boolean laserDestroyed = false;

    // Check collision with Boss (if boss is active)
    if (levelMgr.bossActive() && dist(l.x, l.y, bossh1.x, bossh1.y) < bossh1.w / 2) {
      lasers.remove(i);
      laserDestroyed = true;
      bossh1.health -= (int(random(1, 40))); // Pure randomness
      if (bossh1.health < 1) {
        score += 50; 
        pointA.play();
        bossh1.x = -400; 
        bossh1.health = 5000; 
      }
      continue;
    }

    // Check collision with Rocks
    for (int j = rocks.size() - 1; j >= 0; j--) {
      Rock r = rocks.get(j);
      if (l.isHit(r)) {
        lasers.remove(i);
        laserDestroyed = true;
        r.health -= (random(1, 25));
        if (r.health < 1) {
          rocks.remove(j);
          score += 10;
        //  pointA.play();
        }
        break;
      }
    }
    
    // Check if laser went off screen
    if (!laserDestroyed && l.isOffScreen() == true) {
      lasers.remove(i);
    }
  }

  if (levelMgr.showLevelUpMessage) {
    fill(255, 255, 0);
    textSize(28);
    textAlign(CENTER, CENTER);
    text("LEVEL UP! - LVL " + levelMgr.level, width/2, height/3);
  }

  infoPanel();

  // Check Win/Loss Conditions
  if (c37.health < 1 || rocksOffScreen > 9) {
    gameOver();
  } else if (levelMgr.hasWon) {
    winGame();
  }
}

void mousePressed() {
  if (!play) {
    play = true;
  } else if (c37.health >= 1 && rocksOffScreen <= 9 && !levelMgr.hasWon) {
    lasers.add(new Laser(c37.x, c37.y));
    laser1.play();
    if (c37.turretCount >= 2) {
      lasers.add(new Laser(c37.x - 12, c37.y));
    }
    if (c37.turretCount >= 3) {
      lasers.add(new Laser(c37.x + 12, c37.y));
    }
  }
}

void keyPressed() {
  if (!play) {
    play = true;
  } else if (c37.health < 1 || rocksOffScreen > 9 || levelMgr.hasWon) {
    if (key == 'r' || key == 'R') {
      resetGame();
    }
  }
}

void infoPanel() {
  fill(127, 127);
  rectMode(CENTER);
  rect(width/2, 20, width/1.01, 40);
  fill(255);
  textSize(12); // Locks font size so it doesn't get messed up by power-ups
  textAlign(LEFT, CENTER);
  text("Score: " + int(score), 20, 20);
  text("Level: " + levelMgr.level, 110, 20);
  text("Health: " + c37.health, 180, 20);
  text("Rocks Passed: " + rocksOffScreen, 280, 20);
}

void startScreen() {
  background(0);
  fill(255);
  textSize(14);
  textAlign(CENTER, CENTER);
  text("Press any key or mouse to start!", width/2, height/2);
}

void gameOver() {
  background(0);
  fill(200, 0, 0);
  textSize(22);
  textAlign(CENTER, CENTER);
  text("You LOST. Try again .\nFinal Score: " + int(score) + "\n\nPress 'R' to Try again.", width/2, height/2);
  noLoop();
}

void winGame() {
  background(0);
  fill(0, 255, 0);
  textSize(22);
  textAlign(CENTER, CENTER);
  text("You WIN! Thanks for playing! \nYour Score: " + int(score) + "\n\nPress 'R' to Replay", width/2, height/2);
  noLoop();
}

void resetGame() {
  score = 0;
  rockCount = 0;
  rocksOffScreen = 0;
  laserSpeed = 5;
  c37 = new Ship();
  levelMgr = new LevelManager();
  bossh1 = new Boss(-200, 200, 1);
  rocks.clear();
  lasers.clear();
  powerups.clear();
  rockDist.start();
  pDist.start();
  loop();
}
