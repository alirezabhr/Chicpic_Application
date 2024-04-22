import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/bloc/explore/shops/shops_explore_bloc.dart';
import 'package:chicpic/bloc/shop/shop_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/shop.dart';

import 'package:chicpic/ui/shop/widgets/shop_icon.dart';

class ShopsExploreScreen extends StatefulWidget {
  const ShopsExploreScreen({Key? key}) : super(key: key);

  @override
  State<ShopsExploreScreen> createState() => _ShopsExploreScreenState();
}

class _ShopsExploreScreenState extends State<ShopsExploreScreen> {
  late final ScrollController _scrollController;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final bloc = BlocProvider.of<ShopsExploreBloc>(context);
      if (bloc.state is! ShopsExploreFetchLoading &&
          bloc.state is! ShopsExploreFetchFailure) {
        bloc.add(ShopsExploreFetch(firstPage: false));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Shops'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocBuilder<ShopsExploreBloc, ShopsExploreState>(
          builder: (context, state) {
            if (state is ShopsExploreFetchLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<Shop> shops =
                  BlocProvider.of<ShopsExploreBloc>(context).shops;

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  Shop shop = shops[index];

                  return Column(
                    children: [
                      if (index != 0)
                        const Divider(height: Insets.xSmall, thickness: 1),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Insets.small,
                          vertical: Insets.xSmall / 2,
                        ),
                        horizontalTitleGap: Insets.medium,
                        leading: ShopIcon(imageURL: shop.image, radius: 45),
                        title: Text(
                          shop.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          BlocProvider.of<ShopBloc>(context).add(
                            ShopVariantsFetch(shop, firstPage: true),
                          );
                          Navigator.of(context).pushNamed(
                            AppRouter.shop,
                            arguments: shop,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
