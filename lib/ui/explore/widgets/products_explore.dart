import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/ui/explore/widgets/product_item_dialog.dart';
import 'package:chicpic/ui/base_widgets/off_label.dart';

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
        const SizedBox(height: Insets.small),
        BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
          builder: (context, state) {
            if (state is ProductsExploreFetchLoading && state.page == 1) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              List<VariantPreview> variants =
                  BlocProvider.of<ProductsExploreBloc>(context).variants;

              return Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: variants.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ProductItemDialog(
                                productId: variants[index].product,
                                variantId: variants[index].id,
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
                                imageUrl: variants[index].imageSrc,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.6),
                                  ),
                                ),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            if (variants[index].hasDiscount) const OffLabel(),
                          ],
                        ),
                      );
                    },
                  ),
                  state is ProductsExploreFetchLoading
                      ? const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Insets.medium),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Container()
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
