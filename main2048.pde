import processing.sound.*;

Game game;
Tile tile;
Board board; 
SoundFile tileSound;
SoundFile errorSound;
SoundFile loseSound;

int highScore = 0;
int score = 0;
boolean gameOver = false;
boolean playLosingSound = false;

void setup() {
    size(500, 500);
    game = new Game();
    tileSound = new SoundFile(this, "tileSound.mp3");
    errorSound = new SoundFile(this, "errorSound.mp3");
    loseSound = new SoundFile(this, "womp.mp3");
    score = 0;
}

void draw() {
    background(255);
    game.render();
    // Display score and high score
    displayScores();

    // Check if the game is over
    if (gameOver) {
      System.out.println("Game is over");
      displayGameOver();

    if(!playLosingSound)
    {
      loseSound.play();
      playLosingSound = true;
    }
    }
}

void displayScores() {
    fill(255);
    textSize(20);

    // Display current score at the bottom right
    textAlign(RIGHT, BOTTOM);
    text("Score: " + score, width - 10, height - 10);

    // Update and display high score at the bottom left
    if (score > highScore) {
        highScore = score;
    }
    textAlign(LEFT, BOTTOM);
    text("High Score: " + highScore, 10, height - 10);
}

void displayGameOver() {
    fill(255, 0, 0); // Red color for the "Game Over" text
    textSize(40);
    textAlign(CENTER, CENTER);
    text("Game Over", width / 2, height / 2 - 30); // Position the text in the center

    // Display the final score below the game over message
    textSize(20);
    text("Score: " + score, width / 2, height / 2 + 20);

    // Draw the "Play Again" button
    fill(0, 255, 0); // Green color for the button
    rect(width / 2 - 100, height / 2 + 50, 200, 50); // Position and size of the button
    fill(255); // White color for the button text
    text("Play Again", width / 2, height / 2 + 75); // Position the text in the center of the button
}

void keyPressed() {
    game.handleKeyPress();   
    
    if (!gameOver)
    {
     tileSound.play();
    }
    else
    {
      errorSound.play();
    }
        
        
}

void mousePressed() {
  // Check if the game is over and if the mouse click is within the bounds of the "Play Again" button
  if (gameOver && mouseX >= width / 2 - 100 && mouseX <= width / 2 + 100 && mouseY >= height / 2 + 50 && mouseY <= height / 2 + 100) {
    // Reset the game state, score, and any other necessary variables
    game.resetGame();    
    gameOver = false;
  }
}


  
