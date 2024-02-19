import 'dart:math';

class AIPlayer {
  int findBestMove(List<String> board) {
    int bestMove = -1;
    int bestScore = 1000; // Initialize with a high score for minimizing player (AI)

    // Loop through all empty cells on the board
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        // Make a move and calculate the score for the current move
        board[i] = 'O'; // AI plays as 'O'
        int score = minimax(board, 0, false, -1000, 1000);
        board[i] = ''; // Undo the move

        // Update the best move if the current move has a lower score
        if (score < bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    return bestMove;
  }

  int minimax(List<String> board, int depth, bool isMaximizingPlayer, int alpha, int beta) {
    List<String> winningCombination = findWinningCombination(board);

    if (winningCombination.isNotEmpty) {
      if (winningCombination[0] == 'O') {
        return -10 + depth; // AI wins (the sooner, the better)
      } else {
        return 10 - depth; // Human wins (the later, the better)
      }
    } else if (isBoardFull(board)) {
      return 0; // It's a draw
    }

    if (isMaximizingPlayer) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'X'; // Human plays as 'X'
          int score = minimax(board, depth + 1, false, alpha, beta);
          board[i] = ''; // Undo the move
          bestScore = max(bestScore, score);
          alpha = max(alpha, score);
          if (beta <= alpha) {
            break; // Beta cut-off
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'O'; // AI plays as 'O'
          int score = minimax(board, depth + 1, true, alpha, beta);
          board[i] = ''; // Undo the move
          bestScore = min(bestScore, score);
          beta = min(beta, score);
          if (beta <= alpha) {
            break; // Alpha cut-off
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
