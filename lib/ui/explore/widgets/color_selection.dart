import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/services/utils.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/statics/insets.dart';

class ColorSelectionRow extends StatelessWidget {
  const ColorSelectionRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
      builder: (context, state) {
        if (state is ProductDetailFetchSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Colors:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: state.colorsChoices
                    .map(
                      (colors) => Padding(
                        padding: const EdgeInsets.only(
                          right: Insets.xSmall,
                        ),
                        child: CircularButton(
                          onTap: () {
                            BlocProvider.of<ProductsExploreBloc>(context).add(
                              ProductDetailChangeColor(state.product, colors),
                            );
                          },
                          colors: colors,
                          isSelected: listEquals(
                            state.selectedVariant.coloring,
                            colors,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class CircularButton extends StatelessWidget {
  final double radius = 22;
  final VoidCallback onTap;
  final List<Color> colors;
  final bool isSelected;

  const CircularButton({
    super.key,
    required this.onTap,
    required this.colors,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.all(2),
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).disabledColor.withOpacity(0.5),
          child: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(1),
              color: Colors.white,
              child: CustomPaint(
                size: Size(radius, radius),
                painter: _CircularButtonPainter(colors: colors),
              ),
            ),
          ),
        ),
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
