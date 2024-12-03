import 'package:sudoku_flutter/modules/Cell.dart';
import 'package:sudoku_flutter/modules/SudokuGenerator.dart';

class Sudoku {
  List cells = [];
  Cell? selectedCell;
  SudokuGenerator sudokuGenerator = SudokuGenerator(3);

  Sudoku() {
    _initTable();
  }

  void _initTable() {
    cells = List.generate(
        81,
        (int i) => new Cell(
              numbersInCell: List<int>.filled(10, 0, growable: false),
              row: i ~/ 9,
              col: i % 9,
              area: _getArea(i),
              selected: false,
              subSelected: false,
              sameNumber: false,
            ));

    //Generate

    for (int i = 0; i < 81; i++) {
      cells[i].numbersInCell[0] = sudokuGenerator.getNumber(i);
    }
  }

  void selectCell(int index) {
    if (selectedCell != null) {
      selectedCell!.selected = false;
      cells
          .where((c) => c.subSelected == true || c.sameNumber == true)
          .forEach((c) {c.subSelected = false; c.sameNumber = false;});
    }
    selectedCell = cells[index];
    selectedCell!.selected = true;
    cells
        .where((c) =>
            c.area == selectedCell!.area ||
            c.row == selectedCell!.row ||
            c.col == selectedCell!.col)
        .forEach((c) => c.subSelected = true);
      cells
        .where((c) =>
            c.numbersInCell[0] == selectedCell!.numbersInCell[0])
        .forEach((c) => c.sameNumber = true);
  }

  void showTable() {
    for (int y = 0; y < 9; y++) {
      String line = '';
      for (int x = 0; x < 9; x++) {
        Cell t = cells[y * 9 + x];
        line += t.numbersInCell[0].toString();
        //line += '\t';
      }
      print(line);
    }
  }

  int _getArea(int i) {
    return 3 * (i ~/ 27) + ((i % 9) ~/ 3 + 1);
  }
}