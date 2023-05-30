import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../enum.dart';
import 'game_area.dart';
import 'score_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int rowSize = 20;
  int totalNumberOfSquares = 400;
  int currentScore = 0;
  bool gameHasStarted = false;

  List<int> snakePos = [0, 1, 2];

  var currentDirection = Direction.LEFT;

  int foodPosition = Random().nextInt(399);

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        moveSnake();
        if (gameOver()) {
          timer.cancel();
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Oyun Bitti'),
                content: Text('Harika! Skorunuz: $currentScore'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      newGame();
                    },
                    child: const Text(
                      'Yeni Oyun',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }

  bool gameOver() {
    List<int> bodySnake = snakePos.sublist(0, snakePos.length - 1);

    if (bodySnake.contains(snakePos.last)) {
      return true;
    }
    return false;
  }

  void eatFood() {
    currentScore++;
    while (snakePos.contains(foodPosition)) {
      foodPosition = Random().nextInt(totalNumberOfSquares);
    }
  }

  void newGame() {
    setState(() {
      snakePos = [0, 1, 2];
      foodPosition = Random().nextInt(399);
      currentDirection = Direction.LEFT;
      gameHasStarted = false;
      currentScore = 0;
    });
  }

  void moveSnake() {
    switch (currentDirection) {
      case Direction.RIGHT:
        {
          if (snakePos.last % rowSize == 19) {
            snakePos.add(snakePos.last + 1 - rowSize);
          } else {
            snakePos.add(snakePos.last + 1);
          }
        }
        break;

      case Direction.LEFT:
        {
          if (snakePos.last % rowSize == 0) {
            snakePos.add(snakePos.last - 1 + rowSize);
          } else {
            snakePos.add(snakePos.last - 1);
          }
        }
        break;

      case Direction.UP:
        {
          if (snakePos.last < rowSize) {
            snakePos.add(snakePos.last - rowSize + totalNumberOfSquares);
          } else {
            snakePos.add(snakePos.last - rowSize);
          }
        }
        break;

      case Direction.DOWN:
        {
          if (snakePos.last + rowSize > totalNumberOfSquares) {
            snakePos.add(snakePos.last + rowSize - totalNumberOfSquares);
          } else {
            snakePos.add(snakePos.last + rowSize);
          }
        }
        break;
      default:
    }
    if (snakePos.first == foodPosition) {
      eatFood();
    } else {
      snakePos.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          ScoreText(currentScore: currentScore),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0 && currentDirection != Direction.UP) {
                  currentDirection = Direction.DOWN;
                } else if (details.delta.dy < 0 &&
                    currentDirection != Direction.DOWN) {
                  currentDirection = Direction.UP;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0 &&
                    currentDirection != Direction.LEFT) {
                  currentDirection = Direction.RIGHT;
                } else if (details.delta.dx < 0 &&
                    currentDirection != Direction.RIGHT) {
                  currentDirection = Direction.LEFT;
                }
              },
              child: GameArea(
                  rowSize: rowSize,
                  totalNumberOfSquares: totalNumberOfSquares,
                  snakePos: snakePos,
                  foodPosition: foodPosition),
            ),
          ),
          playButton(),
        ],
      ),
    );
  }

  Expanded playButton() {
    return Expanded(
      child: Center(
        child: MaterialButton(
          textColor: Colors.white,
          color: gameHasStarted ? Colors.grey : Colors.orange,
          onPressed: gameHasStarted ? () {} : startGame,
          child: const Text('Başla'),
        ),
      ),
    );
  }
}
