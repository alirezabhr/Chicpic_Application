import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/explore/shops/shops_explore_bloc.dart';
import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/ui/explore/widgets/shops_explore.dart';
import 'package:chicpic/ui/explore/widgets/products_explore.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final ScrollController _scrollController;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final blocState = BlocProvider.of<ProductsExploreBloc>(context).state;
      if (blocState is! ProductsExploreFetchLoading &&
          blocState is! ProductsExploreFetchFailure) {
        BlocProvider.of<ProductsExploreBloc>(context).add(
          ProductsExploreFetch(firstPage: false),
        );
      }
    }
  }

  loadInitialData() {
    BlocProvider.of<ShopsExploreBloc>(context).add(ShopsExploreFetch());
    BlocProvider.of<ProductsExploreBloc>(context).add(ProductsExploreFetch());
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
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          loadInitialData();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.small),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRouter.search);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.search, size: 18, color: Colors.black45),
                      SizedBox(width: Insets.xSmall),
                      Text('Search', style: TextStyle(color: Colors.black45)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Insets.medium),
              const ShopsExplore(),
              const SizedBox(height: Insets.medium),
              const ProductsExplore(),
            ],
          ),
        ),
      ),
    );
  }
}
