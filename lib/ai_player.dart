class AIPlayer {
  int findBestMove(List<String> board) {
    int bestMove = -1;
    int bestScore =
        -1000; // Initialize with a low score for maximizing player (AI)

    // Loop through all empty cells on the board
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        // Make a move and calculate the score for the current move
        board[i] = 'X'; // Assuming AI plays as 'O'
        int score = minimax(board, 0, false);
        board[i] = ''; // Undo the move

        // Update the best move if the current move has a higher score
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    return bestMove;
  }

  int minimax(List<String> board, int depth, bool isMaximizingPlayer) {
    List<String> winningCombination = findWinningCombination(board);

    if (winningCombination.isNotEmpty) {
      // Evaluate the score based on the winner
      if (winningCombination[0] == 'X') {
        return 1; // AI wins
      } else {
        return -1; // Human wins
      }
    } else if (isBoardFull(board)) {
      return 0; // It's a draw
    }

    if (isMaximizingPlayer) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'X'; // Assuming AI plays as 'O'
          int score = minimax(board, depth + 1, false);
          board[i] = ''; // Undo the move
          if (score > bestScore) {
            bestScore = score;
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'O'; // Assuming human plays as 'X'
          int score = minimax(board, depth + 1, true);
          board[i] = ''; // Undo the move
          if (score < bestScore) {
            bestScore = score;
          }
        }
      }
      return bestScore;
    }
  }

  List<String> findWinningCombination(List<String> board) {
    // Define winning combinations for Tic Tac Toe
    List<List<int>> winCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winCombinations) {
      if (board[combination[0]] == board[combination[1]] &&
          board[combination[1]] == board[combination[2]] &&
          board[combination[0]] != '') {
        return [
          board[combination[0]],
          combination[0].toString(),
          combination[1].toString(),
          combination[2].toString()
        ];
      }
    }

    return [];
  }

  bool isBoardFull(List<String> board) {
    return !board.contains('');
  }
}
