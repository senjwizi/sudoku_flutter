import 'dart:math';

class SudokuGenerator {
  List table = List<List>.generate(
      9,
      (j) => List<int>.generate(9, (i) => ((i * 3 + i ~/ 3 + j) % 9 + 1),
          growable: false),
      growable: false);

  SudokuGenerator(int dif) {
    generate(dif);
  }

  int getNumber(int index) {
    return table[index % 9][index ~/ 9];
  }

  void generate(int dif) {
    int _dif = dif;
    _swapRowInArea();
  }

  void _transpos() {}

  void _swapRowInArea() {
    int area = Random().nextInt(3);
    int firstLineInArea = Random().nextInt(3);
    int firstLineInTable = area * 3 + firstLineInArea;

    int secondLineInArea = Random().nextInt(3);

    while (firstLineInArea == secondLineInArea) {
      secondLineInArea = Random().nextInt(3);
    }

    int secondLineInTable = area * 3 + secondLineInArea;

    List<int> temp = table[firstLineInTable];
    table[firstLineInTable] = table[secondLineInTable];
    table[secondLineInTable] = temp;
  }
}