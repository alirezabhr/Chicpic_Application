import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/shop/shop_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/shop.dart';

class ShopItem extends StatelessWidget {
  final Shop shop;
  final double _containerHeight = 80;
  final double _borderRadius = 10;

  const ShopItem({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ShopBloc>(context).add(
          ShopProductsFetch(shop, firstPage: true),
        );
        Navigator.of(context).pushNamed(AppRouter.shop, arguments: shop);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: _containerHeight,
            height: _containerHeight,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(_borderRadius + 2)),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              child: Image.network(
                shop.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: Insets.xSmall / 2),
          Text(
            shop.name,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
