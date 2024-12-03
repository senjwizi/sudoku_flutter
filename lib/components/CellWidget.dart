import 'package:flutter/material.dart';
import 'package:sudoku_flutter/modules/Cell.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;

  CellWidget({
    super.key,
    required this.cell,
  });

  Color cellColor() {
    if (cell.selected) {
      return const Color.fromARGB(255, 70, 163, 245);
    } else if (cell.subSelected) {
      return const Color.fromARGB(255, 163, 205, 241);
    } else if (cell.sameNumber) {
      return const Color.fromARGB(255, 125, 157, 185);
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cellColor(),
        border: Border.all(color: Colors.black45)
      ),
      child: Center(
          child: Text(cell.numbersInCell[0].toString()),
        ),
    );
  }
}