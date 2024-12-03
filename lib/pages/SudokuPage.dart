import 'package:flutter/material.dart';
import 'package:sudoku_flutter/components/CellWidget.dart';
import 'package:sudoku_flutter/modules/Sudoku.dart';

class SudokuPage extends StatefulWidget {
  const SudokuPage({super.key});

  @override
  State<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  Sudoku sudoku = Sudoku();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //GAME INFO 


          //SUDOKU TABLE
          Expanded(
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9),
                  itemCount: 81,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => SelectCell(index),
                    child: CellWidget(cell: sudoku.cells[index],),
                  ),
                ),
          ),

          //GAME CONTROLL
          Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 20,
                  )
                ),
                onPressed: onPressed, 
                child: const Text("1")),
                IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_back_ios_new))
            ],
          )
        ],
      ) 
          );

  }

  void onPressed()
  {

  }

  void SelectCell(int index)
  {
    setState(() {
      sudoku.selectCell(index);
    });
  }
}