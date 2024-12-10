import 'package:flutter/material.dart';

class Cell {
  List<int> numbersInCell;
  int row;
  int col;
  int area;
  bool selected;
  bool subSelected;
  bool sameNumber;
  bool correct;
  //Cell? selectedCell;
  //final Cell? Function() getSelectedCell;

  Cell({
    required this.numbersInCell,
    required this.row,
    required this.col,
    required this.area,
    required this.selected,
    required this.subSelected,
    required this.sameNumber,
    required this.correct,
    //required this.selectedCell,
    //required this.getSelectedCell,
  });

  void updateHighlight(Cell selectedCell){
    if (numbersInCell.contains(selectedCell.numbersInCell[0])) {
      sameNumber = true;
    } else {
      subSelected = true;
    }
  }

  void clear() {
    selected = false;
    subSelected = false;
  }
}