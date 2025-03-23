import 'package:flutter/material.dart';
import 'package:sudoku_flutter/components/CellWidget.dart';
import 'package:sudoku_flutter/components/ControlNumberButton.dart';
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
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 20, 127, 221).withOpacity(0.3),
                    spreadRadius: 6,
                    blurRadius: 8,
                  )
                ]
              ),
              child: Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 9),
                    itemCount: 81,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => selectCell(index),
                      child: CellWidget(cell: sudoku.cells[index]),
                    ),
                  ),
              ),
            ),
          ),

          //GAME CONTROLL
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Numbers
              ControlNumberButton(number: "1", onTap: () => setNumber(1)),
              ControlNumberButton(number: "2", onTap: () => setNumber(2)),
              ControlNumberButton(number: "3", onTap: () => setNumber(3)),
              ControlNumberButton(number: "4", onTap: () => setNumber(4)),
              ControlNumberButton(number: "5", onTap: () => setNumber(5)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Numbers
              ControlNumberButton(number: "6", onTap: () => setNumber(6)),
              ControlNumberButton(number: "7", onTap: () => setNumber(7)),
              ControlNumberButton(number: "8", onTap: () => setNumber(8)),
              ControlNumberButton(number: "9", onTap: () => setNumber(9)),
            ],
          ),
          //TOOLS 
          Row(
            children: [
              IconButton(
                onPressed: clear, 
                icon: const Icon(Icons.clear),
                color:Colors.grey,
              ),
              IconButton(
                onPressed: changeMode, 
                icon: const Icon(Icons.mode),
                color: sudoku.notesMode ? Colors.blue : Colors.grey,
              ),
            ],
          )
        ],
      ) 
          );

  }

  void changeMode()
  {
    setState(() => sudoku.changeNotesMode());
  }

  void clear()
  {
    setState(() => sudoku.clearCell());
  }

  void setNumber(int number)
  {
    setState(() => sudoku.setNumber(number));
  }

  void selectCell(int index)
  {
    setState(() {
      sudoku.selectCell(index);
    });
  }
}