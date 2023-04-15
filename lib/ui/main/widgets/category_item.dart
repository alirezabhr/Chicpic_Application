import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/app_router.dart';

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
        Navigator.of(context).pushNamed(
          AppRouter.category,
          arguments: category.id,
        );
      },
      child: Container(
        height: _containerHeight,
        margin: const EdgeInsets.symmetric(vertical: Insets.xSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(Insets.small),
                child: FittedBox(
                  child: Text(
                    category.title,
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
            ),
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
                child: CachedNetworkImage(
                  imageUrl: category.image,
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
