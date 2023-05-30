import 'package:flutter/material.dart';

class ScoreText extends StatelessWidget {
  const ScoreText({
    super.key,
    required this.currentScore,
  });

  final int currentScore;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Score',
            style: TextStyle(color: Colors.orange, fontSize: 24.0),
          ),
          Text(
            currentScore.toString(),
            style: const TextStyle(color: Colors.orange, fontSize: 36.0),
          ),
        ],
      ),
    );
  }
}
