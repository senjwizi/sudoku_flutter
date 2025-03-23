import 'package:sudoku_flutter/modules/Cell.dart';
import 'package:sudoku_flutter/modules/SudokuGenerator.dart';

class Sudoku {
  List<Cell> cells = [];
  Cell? selectedCell;
  List<Cell> highlights = [];

  bool notesMode = false;
  SudokuGenerator? _sudokuGenerator;

  Sudoku() {
    _initTable();
  }

  void _initTable() {
    _sudokuGenerator = SudokuGenerator(38);

    cells = List.generate(
        81,
        (int i) => Cell(
              value: _sudokuGenerator!.getNumber(i),
              notes: List.filled(9, false, growable: false),
              row: i ~/ 9,
              col: i % 9,
              area: _getArea(i),
              selected: false,
              subSelected: false,
              correct: true,
            ));
  }

  void changeNotesMode()
  {
    notesMode = !notesMode;
  }

  void setNumber(int number)
  {
    if (notesMode) {
      selectedCell!.notes[number - 1] = !selectedCell!.notes[number - 1];
    } else {
      selectedCell!.value = selectedCell!.value != number ? number : 0;
      _sudokuGenerator!.setNumber(selectedCell!.row, selectedCell!.col, number);
      selectedCell!.correct = _sudokuGenerator!.checkCorrect(selectedCell!.col, selectedCell!.row);
    }

    _clearSelected();
    _updateSelected();
  }

  void clearCell()
  {
    //selectedCell?.numbersInCell = List<int>.filled(10, 0, growable: false);
    selectedCell!.clear();
    _clearSelected();
    _updateSelected();
  }

  void selectCell(int index) {
    _clearSelected();
    selectedCell?.selected = false;
    selectedCell = cells[index];
    selectedCell!.selected = true;
    _updateSelected();
  }

  void _clearSelected() {
    for (var c in highlights) {
      c.clearHighlight();
    }
    highlights = [];
  }

  void _updateSelected() {
    highlights.addAll(
        cells.where((c) =>
            !c.selected && (
            c.area == selectedCell!.area ||
            c.row == selectedCell!.row ||
            c.col == selectedCell!.col || 
            c.value == selectedCell!.value ||
            c.notes.contains(true))).toList());

    for (var c in highlights) {
      //c.subSelected = true;
      c.updateHighlight(selectedCell!);
    }
  }

  int _getArea(int i) {
    return 3 * (i ~/ 27) + ((i % 9) ~/ 3 + 1);
  }
}