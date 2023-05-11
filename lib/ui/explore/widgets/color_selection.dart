import 'dart:math';

import 'package:flutter/material.dart';

import 'package:chicpic/services/utils.dart';

import 'package:chicpic/statics/insets.dart';


class ColorSelectionRow extends StatelessWidget {
  final List<List<Color>> colorsList;
  final List<Color> selectedColoring;

  const ColorSelectionRow({
    Key? key,
    required this.colorsList,
    required this.selectedColoring,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Colors:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: colorsList
              .map(
                (colors) => Padding(
              padding: const EdgeInsets.only(
                right: Insets.xSmall,
              ),
              child: CircularButton(
                colors: colors,
                isSelected: listEquals(selectedColoring, colors),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}

class CircularButton extends StatelessWidget {
  final double radius = 22;
  final List<Color> colors;
  final bool isSelected;

  const CircularButton({
    super.key,
    required this.colors,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300],
          shape: BoxShape.circle),
      child: CustomPaint(
        size: Size(radius, radius),
        painter: _CircularButtonPainter(colors: colors),
      ),
    );
  }
}

class _CircularButtonPainter extends CustomPainter {
  final List<Color> colors;

  _CircularButtonPainter({required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final angle = 2 * pi / colors.length;

    for (var i = 0; i < colors.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * angle,
        angle,
        true,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_CircularButtonPainter oldDelegate) {
    return oldDelegate.colors != colors;
  }
}