import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/bloc/explore/shops/shops_explore_bloc.dart';
import 'package:chicpic/bloc/shop/shop_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/shop.dart';

import 'package:chicpic/ui/shop/widgets/shop_icon.dart';

class ShopsExplore extends StatelessWidget {
  final double _shopBarHeight = Insets.xSmall * 15;

  const ShopsExplore({Key? key}) : super(key: key);

  navigateToShopPage(BuildContext context, Shop shop) {
    BlocProvider.of<ShopBloc>(context).add(
      ShopVariantsFetch(shop, firstPage: true),
    );
    Navigator.of(context).pushNamed(AppRouter.shop, arguments: shop);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.small),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(FontAwesomeIcons.shop,
                  color: Colors.black45, size: 22),
              const SizedBox(width: Insets.medium),
              Text(
                'Explore Shops',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.shopsExplore);
                },
                child: const Text('show all'),
              ),
            ],
          ),
          SizedBox(
            height: _shopBarHeight,
            child: BlocBuilder<ShopsExploreBloc, ShopsExploreState>(
              builder: (context, state) {
                if (state is ShopsExploreFetchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  List<Shop> shops =
                      BlocProvider.of<ShopsExploreBloc>(context).shops;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shops.length,
                    itemBuilder: (context, index) {
                      Shop shop = shops[index];

                      return Padding(
                        padding: const EdgeInsets.all(Insets.xSmall),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateToShopPage(context, shop);
                              },
                              child: ShopIcon(imageURL: shop.image, radius: 80),
                            ),
                            const SizedBox(height: Insets.xSmall / 2),
                            TextButton(
                              onPressed: () {
                                navigateToShopPage(context, shop);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                shop.name,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
