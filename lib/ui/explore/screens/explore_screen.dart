import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/explore/shops/shops_explore_bloc.dart';

import 'package:chicpic/ui/explore/widgets/shops_explore.dart';
import 'package:chicpic/ui/explore/widgets/products_explore.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShopsExploreBloc>(context).add(ShopsExploreFetch());

    return SafeArea(
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
    );
  }
}
