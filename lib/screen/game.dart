import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constraint/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  int attemp = 0;

  List<int> match_Index = [];

  int oScore = 0;
  int xScore = 0;
  int filledBox = 0; //counter for filled box
  String resultDeclaration = '';
  bool winnerIs = false;

  static const maxsecond = 30;
  int second = maxsecond;
  Timer? timer;

  static var customeFontWhite = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  void starttimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (second > 0) {
          second--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    second = maxsecond;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Maincolor.primarycolor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'player O',
                            style: customeFontWhite,
                          ),
                          Text(
                            oScore.toString(),
                            style: customeFontWhite,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'player X',
                            style: customeFontWhite,
                          ),
                          Text(
                            xScore.toString(),
                            style: customeFontWhite,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      // ui of grid
                      crossAxisCount: 3, // there are 3 column in each row
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      // itemBulder make 2d arrey
                      return GestureDetector(
                          // movement of user on grid
                          onTap: () {
                            _tapped(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 5,
                                color: Maincolor.primarycolor,
                              ),
                              color: match_Index.contains(index)
                                  ? Maincolor.accentcolor
                                  : Maincolor.secondrycolor,
                            ),
                            child: Center(
                              child: Text(
                                displayXO[index],
                                style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                  fontSize: 64,
                                  color: Maincolor.primarycolor,
                                )),
                              ),
                            ),
                          ));
                    }),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        resultDeclaration,
                        style: customeFontWhite,
                      ),
                      const SizedBox(height: 10),
                      _buildTimer()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBox++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBox++;
        }

        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // check first row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'player ${displayXO[0]} Win';
        match_Index.addAll([
          0,
          1,
          2,
        ]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }

    // check second row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'player ${displayXO[3]} Win';
        match_Index.addAll([
          3,
          4,
          5,
        ]);
        stopTimer();
        _updateScore(displayXO[3]);
      });
    }

    // check 3 row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'player ${displayXO[6]} Win';
        match_Index.addAll([
          6,
          7,
          8,
        ]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }

    // check first column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'player ${displayXO[0]} Win';
        match_Index.addAll([
          0,
          3,
          6,
        ]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }

    // check second column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'player ${displayXO[1]} Win';
        match_Index.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayXO[1]);
      });
    }

    // check third column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'player ${displayXO[2]} Win';
        match_Index.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayXO[2]);
      });
    }

    // check diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'player ${displayXO[0]} Win';
        match_Index.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }

    // check diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'player ${displayXO[6]} Win';
        match_Index.addAll([6, 4, 2]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    if (!winnerIs && filledBox == 9) {
      setState(() {
        resultDeclaration = 'No body wins!';
        stopTimer();
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      // Use uppercase 'X'
      xScore++;
    }
    winnerIs = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      match_Index.clear(); // Clear the winning indices
    });
    filledBox = 0; // Reset filled boxes counter
    winnerIs = false; // Reset winner flag
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            height: 180,
            width: 180,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - second / maxsecond,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: Maincolor.accentcolor,
                ),
                Center(
                  child: Text(
                    '$second',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                )),
            onPressed: () {
              starttimer();
              _clearBoard();
              attemp++;
            },
            child: Text(
              attemp == 0 ? 'Start ' : 'Play Again! ',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
          );
  }
}
