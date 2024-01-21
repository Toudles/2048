class Game{
   Board board;
   Tile tile;
   
   Game() {
        board = new Board(); // Use the default constructor
        tile = new Tile(board);
        tile.initialTile1();
        tile.initialTile2();
    }

     
void render() {
    textSize(44); // Make sure this size fits the tiles.
    textAlign(CENTER, CENTER); // Set alignment for all text rendering.
    for (int rows = 0; rows < board.boardX; rows++) {
        for (int columns = 0; columns < board.boardY; columns++) {
            // Calculate the position for the tile.
            float x = columns * board.tileSize + board.tileSize / 2;
            float y = rows * board.tileSize + board.tileSize / 2;
            // Check if the tile is not empty.
            if (!board.board[rows][columns].equals("")) {
                // Parse the value only if the tile is not empty.
                int tileValue = Integer.parseInt(board.board[rows][columns]);
                // Set the fill color based on the tile value.
                switch(tileValue) {
                   case 2: fill(222, 236, 159); break;
                   case 4: fill(170, 236, 159); break;
                   case 8: fill(159, 236, 210); break;
                   case 16: fill(159, 209, 236); break;
                   case 32: fill(159, 161, 236); break;
                   case 64: fill(209, 159, 236); break;
                   case 128: fill(236, 159, 219); break;
                   case 256: fill(236, 186, 159); break;
                   case 512: fill(85, 101, 244); break;
                   case 1024: fill(103, 24, 168); break;
                   case 2048: fill(0, 0, 0); break;
                   default: fill(255, 255, 255);
                }

                rect(columns * board.tileSize, rows * board.tileSize, board.tileSize, board.tileSize);
                fill(0); 
                text(tileValue, x, y);

            } else {
                fill(236, 159, 163);
                rect(columns * board.tileSize, rows * board.tileSize, board.tileSize, board.tileSize);
            }
        }
    }
}    
  
  void handleKeyPress() {
    if (keyCode == RIGHT){
    board.moveRight();
    board.mergeTilesRight();
    board.randomTile();
    System.out.println();
    board.printBoard();
   
  } else if (keyCode == LEFT){
    board.moveLeft();
    board.mergeTilesLeft();
    board.moveLeft();
    board.randomTile();
    System.out.println();
    board.printBoard();
    
  } else if (keyCode == UP){
    board.moveUp();
    board.mergeTilesUp();
    board.randomTile();
    System.out.println();
    board.printBoard();
    
  } else {
    board.moveDown();
    board.mergeTilesDown();
    board.randomTile();
    System.out.println();
    board.printBoard();
    
  }
  gameOver = board.gameOver();
  if (gameOver) {

    // Display "Game Over" in the center of the screen
    fill(255, 0, 0);  // Red color for the "Game Over" text
    textSize(40);
    textAlign(CENTER, CENTER);
    text("Game Over", width / 2, height / 2);  // Center of the screen
    text("Score: " + score, width / 2, (height / 2) - 50);

    // Draw the "Play Again" button
    fill(0, 255, 0);  // Green color for the button
    rect(width / 2 - 100, height / 2 + 50, 200, 50);  // Adjust the position and size as needed
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Play Again", width / 2, height / 2 + 75);  // Adjust the position as needed
  }

  }
  
  void resetGame() {
    board.resetBoard();
    tile = new Tile(board);
    tile.initialTile1();
    tile.initialTile2();
    score = 0;
    gameOver = false;
    playLosingSound = false;
  }
}
