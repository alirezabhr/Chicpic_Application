import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';
import 'package:chicpic/bloc/shop/shop_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/variant.dart';

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
      child: BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
        builder: (context, state) {
          if (state is ProductDetailFetchSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shop image and name
                  Padding(
                    padding: const EdgeInsets.all(Insets.small),
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
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                width: 0.5,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // padding: const EdgeInsets.all(6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(state.product.shop.image),
                            ),
                          ),
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
                          child: state.selectedVariant.isAvailable
                              ? BuyButton(
                                  websiteLink: state.selectedVariant.link,
                                )
                              : TrackButton(
                                  variantId: state.selectedVariant.id,
                                ),
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
                        Text(
                          state.product.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
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
    );
  }
}

class BuyButton extends StatelessWidget {
  final String websiteLink;

  const BuyButton({Key? key, required this.websiteLink}) : super(key: key);

  final Color textStrokeColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //TODO open the seller website
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.4),
      ),
      child: Row(
        children: const [
          Icon(Icons.shopping_cart_outlined, size: 16),
          SizedBox(width: Insets.xSmall),
          Text(
            'Buy item',
            style: TextStyle(
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
  final int variantId;

  const TrackButton({Key? key, required this.variantId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //TODO track the variant
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.4),
      ),
      child: Row(
        children: const [
          Icon(Icons.notifications_active_outlined, size: 16),
          SizedBox(width: Insets.xSmall),
          Text(
            'Track item',
            style: TextStyle(
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
