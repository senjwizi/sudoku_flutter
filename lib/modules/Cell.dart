import 'package:flutter/material.dart';

class Cell {
  int value;
  List<bool> notes;
  int selectedNumber = 0;
  int row;
  int col;
  int area;
  bool selected;
  bool subSelected;
  bool correct;


  Cell({
    required this.value,
    required this.notes,
    required this.row,
    required this.col,
    required this.area,
    required this.selected,
    required this.subSelected,
    required this.correct,
  });

  void updateHighlight(Cell selectedCell){
    subSelected = 
      row == selectedCell.row || 
      col == selectedCell.col || 
      area == selectedCell.area;
    selectedNumber = selectedCell.value;
  }

  void clearHighlight() {
    selected = false;
    subSelected = false;
    selectedNumber = 0;
  }

  void clear() {
    value = 0;
    notes = List.filled(9, false, growable: false);
  }
}