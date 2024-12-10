import 'package:sudoku_flutter/modules/Cell.dart';
import 'package:sudoku_flutter/modules/SudokuGenerator.dart';

class Sudoku {
  List<Cell> cells = [];
  Cell? selectedCell;
  bool notesMode = false;
  SudokuGenerator? _sudokuGenerator;
  //Cell? getSelectedCell() => selectedCell;

  Sudoku() {
    _initTable();
  }

  void _initTable() {
    cells = List.generate(
        81,
        (int i) => Cell(
              numbersInCell: List<int>.filled(10, 0, growable: false),
              row: i ~/ 9,
              col: i % 9,
              area: _getArea(i),
              selected: false,
              subSelected: false,
              sameNumber: false,
              correct: true,
              //getSelectedCell: () => selectedCell,
            ));


    //Generate
    _sudokuGenerator = SudokuGenerator(3);
    //cells = _sudokuGenerator!.playTable;

    for (var i = 0; i < 81; i++) {
      cells[i].numbersInCell[0] = _sudokuGenerator!.getNumber(i);
    }
  }

  void changeNotesMode()
  {
    notesMode = !notesMode;
  }

  void setNumber(int number)
  {
    if (selectedCell?.numbersInCell[notesMode ? number : 0] == number) {
      selectedCell?.numbersInCell[notesMode ? number : 0] = 0;
    } else {
      selectedCell?.numbersInCell[notesMode ? number : 0] = number;
    }
    _sudokuGenerator!.checkCorrect(selectedCell!.col, selectedCell!.row);
    _clearSelected();
    _updateSelected();
  }

  void clearCell()
  {
    selectedCell?.numbersInCell = List<int>.filled(10, 0, growable: false);
    _clearSelected();
    _updateSelected();
  }

  void selectCell(int index) {
    _clearSelected();
    selectedCell = this.cells[index];
    selectedCell!.selected = true;
    _updateSelected();
  }

  void _clearSelected() {
    if (selectedCell != null) {
      selectedCell!.selected = false;
      cells
          .where((c) => c.subSelected == true || c.sameNumber == true)
          .forEach((c) {c.subSelected = false; c.sameNumber = false;});
    }
  }

  void _updateSelected() {
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