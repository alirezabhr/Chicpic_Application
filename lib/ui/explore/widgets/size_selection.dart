import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/models/product/variant.dart';

class SizeSelection extends StatelessWidget {
  const SizeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Size: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
            builder: (context, state) {
              if (state is ProductDetailFetchSuccess) {
                final List<VariantDetail> variants = state.product.variants
                    .where((v) => v.colorHex == state.selectedVariant.colorHex)
                    .toList();

                final List<String> sizes = variants
                    .where((e) => e.size != null && e.size!.isNotEmpty)
                    .map((e) => e.size!)
                    .toSet()
                    .toList();

                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: sizes
                      .map(
                        (String size) => GestureDetector(
                          onTap: () {
                            BlocProvider.of<ProductsExploreBloc>(context).add(
                              ProductDetailChangeSize(
                                state.product,
                                state.selectedVariant.colorHex!,
                                size,
                              ),
                            );
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 2.0,
                                    color: state.selectedVariant.size == size
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).disabledColor),
                              ),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: variants
                                        .where((v) => v.size == size)
                                        .every((v) => v.isAvailable == false)
                                    ? Theme.of(context).disabledColor
                                    : Colors.black87,
                              ),
                            ),
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
