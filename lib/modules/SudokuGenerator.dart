import 'dart:math';

import 'package:sudoku_flutter/modules/SudokuSolver.dart';

class SudokuGenerator {
  final List _table = List<List>.generate(
      9,
      (j) => List<int>.generate(9, (i) => ((j * 3 + j ~/ 3 + i) % 9 + 1),
          growable: false),
      growable: false);

  List<int> playTable = List<int>.filled(81, 0, growable: false);
  int _dificult = 0;

  SudokuGenerator(int dif) {
    generate(dif);
  }

  int getNumber(int index) {
    return playTable[index];
  }

  bool checkCorrect(int x, int y)
  {
    return (playTable[y * 9 + x] == _table[y][x]);
  }

  void setNumber(int row, int col, int value) {
    playTable[row * 9 + col] = value;
  }

  void generate(int dif) {
    const int randomCount = 10;
    _dificult = dif;

    List<void Function()> functions = [
      _swapLineInArea,
      _transpos,
      _swapRowInArea,
      _swapLineArea,
      _swapRowArea,
    ];

    Random random = Random();

    for (var i = 0; i < 0; i++) {
      functions[random.nextInt(functions.length)]();
    }

    fillPlayTable();
    createPlayTable();
  }

  void fillPlayTable() {
    for (var row = 0; row < 9; row++) {
      for (var col = 0; col < 9; col++) {
        playTable[row * 9 + col] = _table[row][col];
      }
    }
  }

  void createPlayTable() {

    List<bool> lookPos = List<bool>.filled(81, false,growable: false);
    int iterator = 0;
    int difficult = 81;
    Random random = Random();
    SudokuSolver sudokuSolver = SudokuSolver();


    while (difficult > _dificult) {
      int index = random.nextInt(81);

      if (!lookPos[index]) {
        iterator++;
        lookPos[index] = true;

        var temp = playTable[index];
        playTable[index] = 0;
        difficult--;


        if (sudokuSolver.solve(playTable) == false){
          playTable[index] = temp;
          difficult++;
        }
      }
    }
  }

  void _transpos() {
    for (var row = 0; row < 9; row++) {
      for (var col = 0; col < row; col++) {
        var temp = _table[row][col];
        _table[row][col] = _table[col][row];
        _table[col][row] = temp;
      }
    }
  }

  void _swapLineInArea() {
    int area = Random().nextInt(3);
    int firstLineInArea = Random().nextInt(3);
    int firstLineInTable = area * 3 + firstLineInArea;

    int secondLineInArea = Random().nextInt(3);

    while (firstLineInArea == secondLineInArea) {
      secondLineInArea = Random().nextInt(3);
    }

    int secondLineInTable = area * 3 + secondLineInArea;

    List<int> temp = _table[firstLineInTable];
    _table[firstLineInTable] = _table[secondLineInTable];
    _table[secondLineInTable] = temp;
  }

  void _swapLineArea() {
    int firstArea = Random().nextInt(3);
    int secondArea = Random().nextInt(3);

    while (firstArea == secondArea) {
       secondArea = Random().nextInt(3);
    }

    for (var i = 0; i < 3; i++) {
      List<int> temp = _table[firstArea * 3 + i];
      _table[firstArea * 3 + i] = _table[secondArea * 3 + i];
      _table[secondArea * 3 + i] = temp;
    }
  }

  void _swapRowInArea() {
    _transpos();
    _swapLineInArea();
    _transpos();
  }

  void _swapRowArea() {
    _transpos();
    _swapLineArea();
    _transpos();
  }

}