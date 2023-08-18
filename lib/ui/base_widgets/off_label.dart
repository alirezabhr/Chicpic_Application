import 'package:flutter/material.dart';

class OffLabel extends StatelessWidget {
  const OffLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 8,
      left: 4,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(-3 / 36),
        child: Text(
          'OFF',
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
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
      ),
    );
  }
}
