import 'package:flutter/material.dart';
import '/models/tictactoe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var tictactoeButtons = List.generate(9, (index) => TicTacToeBox(val: '', isSelected: false));
  bool isX = false;
  int? player = 1;
  int occupiedSpaces = 0;
  // ways to win
    // [0, 1, 2],
    // [3, 4, 5],
    // [6, 7, 8],
    // [0, 3, 6],
    // [1, 4, 7],
    // [2, 5, 8],
    // [0, 4, 8],
    // [2, 4, 6],
  

  void drawDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Draw"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: const Text("Restart"),
            )
          ],
        );
      },
    );
  }

  void winDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message == 'X' ? "Player 1 wins" : "Player 2 wins"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: const Text("Ok"),
            )
          ],
        );
      },
    );
  }

  void checkWinner() {
    // row
    if (tictactoeButtons[0].val != '' &&
        tictactoeButtons[0].val == tictactoeButtons[1].val &&
        tictactoeButtons[0].val == tictactoeButtons[2].val) {
      winDialog(tictactoeButtons[0].val!);
    } else if (tictactoeButtons[3].val != '' &&
        tictactoeButtons[3].val == tictactoeButtons[4].val &&
        tictactoeButtons[3].val == tictactoeButtons[5].val) {
      winDialog(tictactoeButtons[3].val!);
    } else if (tictactoeButtons[6].val != '' &&
        tictactoeButtons[6].val == tictactoeButtons[7].val &&
        tictactoeButtons[6].val == tictactoeButtons[8].val) {
      winDialog(tictactoeButtons[6].val!);
    }

    // column
    else if (tictactoeButtons[0].val != '' &&
        tictactoeButtons[0].val == tictactoeButtons[3].val &&
        tictactoeButtons[0].val == tictactoeButtons[6].val) {
      winDialog(tictactoeButtons[0].val!);
    } else if (tictactoeButtons[1].val != '' &&
        tictactoeButtons[1].val == tictactoeButtons[4].val &&
        tictactoeButtons[1].val == tictactoeButtons[7].val) {
      winDialog(tictactoeButtons[1].val!);
    } else if (tictactoeButtons[2].val != '' &&
        tictactoeButtons[2].val == tictactoeButtons[5].val &&
        tictactoeButtons[2].val == tictactoeButtons[8].val) {
      winDialog(tictactoeButtons[2].val!);
    }

    //diagonal
    else if (tictactoeButtons[0].val != '' &&
        tictactoeButtons[0].val == tictactoeButtons[4].val &&
        tictactoeButtons[0].val == tictactoeButtons[8].val) {
      winDialog(tictactoeButtons[0].val!);
    } else if (tictactoeButtons[2].val != '' &&
        tictactoeButtons[2].val == tictactoeButtons[4].val &&
        tictactoeButtons[2].val == tictactoeButtons[6].val) {
      winDialog(tictactoeButtons[2].val!);
    } else if (occupiedSpaces == 9) {
      drawDialog();
    }
  }

  void restartGame() {
    reset();
    tictactoeButtons.forEach((element) {
      setState(() {
        element.val = '';
        element.isSelected = false;
      });
    });
    setState(() {
      player = 1;
    });
  }

  void reset() {
    setState(() {
      occupiedSpaces = 0;
      isX = false;
    });
  }

  void toggleXO(int index) {
    if (isX && tictactoeButtons[index].isSelected == false) {
      isX = !isX;
      setState(() {
        tictactoeButtons[index].val = "O";
        tictactoeButtons[index].isSelected = true;
        player = 1;
        if (occupiedSpaces < 9) {
          occupiedSpaces++;
        } else {
          checkWinner();
        }
      });
    } else if (!isX && tictactoeButtons[index].isSelected == false) {
      isX = !isX;
      setState(() {
        tictactoeButtons[index].val = "X";
        tictactoeButtons[index].isSelected = true;
        player = 2;
        if (occupiedSpaces < 9) {
          occupiedSpaces++;
        } else {
          checkWinner();
        }
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black,
            constraints: BoxConstraints(
              maxHeight: size.height / 6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    Text(
                      "Player 1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "X",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      "Player 2",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "O",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxHeight: 320),
            child: GridView.builder(
              itemCount: tictactoeButtons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    toggleXO(index);
                    checkWinner();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)),
                    child: GridTile(
                      child: Center(
                        child: Text(
                          tictactoeButtons[index].val!,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 40,
            child: Center(
              child: Text(
                occupiedSpaces < 9 ? "Player $player's turn" : "Game over",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        elevation: 0,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Restart game?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        restartGame();
                        Navigator.pop(context);
                      },
                      child: const Text("Yes"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}