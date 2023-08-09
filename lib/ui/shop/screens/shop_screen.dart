import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/bloc/shop/shop_bloc.dart';

import 'package:chicpic/models/product/shop.dart';
import 'package:chicpic/models/product/product.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/explore/widgets/product_item_dialog.dart';
import 'package:chicpic/ui/shop/widgets/shop_icon.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Shop shop;
  late final ScrollController _scrollController;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final blocState = BlocProvider.of<ShopBloc>(context).state;
      if (blocState is! ShopProductsFetchLoading &&
          blocState is! ShopProductsFetchFailure) {
        BlocProvider.of<ShopBloc>(context).add(
          ShopProductsFetch(shop, firstPage: false),
        );
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
    shop = ModalRoute.of(context)!.settings.arguments as Shop;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            ShopIcon(imageURL: shop.image),
            const SizedBox(width: Insets.small),
            Text(shop.name),
          ],
        ),
      ),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopProductsFetchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<ProductPreview> products =
                BlocProvider.of<ShopBloc>(context).products;

            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<ShopBloc>(context).add(
                  ShopProductsFetch(shop, firstPage: true),
                );
              },
              child: GridView.builder(
                controller: _scrollController,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ProductItemDialog(
                            productId: products[index].id,
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          vertical: BorderSide(width: 0.2),
                          horizontal: BorderSide(width: 0.1),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: products[index].previewImage,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.6),
                          ),
                        ),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
