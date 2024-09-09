import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/ui/explore/widgets/product_item_dialog.dart';
import 'package:chicpic/ui/base_widgets/off_label.dart';

class VariantPreviewCard extends StatelessWidget {
  final VariantPreview variant;

  const VariantPreviewCard({Key? key, required this.variant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final double cardWidth = deviceSize.width * 0.5 - Insets.xSmall * 2;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ProductItemDialog(
              productId: variant.product,
              variantId: variant.id,
            );
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.all(Insets.xSmall),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Insets.xSmall),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Insets.xSmall),
                    topRight: Radius.circular(Insets.xSmall),
                  ),
                  child: CachedNetworkImage(
                    memCacheHeight: 350,
                    memCacheWidth: 350,
                    imageUrl: variant.imageSrc,
                    placeholder: (context, url) => SizedBox(
                      width: cardWidth,
                      height: cardWidth,
                      child: Center(
                        child: CircularProgressIndicator(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.6),
                        ),
                      ),
                    ),
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) {
                      return SizedBox(
                        width: cardWidth,
                        height: cardWidth,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error),
                            SizedBox(height: Insets.xSmall),
                            Text('Cannot load image!'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (variant.hasDiscount)
                  Positioned(
                    top: 14,
                    left: 10,
                    child: OffLabel(percentage: variant.discountRate),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.xSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    variant.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Insets.xSmall),
                  Row(
                    children: [
                      Text(
                        "\$${variant.originalPrice}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                          decoration: variant.hasDiscount
                              ? TextDecoration.lineThrough
                              : null,
                          fontWeight: variant.hasDiscount
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                      if (variant.hasDiscount)
                        const SizedBox(width: Insets.xSmall),
                      if (variant.hasDiscount)
                        Text(
                          "\$${variant.finalPrice}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
