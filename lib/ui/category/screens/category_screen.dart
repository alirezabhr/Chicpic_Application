import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/category/category_bloc.dart';
import 'package:chicpic/bloc/settings/settings_bloc.dart';

import 'package:chicpic/models/product/category.dart';
import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/ui/base_widgets/filter_button.dart';
import 'package:chicpic/ui/base_widgets/variant_preview_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Category category;
  late final ScrollController _scrollController;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final blocState = BlocProvider.of<CategoryBloc>(context).state;
      if (blocState is! CategoryVariantsFetchLoading &&
          blocState is! CategoryVariantsFetchFailure) {
        // TODO: refactor
        if (category.id == 0) {
          // Discounted category
          const int discountPercentage = 50;
          BlocProvider.of<CategoryBloc>(context).add(
            DiscountedVariantsFetch(
              category,
              discountPercentage,
              category.gender,
              firstPage: false,
            ),
          );
        } else {
          // not offer(discounted) category
          BlocProvider.of<CategoryBloc>(context).add(
            CategoryVariantsFetch(category, firstPage: false),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        actions: const [
          FilterButton(iconColor: Colors.white),
        ],
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsShowPersonalizedProductsUpdated) {
            if (category.id == 0) {
              // Discounted category
              const int discountPercentage = 50;
              BlocProvider.of<CategoryBloc>(context).add(
                DiscountedVariantsFetch(
                  category,
                  discountPercentage,
                  category.gender,
                  firstPage: true,
                ),
              );
            } else {
              // not offer(discounted) category
              BlocProvider.of<CategoryBloc>(context).add(
                CategoryVariantsFetch(category, firstPage: true),
              );
            }
          }
        },
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryVariantsFetchLoading &&
                state.firstPage == true) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<VariantPreview> variants =
                  BlocProvider.of<CategoryBloc>(context).variants;

              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<CategoryBloc>(context).add(
                    CategoryVariantsFetch(category, firstPage: true),
                  );
                },
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: variants.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return VariantPreviewWidget(variant: variants[index]);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
