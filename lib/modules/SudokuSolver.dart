class SudokuSolver {
  List<int> _table = List<int>.filled(81, 0, growable: false);

  SudokuSolver() {
  }

  bool solve(List<int> baseTable) {
    for (var i = 0; i < 81; i++) {
      _table[i] = baseTable[i];
    }

    try {
      place(0);
      return false;
    } catch (e) {
      return true;
    }
  }

  void place(int position) {
    if (position == 81) {
      throw new Exception("Finish!");
    } else if (_table[position] > 0) {
      place(position + 1);
    }

    for (var i = 1; i <= 9; i++) {
      if (checkValidity(i, position % 9, position ~/ 9)) {
        _table[position] = i;
        place(position + 1);
        _table[position] = 0;
      }
    }
  }

  bool checkValidity(int value, int col, int row) {
    for (var i = 0; i < 9; i++) {
      if (_table[row * 9 + i] == value || _table[i * 9 + col] == value) {
        return false;
      }
    }

    int startX = (col ~/ 3) * 3;
    int startY = (row ~/ 3) * 3;

    for (var y = startY; y < startY + 3; y++) {
      for (var x = startX; x < startX + 3; x++) {
        if (_table[y * 9 + x] == value) {
          return false;
        }
      }
    }

    return true;
  }
}