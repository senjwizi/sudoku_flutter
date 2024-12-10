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
                      child: CellWidget(cell: sudoku.cells[index],),
                    ),
                  ),
              ),
            ),
          ),

          //GAME CONTROLL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

              //Numbers
              TextButton(
                onPressed: () => setNumber(1), 
                child: const Text("1"),
              ),
                            TextButton(
                onPressed: () => setNumber(2), 
                child: const Text("2"),
              ),
                            TextButton(
                onPressed: () => setNumber(3), 
                child: const Text("3"),
              ),
                            TextButton(
                onPressed: () => setNumber(4), 
                child: const Text("4"),
              ),
                            TextButton(
                onPressed: () => setNumber(5), 
                child: const Text("5"),
              ),
                            TextButton(
                onPressed: () => setNumber(6), 
                child: const Text("6"),
              ),
                            TextButton(
                onPressed: () => setNumber(7), 
                child: const Text("7"),
              ),
                            TextButton(
                onPressed: () => setNumber(8), 
                child: const Text("8"),
              ),
                            TextButton(
                onPressed: () => setNumber(9), 
                child: const Text("9"),
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