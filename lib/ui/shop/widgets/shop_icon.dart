import 'package:flutter/material.dart';

class ShopIcon extends StatelessWidget {
  final String imageURL;
  final double radius;

  const ShopIcon({Key? key, required this.imageURL, this.radius = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          width: 0.5,
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(imageURL),
      ),
    );
  }
}
