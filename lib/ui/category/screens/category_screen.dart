import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/bloc/category/category_bloc.dart';

import 'package:chicpic/models/product/category.dart';
import 'package:chicpic/models/product/product.dart';

import 'package:chicpic/ui/explore/widgets/product_item_dialog.dart';

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
      if (blocState is! CategoryProductsFetchLoading &&
          blocState is! CategoryProductsFetchFailure) {
        BlocProvider.of<CategoryBloc>(context).add(
          CategoryProductsFetch(category, firstPage: false),
        );
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
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryProductsFetchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<ProductPreview> products =
                BlocProvider.of<CategoryBloc>(context).products;

            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<CategoryBloc>(context).add(
                  CategoryProductsFetch(category, firstPage: true),
                );
              },
              child: GridView.builder(
                controller: _scrollController,
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
                          // TODO return Product Item Dialog
                          return const Card(
                            margin: EdgeInsets.all(50),
                            child: Text('Product Item Dialog'),
                          );
                          // return ProductItemDialog(
                          //   productId: products[index].id,
                          //   variantId: products[index].variants.,
                          // );
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
                        imageUrl: products[index].previewImage,
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
                },
              ),
            );
          }
        },
      ),
    );
  }
}
