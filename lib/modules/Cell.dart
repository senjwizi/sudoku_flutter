class Cell {
  List numbersInCell;
  int row;
  int col;
  int area;
  bool selected;
  bool subSelected;
  bool sameNumber;

  Cell({
    required this.numbersInCell,
    required this.row,
    required this.col,
    required this.area,
    required this.selected,
    required this.subSelected,
    required this.sameNumber,
  });

  void setNumber(int number) {
    if (numbersInCell[number] != 0) {
      numbersInCell[number] = 0;
    } else {
      numbersInCell[number] = number;
    }
  }
}