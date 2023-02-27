import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/product.dart';

import 'package:chicpic/ui/explore/widgets/product_item_dialog.dart';

class ProductsExplore extends StatelessWidget {
  const ProductsExplore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

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
              List<ProductBase> products =
                  BlocProvider.of<ProductsExploreBloc>(context).products;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.small),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ProductItemDialog(product: products[index]);
                          },
                        );
                      },
                      child: Image.network(
                        products[index].image,
                        width: deviceSize.width / 3,
                        height: deviceSize.width / 3,
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
