class Tile {
  
  private Board board;
  
  
  Tile(Board board) {
    this.board = board; 
  }
  
    void initialTile1() {
        board.randomX1 = (int) (Math.random() * board.boardX);
        board.randomY1 = (int) (Math.random() * board.boardY);
        if (Math.random() < 0.5) {
            board.initialNum1 = 2;
        } else {
            board.initialNum1 = 4;
        }
        board.board[board.randomY1][board.randomX1] = String.valueOf(board.initialNum1);
        board.printBoard();
  }
    
    void initialTile2() {
        do {
            board.randomX2 = (int) (Math.random() * board.boardX);
            board.randomY2 = (int) (Math.random() * board.boardY);
        } while (board.randomX2 == board.randomX1 && board.randomY2 == board.randomY1); // Ensure it's a different spot
        
        if (Math.random() < 0.5) {
            board.initialNum2 = 2;
        } else {
            board.initialNum2 = 4;
        }
        board.board[board.randomY2][board.randomX2] = String.valueOf(board.initialNum2);
        board.printBoard();
  }
}
