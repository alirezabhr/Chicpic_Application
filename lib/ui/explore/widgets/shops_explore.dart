import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chicpic/bloc/explore/shops/shops_explore_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/shop.dart';

import 'package:chicpic/ui/explore/widgets/shop_item.dart';

class ShopsExplore extends StatelessWidget {
  final double _shopBarHeight = Insets.xSmall * 15;

  const ShopsExplore({Key? key}) : super(key: key);

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
                onPressed: () {},
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
                  List<Shop> shops = BlocProvider.of<ShopsExploreBloc>(context)
                      .shops
                      .take(10)
                      .toList();

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shops.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(Insets.xSmall),
                        child: ShopItem(shop: shops[index]),
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
