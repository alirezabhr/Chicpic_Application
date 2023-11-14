import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/base_widgets/variant_preview_widget.dart';

class SavedVariantsScreen extends StatefulWidget {
  const SavedVariantsScreen({Key? key}) : super(key: key);

  @override
  State<SavedVariantsScreen> createState() => _SavedVariantsScreenState();
}

class _SavedVariantsScreenState extends State<SavedVariantsScreen> {
  late final ScrollController _scrollController;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final blocState = BlocProvider.of<ProductsExploreBloc>(context).state;
      if (blocState is! SavedVariantsFetchLoading &&
          blocState is! SavedVariantsFetchFailure) {
        BlocProvider.of<ProductsExploreBloc>(context).add(
          SavedVariantsFetch(firstPage: false),
        );
      }
    }
  }

  loadInitialData() {
    BlocProvider.of<ProductsExploreBloc>(context).add(SavedVariantsFetch());
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Items'),
      ),
      body: BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
        builder: (context, state) {
          if (state is ProductsExploreFetchLoading && state.firstPage == true) {
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            List<VariantPreview> variants =
                BlocProvider.of<ProductsExploreBloc>(context).savedVariants;

            if (variants.isEmpty) {
              return const Center(
                child: Text('No saved items'),
              );
            } else {
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
                      return VariantPreviewWidget(variant: variants[index]);
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
          }
        },
      ),
    );
  }
}
