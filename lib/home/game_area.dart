import 'package:flutter/material.dart';
import 'package:snakegame/home/widgets/snake_pixel.dart';
import 'widgets/blank_pixel.dart';
import 'widgets/food_pixel.dart';

class GameArea extends StatelessWidget {
  const GameArea({
    super.key,
    required this.rowSize,
    required this.totalNumberOfSquares,
    required this.snakePos,
    required this.foodPosition,
  });

  final int rowSize;
  final int totalNumberOfSquares;
  final List<int> snakePos;
  final int foodPosition;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowSize),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalNumberOfSquares,
      itemBuilder: (context, idx) {
        if (snakePos.contains(idx)) {
          return const SnakePixel();
        } else if (foodPosition == idx) {
          return const FoodPixel();
        } else {
          return const BlankPixel();
        }
      },
    );
  }
}
