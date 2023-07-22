import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/models/product/product_attribute.dart';

class ProductAttributesView extends StatelessWidget {
  const ProductAttributesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
      builder: (context, state) {
        if (state is ProductDetailFetchSuccess) {
          return Column(
            children: state.product.attributes
                .map(
                  (attribute) => AttributeSection(attribute: attribute),
                )
                .toList(),
          );
        }
        return Container();
      },
    );
  }
}

class AttributeSection extends StatelessWidget {
  final ProductAttribute attribute;

  const AttributeSection({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = 'option${attribute.position}';

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${attribute.name}: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
            builder: (context, state) {
              if (state is ProductDetailFetchSuccess) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: attribute.values
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            // TODO : change the variant
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: state.selectedVariant.toMap()[key] == e
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                            child: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}