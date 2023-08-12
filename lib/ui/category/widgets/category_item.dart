import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/bloc/category/category_bloc.dart';

import 'package:chicpic/models/product/category.dart';

import 'package:chicpic/ui/category/widgets/base_category_item.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseCategoryItem(
      title: category.title,
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      onTap: () {
        BlocProvider.of<CategoryBloc>(context).add(
          CategoryProductsFetch(category, firstPage: true),
        );
        Navigator.of(context).pushNamed(
          AppRouter.category,
          arguments: category,
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
      trailing: CachedNetworkImage(
        imageUrl: category.image,
        fit: BoxFit.cover,
      ),
    );
  }
}
