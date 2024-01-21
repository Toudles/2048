class Board {
// attributes
  //our base and height for our array (4 x 4)
  public int boardX;
  public int boardY;
  //used to randomly select the [x][y] coord for our array
  //to place the initial 2 tiles of the game
  public int randomX1;
  public int randomY1;
  public int randomX2;
  public int randomY2;
  //this is used to set the value of our initial 2 tiles to either
  //2 or 4
  public int initialNum1;
  public int initialNum2;
  //creating our array (using char because we need to accomodate for any empty space)
  // --> ' ')
  public String[][] board;
  //used to calculate the size of our tiles (since our display itself is 500 x 500)
  //we need to accomodate for splitting our 500 x 500 board into 16 mini squares
  public int tileSize;
  
  Board() {
    //setting our base and height of our array to a 4x4 array
    boardX = 4;
    boardY = 4;
    //sets the numbers for the first 2 tiles (either 2 or 4)
    initialNum1 = (int) (Math.random() * 2 + 1);
    initialNum2 = (int) (Math.random() * 2 + 1);
    //randomly places tile1
    randomX1 = (int) (Math.random()*3) + 1;
    randomY1 = (int) (Math.random()*3) + 1;
    //We don't want our random1 and random2 to somehow result with the same value
    //so use a "do-while" loop so that if random2 ends up with the same value as random1
    //select another value
    do {
      randomX2 = (int) (Math.random()*3) + 1;
      randomY2 = (int) (Math.random()*3) + 1;
    } while (randomX2 == randomX1 && randomY2 == randomY1);
    //adjust size of the tile to fit the screen (500 x 500 = 250,000 / (16) = 15,625 --> sqrt(15,625) = 125 so each tile is 125 x 125)
    tileSize = 500 / 4;
    //instantiates a board
    this.board = new String[boardX][boardY];
    createBoard();

  }
  
  // methods
  //necessary in final product because it determines the positioning
  void createBoard() {//creates our empty array of a 4x4 array
    for (int rows = 0; rows < board.length; rows++) {
      for (int columns = 0; columns < board[rows].length; columns++) {
        board[rows][columns] = "";
      }
    }
  }
  //for our own convenience (not necessary in final product)
  void printBoard() {//prints out our board
    for (int rows = 0; rows < board.length; rows++) {
      for (int columns = 0; columns < board[rows].length; columns++) {
        System.out.print(board[rows][columns] + " ");
      }
      System.out.println();
    }
  }
  
  void moveRight(){
    for (int row = 0; row < boardY; row++) {
            int emptyColumn = boardX - 1;
            // Iterate from right to left within the row
            for (int col = boardX - 1; col >= 0; col--) {
                if (board[row][col] != "") {
                    // Move the tile to the rightmost non-empty position
                    board[row][emptyColumn] = board[row][col];
                    // If the tile moved, clear its previous position
                    if (col != emptyColumn) {
                        board[row][col] = "";
                    }
                    emptyColumn--;
                }
            }
        }
    }
    void moveLeft() {
        for (int row = 0; row < boardY; row++) {
            int emptyColumn = 0; // Start from the leftmost column
            for (int col = 0; col < boardX; col++) {
                if (board[row][col] != "") {
                    // If the current tile is not empty, move it to the leftmost empty column
                    board[row][emptyColumn] = board[row][col];
                    // If the current column is not the same as the empty column, clear the current column
                    if (col != emptyColumn) {
                        board[row][col] = "";
                    }
                    emptyColumn++; // Move the empty column to the right
                }
            }
        }
    }
    void moveDown() {
        for (int col = 0; col < boardX; col++) {
            int emptyRow = boardY - 1; // Start from the bottom row
            for (int row = boardY - 1; row >= 0; row--) {
                if (board[row][col] != "") {
                    // If the current tile is not empty, move it to the bottommost empty row
                    board[emptyRow][col] = board[row][col];
                    // If the current row is not the same as the empty row, clear the current row
                    if (row != emptyRow) {
                        board[row][col] = "";
                    }
                    emptyRow--; // Move the empty row up
                }
            }
        }
    }
    void moveUp() {
        for (int col = 0; col < boardX; col++) {
            int emptyRow = 0; // Start from the top row
            for (int row = 0; row < boardY; row++) {
                if (board[row][col] != "") {
                    // If the current tile is not empty, move it to the topmost empty row
                    board[emptyRow][col] = board[row][col];
                    // If the current row is not the same as the empty row, clear the current row
                    if (row != emptyRow) {
                        board[row][col] = "";
                    }
                    emptyRow++; // Move the empty row down
                }
            }
        }
    }
  
    void randomTile() {     
    boolean isFull = true;
    for (int i = 0; i < boardX; i++) {
        for (int j = 0; j < boardY; j++) {
            if (board[i][j].equals("")) {
                isFull = false; // Found an empty spot, so the board is not full
                break; // No need to check further
            }
        }
        if (!isFull) break; // Break the outer loop as well if an empty spot is found
    }
    
    if (isFull) {
        return;
    }

    // Generate random positions until an empty one is found
    int randomX, randomY;
    do {
       randomX = (int) (Math.random() * boardX);
       randomY = (int) (Math.random() * boardY);
    } while (!board[randomY][randomX].equals(""));
    
    if (Math.random() < 0.5) {
      board[randomY][randomX] = "2";
    } else {
      board[randomY][randomX] = "4";
      }
  }

  void mergeTilesRight() {
        for (int row = 0; row < boardY; row++) {
            for (int col = boardX - 1; col > 0; col--) {
                if (!board[row][col].isEmpty() && board[row][col].equals(board[row][col - 1])) {
                    int mergedValue = Integer.parseInt(board[row][col]) * 2;
                    board[row][col] = String.valueOf(mergedValue);
                    score += mergedValue;
                    board[row][col - 1] = "";
                    for (int k = col - 1; k > 0; k--) {
                     board[row][k] = board[row][k - 1];
                     }
                     board[row][0] = "";
                }
            }
        }
    }

void mergeTilesLeft() {
    for (int row = 0; row < boardY; row++) {
        for (int col = 0; col < boardX - 1; col++) {
            if (!board[row][col].isEmpty() && board[row][col].equals(board[row][col + 1])) {
                int mergedValue = Integer.parseInt(board[row][col]) * 2;
                board[row][col] = String.valueOf(mergedValue);
                score += mergedValue;
                board[row][col + 1] = "";
                for (int k = col + 1; k < boardX - 1; k++) {
                    board[row][k] = board[row][k + 1];
                }
                board[row][boardX - 1] = ""; // Clear the rightmost tile after shifting
            }
        }
    }
}

void mergeTilesDown() {
    for (int col = 0; col < boardX; col++) {
        for (int row = boardY - 1; row > 0; row--) {
            if (!board[row][col].isEmpty() && board[row][col].equals(board[row - 1][col])) {
                int mergedValue = Integer.parseInt(board[row][col]) * 2;
                board[row][col] = String.valueOf(mergedValue);
                score += mergedValue;
                board[row - 1][col] = "";
                for (int k = row - 1; k > 0; k--) {
                    board[k][col] = board[k - 1][col];
                    }
                    board[0][col] = "";
            }
        }
    }
}

void mergeTilesUp() {
    for (int col = 0; col < boardX; col++) {
        for (int row = 1; row < boardY; row++) {
            if (!board[row][col].isEmpty() && board[row][col].equals(board[row - 1][col])) {
            int mergedValue = Integer.parseInt(board[row][col]) * 2;
            board[row - 1][col] = String.valueOf(mergedValue);
            score += mergedValue;
            board[row][col] = "";
            for (int k = row; k < boardY - 1; k++) {
                board[k][col] = board[k + 1][col];
                }
            board[boardY - 1][col] = ""; 
          }
       }
    }
  }
  
boolean gameOver() {
    // Check for any empty spaces first
    for (int i = 0; i < boardX; i++) {
        for (int j = 0; j < boardY; j++) {
            if (board[i][j].equals("")) {
                return false; // An empty space is found, the game is not over
            }
        }
    }

    // Check for possible merges horizontally
    for (int i = 0; i < boardX; i++) {
        for (int j = 0; j < boardY - 1; j++) {
            if (board[i][j].equals(board[i][j + 1])) {
                return false; // A merge is possible horizontally
            }
        }
    }

    // Check for possible merges vertically
    for (int j = 0; j < boardY; j++) {
        for (int i = 0; i < boardX - 1; i++) {
            if (board[i][j].equals(board[i + 1][j])) {
                return false; // A merge is possible vertically
            }
        }
    }

    // No empty spaces and no possible merges, game is over
    return true;
}

void resetBoard() {
    createBoard();
}


}
