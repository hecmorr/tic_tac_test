import 'package:flutter/material.dart';
import 'package:tic_tac_toe/services/game_logic.dart';
import 'package:tic_tac_toe/theme/color.dart';

class TicTacPage extends StatefulWidget {
  const TicTacPage({Key? key}) : super(key: key);

  @override
  State<TicTacPage> createState() => _TicTacPageState();
}

class _TicTacPageState extends State<TicTacPage> {
  String lastValue = 'X';
  bool gameOver = false;
  int turn = 0;
  String result =
      " "; //Possible combinations Row 1-2-3 Col 1-2-3 Diagonal 1-2-3
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    // double boardHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "It's ${lastValue} turn".toUpperCase(),
            style: const TextStyle(fontSize: 58, color: Colors.white),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              crossAxisCount: Game.boardlength ~/ 3,
              children: List.generate(
                Game.boardlength,
                (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            if (game.board![index] == " ") {
                              setState(() {
                                game.board![index] = lastValue;
                                turn++;
                                gameOver = game.winnerCheck(
                                    lastValue, index, scoreboard, 3);
                                if (gameOver) {
                                  result = "$lastValue is the winner!!";
                                } else if (!gameOver && turn == 9) {
                                  result = "It's a Draw";
                                }
                                if (lastValue == "X") {
                                  lastValue = "O";
                                } else {
                                  lastValue = "X";
                                }
                              });
                            }
                          },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                              color: game.board![index] == "X"
                                  ? MainColor.x
                                  : MainColor.o,
                              fontSize: 64.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Text(
            result,
            style: const TextStyle(color: Colors.white, fontSize: 54.0),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = " ";
                scoreboard = [
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                ];
              });
            },
            icon: const Icon(Icons.replay),
            label: const Text('Play again'),
            style: ElevatedButton.styleFrom(primary: MainColor.accentColor),
          )
        ],
      ),
    );
  }
}
