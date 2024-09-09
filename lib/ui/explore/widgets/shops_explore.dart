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
  const ShopsExplore({Key? key}) : super(key: key);

  navigateToShopPage(BuildContext context, Shop shop) {
    BlocProvider.of<ShopBloc>(context).add(
      ShopVariantsFetch(shop, firstPage: true),
    );
    Navigator.of(context).pushNamed(AppRouter.shop, arguments: shop);
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final double shopBarHeight =
        deviceSize.width > 360 ? Insets.large * 4 : Insets.medium * 4;
    final double shopIconSize = shopBarHeight / 2;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.small),
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.shop,
                color: Colors.black45,
                size: 16,
              ),
              const SizedBox(width: Insets.small),
              Text(
                'Explore Shops',
                style: TextStyle(
                    fontSize: 16,
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
        ),
        SizedBox(
          height: shopBarHeight,
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
                      padding: const EdgeInsets.only(
                        top: Insets.xSmall,
                        left: Insets.xSmall,
                        right: Insets.xSmall,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          navigateToShopPage(context, shop);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ShopIcon(
                              imageURL: shop.image,
                              radius: shopIconSize,
                            ),
                            const SizedBox(height: Insets.xSmall / 2),
                            SizedBox(
                              width: shopIconSize + Insets.medium,
                              child: Text(
                                shop.name,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
