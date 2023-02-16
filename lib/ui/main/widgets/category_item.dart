import 'package:flutter/material.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  final double _containerHeight = 80;
  final double _borderRadius = 20;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO navigate to category products page
      },
      child: Container(
        height: _containerHeight,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: Insets.xSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          color: Theme.of(context).primaryColor,
          // border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: Text(
                category.title,
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: _containerHeight,
              height: _containerHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  topLeft: Radius.zero,
                  bottomLeft: Radius.zero,
                ),
                child: Image.network(
                  category.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
