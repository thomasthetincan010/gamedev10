class LevelManager {
  int level;
  int nextLevelScore;
  boolean showLevelUpMessage;
  int messageTimer;
  boolean hasWon;

  LevelManager() {
    level = 1;
    nextLevelScore = 100; // you need 100 points
    showLevelUpMessage = false;
    messageTimer = 0;
    hasWon = false;
  }

  void update(float currentScore) {
    if (level == 3 && currentScore >= nextLevelScore) {
      hasWon = true;
      return;
    }

    if (currentScore >= nextLevelScore && level < 3) {
      level++;
      nextLevelScore += 351; //
      showLevelUpMessage = true;
      messageTimer = 500;
    }

    if (showLevelUpMessage) {
      messageTimer--;
      if (messageTimer <= 0) {
        showLevelUpMessage = false;
      }
    }
  }

  int getRockSpeedBonus() {
    return level - 1;
  }

  boolean bossActive() {
    return level >= 2;
  }
}
