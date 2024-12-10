import 'package:flutter/material.dart';
import 'package:sudoku_flutter/modules/Cell.dart';
import 'package:sudoku_flutter/modules/Sudoku.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;

  //Settings
  final double edgeRadius = 23; // скругление всей таблицы
  final double selectedRadius = 8; // скругление выделенной ячейки 
  final double selectedMargin = 2; // отступ выделенной ячейки 

  final Color borderColor = const Color.fromARGB(255, 20, 127, 221);

  CellWidget({
    super.key,
    required this.cell,
  });

  Color cellColor() {
    if (cell.selected == true) {
      return Colors.white;//const Color.fromARGB(255, 70, 163, 245);
    } else if (cell.subSelected == true) {
      return const Color.fromARGB(255, 163, 205, 241);
    } else if (cell.sameNumber == true) {
      return const Color.fromARGB(255, 125, 157, 185);
    } else {
      return Colors.white;
    }
  }

  double getWidth(int i) {
    return i % 3 == 0 ? 2.0 : 0.4;
  }

  BorderRadius? getCorner (int col, int row) {
    if (col == 0 && row == 0) {
      return BorderRadius.only(topLeft: Radius.circular(edgeRadius));
    }
    if (col == 8 && row == 0) {
      return BorderRadius.only(topRight: Radius.circular(edgeRadius));
    }
    if (col == 0 && row == 8) {
      return BorderRadius.only(bottomLeft: Radius.circular(edgeRadius));
    }
    if (col == 8 && row == 8) {
      return BorderRadius.only(bottomRight: Radius.circular(edgeRadius));
    }
    return BorderRadius.zero;
  }

  Border? getBorder() {
    return Border(
          left: cell.col != 0 && cell.col <= 4 ? BorderSide( 
            color: borderColor,
            width: getWidth(cell.col))  : BorderSide.none,
          right: cell.col != 8 && cell.col >= 4 ? BorderSide(
            color: borderColor,
            width: getWidth(cell.col + 1))  : BorderSide.none,
          bottom: cell.row != 8 && cell.row >= 4 ? BorderSide( 
            color: borderColor,
            width: getWidth(cell.row + 1))  : BorderSide.none,
          top: cell.row != 0 && cell.row <= 4 ? BorderSide(
            color: borderColor,
            width: getWidth(cell.row))  : BorderSide.none,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cell.selected ? 
        const Color.fromARGB(255, 163, 205, 241) :
        Colors.transparent,
        border: getBorder(),
        borderRadius: getCorner(cell.col, cell.row),
      ),
      child: Center(
        child: Container(
          margin: cell.selected ? EdgeInsets.all(selectedMargin) : const EdgeInsets.all(0),
          decoration: cell.selected ? 
            BoxDecoration(
              color: cellColor(),
              borderRadius: BorderRadius.all(Radius.circular(selectedRadius)),
              border:  Border.all(
                color: borderColor,
                width: 1.5,
              ),
            ) :  
            BoxDecoration(
              color: cellColor(),
              borderRadius: getCorner(cell.col, cell.row),
            ),
          child: cell.numbersInCell[0] != 0 ? 
            Center(
              child: Text(cell.numbersInCell[0].toString()),
            ) :
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
              itemCount: 9,
              itemBuilder: (context, index) => 
                Center(
                  child: cell.numbersInCell[index + 1] != 0 ?
                  Text( 
                    cell.numbersInCell[index + 1].toString(),
                    style: TextStyle(
                      fontWeight: cell.numbersInCell[index + 1] == cell.col ? 
                      FontWeight.bold : 
                      FontWeight.normal,
                    ),
                  ) : null
                )
            ),
        ),
      ),
    );
  }
}

class TextNote extends StatelessWidget {
  const TextNote({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}