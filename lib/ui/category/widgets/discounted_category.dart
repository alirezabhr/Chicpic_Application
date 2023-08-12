import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/category/category_bloc.dart';

import 'package:chicpic/models/product/category.dart';

import 'base_category_item.dart';

class DiscountedCategory extends StatelessWidget {
  const DiscountedCategory({Key? key}) : super(key: key);

  final int discountPercentage = 50;

  @override
  Widget build(BuildContext context) {
    return BaseCategoryItem(
      backgroundGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.greenAccent,
          Colors.lightGreenAccent,
          Colors.yellowAccent,
        ],
      ),
      title: 'OFFERS',
      onTap: () {
        final tmpCategory =
            Category(title: 'Offers', id: 0, gender: '', image: '');
        BlocProvider.of<CategoryBloc>(context).add(
          DiscountedProductsFetch(
            tmpCategory,
            discountPercentage,
            firstPage: true,
          ),
        );
        Navigator.of(context).pushNamed(
          AppRouter.category,
          arguments: tmpCategory,
        );
      },
      description: 'From $discountPercentage% off',
      trailing: RotationTransition(
        turns: const AlwaysStoppedAnimation(-15 / 360),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.small,
          ),
          alignment: Alignment.center,
          child: Text(
            '$discountPercentage%',
            style: const TextStyle(
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
