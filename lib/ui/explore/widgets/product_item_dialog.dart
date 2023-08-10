import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/services/api_service.dart';
import 'package:chicpic/services/snack_bar.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';
import 'package:chicpic/bloc/shop/shop_bloc.dart';
import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/ui/shop/widgets/shop_icon.dart';
import 'package:chicpic/ui/explore/widgets/color_selection.dart';
import 'package:chicpic/ui/explore/widgets/size_selection.dart';
import 'package:chicpic/ui/explore/widgets/product_attributes.dart';

class ProductItemDialog extends StatelessWidget {
  final int productId;
  final int? variantId;

  const ProductItemDialog({
    Key? key,
    required this.productId,
    this.variantId,
  }) : super(key: key);

  bool hasDiscount(VariantDetail variant) =>
      variant.originalPrice != variant.finalPrice;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsExploreBloc>(context)
        .add(ProductDetailFetch(productId, variantId));

    final Size deviceSize = MediaQuery.of(context).size;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        vertical: Insets.large,
        horizontal: Insets.xLarge,
      ),
      child: Scaffold(
        body: BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
          builder: (context, state) {
            if (state is ProductDetailFetchSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shop information
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Insets.small,
                        vertical: Insets.xSmall,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<ShopBloc>(context).add(
                                ShopProductsFetch(
                                  state.product.shop,
                                  firstPage: true,
                                ),
                              );
                              Navigator.of(context).pushNamed(
                                AppRouter.shop,
                                arguments: state.product.shop,
                              );
                            },
                            child: ShopIcon(imageURL: state.product.shop.image),
                          ),
                          const SizedBox(width: Insets.small),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<ShopBloc>(context).add(
                                ShopProductsFetch(
                                  state.product.shop,
                                  firstPage: true,
                                ),
                              );
                              Navigator.of(context).pushNamed(
                                AppRouter.shop,
                                arguments: state.product.shop,
                              );
                            },
                            child: Text(
                              state.product.shop.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Variant Image and buttons on image
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: deviceSize.height * 0.6,
                      ),
                      child: Stack(
                        children: [
                          // Variant image
                          SizedBox(
                            width: deviceSize.width,
                            child: CachedNetworkImage(
                              imageUrl: state.selectedVariant.imageSrc,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) {
                                return const Center(child: Icon(Icons.error));
                              },
                            ),
                          ),
                          Positioned(
                            right: 15,
                            bottom: 5,
                            child: BuyButton(variant: state.selectedVariant),
                          ),
                        ],
                      ),
                    ),
                    // Variant details
                    Padding(
                      padding: const EdgeInsets.all(Insets.small),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // fit the title to the screen
                              SizedBox(
                                width: deviceSize.width * 0.5,
                                child: Text(
                                  state.product.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              TrackButton(variant: state.selectedVariant),
                              const SizedBox(width: Insets.xSmall),
                              SaveButton(variant: state.selectedVariant),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                state.product.brand,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const Spacer(),
                              Text(
                                "\$${state.selectedVariant.originalPrice}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                  decoration: hasDiscount(state.selectedVariant)
                                      ? TextDecoration.lineThrough
                                      : null,
                                  fontWeight: hasDiscount(state.selectedVariant)
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
                              ),
                              hasDiscount(state.selectedVariant)
                                  ? Row(
                                      children: [
                                        const SizedBox(width: Insets.xSmall),
                                        Text(
                                          "\$${state.selectedVariant.finalPrice}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                          const SizedBox(height: Insets.xSmall),
                          const ColorSelectionRow(),
                          const SizedBox(height: Insets.xSmall),
                          const SizeSelection(),
                          const SizedBox(height: Insets.xSmall),
                          const ProductAttributesView(),
                          const SizedBox(height: Insets.small),
                          if (state.product.description.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Description:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: Insets.xSmall / 2),
                                Text(
                                  state.product.description,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class BuyButton extends StatelessWidget {
  final VariantDetail variant;

  const BuyButton({Key? key, required this.variant}) : super(key: key);

  final Color textStrokeColor = Colors.white;

  void openWebsite() {
    // launch(variant.link);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: variant.isAvailable ? openWebsite : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.4),
      ),
      child: Row(
        children: [
          Icon(Icons.shopping_cart_outlined, size: 16, color: textStrokeColor),
          const SizedBox(width: Insets.xSmall),
          Text(
            variant.isAvailable ? 'Buy item' : 'Sold out',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class TrackButton extends StatelessWidget {
  final VariantDetail variant;

  const TrackButton({Key? key, required this.variant}) : super(key: key);

  Future<void> track(BuildContext context) async {
    try {
      final userId = BlocProvider.of<AuthBloc>(context).user!.id;
      await APIService.trackVariant(userId, variant.id);

      showSnackBar(
        context,
        'Item tracked successfully.',
        SnackBarStatus.success,
      );
    } catch (e) {
      showSnackBar(
        context,
        'Cannot track the item. Please try later.',
        SnackBarStatus.error,
      );
    }
  }

  Future<void> untrack(BuildContext context) async {
    try {
      final userId = BlocProvider.of<AuthBloc>(context).user!.id;
      await APIService.untrackVariant(userId, variant.id);

      showSnackBar(context, 'Item untracked.', SnackBarStatus.normal);
    } catch (e) {
      showSnackBar(
        context,
        'Cannot untrack the item. Please try later.',
        SnackBarStatus.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (variant.isTracked) {
          untrack(context);
        } else {
          track(context);
        }
      },
      splashRadius: 20,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 14,
        minHeight: 14,
        maxWidth: 20,
        maxHeight: 20,
      ),
      tooltip: variant.isSaved ? 'Untrack item' : 'Track item',
      icon: Icon(
        variant.isTracked
            ? Icons.notifications
            : Icons.notifications_active_outlined,
        size: 20,
        color: Colors.amber[700],
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final VariantDetail variant;

  const SaveButton({Key? key, required this.variant}) : super(key: key);

  Future<void> save(BuildContext context) async {
    try {
      final userId = BlocProvider.of<AuthBloc>(context).user!.id;
      await APIService.saveVariant(userId, variant.id);

      showSnackBar(context, 'Item saved successfully.', SnackBarStatus.success);
    } catch (e) {
      showSnackBar(
        context,
        'Cannot save the item. Please try later.',
        SnackBarStatus.error,
      );
    }
  }

  Future<void> unsave(BuildContext context) async {
    try {
      final userId = BlocProvider.of<AuthBloc>(context).user!.id;
      await APIService.unsaveVariant(userId, variant.id);

      showSnackBar(context, 'Item unsaved.', SnackBarStatus.normal);
    } catch (e) {
      showSnackBar(
        context,
        'Cannot unsave the item. Please try later.',
        SnackBarStatus.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (variant.isSaved) {
          unsave(context);
        } else {
          save(context);
        }
      },
      splashRadius: 20,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 14,
        minHeight: 14,
        maxWidth: 20,
        maxHeight: 20,
      ),
      tooltip: variant.isSaved ? 'Unsave item' : 'Save item',
      icon: Icon(
        variant.isSaved ? Icons.bookmark : Icons.bookmark_border_outlined,
        size: 20,
        color: Colors.deepPurple,
      ),
    );
  }
}
