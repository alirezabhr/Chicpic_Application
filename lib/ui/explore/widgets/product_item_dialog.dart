import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/ui/explore/widgets/color_selection.dart';
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
                  Padding(
                    padding: const EdgeInsets.all(Insets.small),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              width: 0.5,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Image.network(state.product.shop.image),
                        ),
                        const SizedBox(width: Insets.small),
                        Text(
                          state.product.shop.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: deviceSize.height * 0.6,
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: deviceSize.width,
                          child: CachedNetworkImage(
                            imageUrl: state.selectedVariant.imageSrc,
                            fit: BoxFit.fill,
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
                          child: BuyButton(
                            websiteLink: state.selectedVariant.link,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        ColorSelectionRow(
                          colorsList: state.colorsChoices,
                          selectedColoring: state.selectedVariant.coloring,
                        ),
                        ProductAttributesView(
                          attributes: state.product.attributes,
                          selectedVariant: state.selectedVariant,
                        ),
                        const SizedBox(height: Insets.small),
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
            'Buy it',
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
