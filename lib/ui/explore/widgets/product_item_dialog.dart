import 'package:flutter/material.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/product.dart';

class ProductItemDialog extends StatelessWidget {
  final ProductBase product;

  const ProductItemDialog({Key? key, required this.product}) : super(key: key);

  bool get hasDiscount => product.finalPrice != null;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        vertical: Insets.large,
        horizontal: Insets.xLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(Insets.small),
            child: Text(
              product.brand.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: deviceHeight * 0.6),
            child: Stack(
              children: [
                Image.network(product.image),
                Positioned(
                  right: 15,
                  bottom: 5,
                  child: BuyButton(websiteLink: product.link),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.small,
              vertical: Insets.xSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "\$${product.originalPrice}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    decoration: hasDiscount ? TextDecoration.lineThrough : null,
                  ),
                ),
                hasDiscount
                    ? Text(
                        "\$${product.finalPrice}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
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
    return TextButton(
      onPressed: () {
        //TODO open the seller website
      },
      child: Text(
        'Buy it',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade600,
          decoration: TextDecoration.underline,
          decorationThickness: 2,
          shadows: [
            Shadow(
              offset: const Offset(-1.5, -1.5),
              color: textStrokeColor,
            ),
            Shadow(
              offset: const Offset(1.5, -1.5),
              color: textStrokeColor,
            ),
            Shadow(
              offset: const Offset(1.5, 1.5),
              color: textStrokeColor,
            ),
            Shadow(
              offset: const Offset(-1.5, 1.5),
              color: textStrokeColor,
            ),
          ],
        ),
      ),
    );
  }
}
