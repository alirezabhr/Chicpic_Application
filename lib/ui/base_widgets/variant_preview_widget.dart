import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/ui/base_widgets/off_label.dart';
import 'package:chicpic/ui/explore/widgets/product_item_dialog.dart';

class VariantPreviewWidget extends StatelessWidget {
  final VariantPreview variant;

  const VariantPreviewWidget({Key? key, required this.variant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(width: 0.2),
                horizontal: BorderSide(width: 0.1),
              ),
            ),
            child: CachedNetworkImage(
              memCacheHeight: 300,
              memCacheWidth: 300,
              imageUrl: variant.imageSrc,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                ),
              ),
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
            ),
            // child: Image.network(
            //   variant.imageSrc,
            //   fit: BoxFit.cover,
            //   loadingBuilder: (context, child, loadingProgress) {
            //     if (loadingProgress == null) {
            //       return child;
            //     }
            //     return Center(
            //       child: CircularProgressIndicator(
            //         color: Theme.of(context).primaryColor.withOpacity(0.6),
            //       ),
            //     );
            //   },
            //   errorBuilder: (context, error, stackTrace) {
            //     return const Icon(Icons.error);
            //   },
            // ),
          ),
          if (variant.hasDiscount) const OffLabel(),
        ],
      ),
    );
  }
}
