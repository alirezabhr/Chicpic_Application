import 'package:flutter/material.dart';

class OffLabel extends StatelessWidget {
  final int percentage;

  const OffLabel({Key? key, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: const AlwaysStoppedAnimation(-2 / 36),
      child: Text(
        '-$percentage%',
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.white,
              offset: Offset(1, 1),
              blurRadius: 2,
            ),
            Shadow(
              color: Colors.white,
              offset: Offset(-1, -1),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
