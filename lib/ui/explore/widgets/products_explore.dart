import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/product_saved_tracked.dart';

import 'package:chicpic/ui/explore/widgets/product_item.dart';

class ProductsExplore extends StatelessWidget {
  const ProductsExplore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.small),
          child: Row(
            children: [
              const Icon(FontAwesomeIcons.shirt,
                  color: Colors.black45, size: 22),
              const SizedBox(width: Insets.medium),
              Text(
                'Explore Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
          builder: (context, state) {
            if (state is ProductsExploreFetchLoading) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              List<ProductSavedTracked> products =
                  BlocProvider.of<ProductsExploreBloc>(context).products;

              // TODO change it to ListView.builder for better performance without any rendering error.
              return Column(
                children: products
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Insets.xSmall),
                          child: ProductItem(product: e),
                        ))
                    .toList(),
              );
            }
          },
        ),
      ],
    );
  }
}
