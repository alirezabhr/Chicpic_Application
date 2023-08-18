import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/models/product/product.dart';

import 'package:chicpic/ui/explore/widgets/product_item_dialog.dart';

class ProductPreviewWidget extends StatelessWidget {
  final ProductPreview product;

  const ProductPreviewWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ProductItemDialog(
              productId: product.id,
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
          imageUrl: product.previewImage,
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
  }
}
