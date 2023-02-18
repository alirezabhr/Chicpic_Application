import 'package:flutter/material.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/product_saved_tracked.dart';

class ProductItem extends StatelessWidget {
  final ProductSavedTracked product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  bool get hasDiscount => product.finalPrice != null;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: deviceHeight * 0.5),
          child: Image.network(product.image),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.small,
            vertical: Insets.xSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      product.isTracked
                          ? Icons.notifications
                          : Icons.notifications_outlined,
                      color: product.isTracked ? Colors.black : Colors.black54,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      product.isSaved ? Icons.bookmark : Icons.bookmark_outline,
                      color: product.isSaved ? Colors.black : Colors.black54,
                    ),
                  ),
                ],
              ),
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
    );
  }
}
