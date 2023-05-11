import 'package:flutter/material.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/product_attribute.dart';
import 'package:chicpic/models/product/variant.dart';

class ProductAttributesView extends StatelessWidget {
  final List<ProductAttribute> attributes;
  final VariantDetail selectedVariant;

  const ProductAttributesView({
    Key? key,
    required this.attributes,
    required this.selectedVariant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...attributes.map(
              (attribute) => Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Insets.xSmall,
                ),
                child: Divider(thickness: 0.8),
              ),
              AttributeSection(
                attribute: attribute,
                selectedVariant: selectedVariant,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AttributeSection extends StatelessWidget {
  final ProductAttribute attribute;
  final VariantDetail selectedVariant;

  const AttributeSection({
    Key? key,
    required this.attribute,
    required this.selectedVariant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fieldName = 'option${attribute.position}';

    return Row(
      children: [
        Text(
          '${attribute.name}: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(selectedVariant.toMap()[fieldName]),
      ],
    );
  }
}