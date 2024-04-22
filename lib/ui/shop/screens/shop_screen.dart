import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/settings/settings_bloc.dart';
import 'package:chicpic/bloc/shop/shop_bloc.dart';

import 'package:chicpic/models/product/shop.dart';
import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/statics/insets.dart';
import 'package:chicpic/statics/grid_delegates.dart';

import 'package:chicpic/ui/shop/widgets/shop_icon.dart';
import 'package:chicpic/ui/base_widgets/filter_button.dart';
import 'package:chicpic/ui/base_widgets/variant_preview_card.dart';

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
      if (blocState is! ShopVariantsFetchLoading &&
          blocState is! ShopVariantsFetchFailure) {
        BlocProvider.of<ShopBloc>(context).add(
          ShopVariantsFetch(shop, firstPage: false),
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
        actions: const [
          FilterButton(iconColor: Colors.white),
        ],
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsShowPersonalizedProductsUpdated) {
            BlocProvider.of<ShopBloc>(context).add(
              ShopVariantsFetch(shop, firstPage: true),
            );
          }
        },
        child: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            if (state is ShopVariantsFetchLoading && state.firstPage == true) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<VariantPreview> variants =
                  BlocProvider.of<ShopBloc>(context).variants;

              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<ShopBloc>(context).add(
                    ShopVariantsFetch(shop, firstPage: true),
                  );
                },
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: variants.length,
                  gridDelegate: variantLargeGridDelegate,
                  itemBuilder: (BuildContext context, int index) {
                    return VariantPreviewCard(variant: variants[index]);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
