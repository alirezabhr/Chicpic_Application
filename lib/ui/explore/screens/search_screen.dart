import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/explore/widgets/product_item_dialog.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final ScrollController _scrollController;
  String? _searchedText;

  void _scrollListener() {
    // Not search yet
    if (_searchedText == null) {
      return;
    } else {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        final bloc = BlocProvider.of<ProductsExploreBloc>(context);
        if (bloc.state is! ProductSearchLoading &&
            bloc.state is! ProductSearchFailure) {
          bloc.add(ProductSearch(_searchedText!, firstPage: false));
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

  void submitSearch(String value) {
    if (value.isNotEmpty) {
      _searchedText = value;
      BlocProvider.of<ProductsExploreBloc>(context).add(
        ProductSearch(_searchedText!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.medium),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: Insets.small),
                      child: SearchBar(
                        onSubmitted: submitSearch,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<ProductsExploreBloc, ProductsExploreState>(
              builder: (context, state) {
                if (state is ProductSearchLoading) {
                  return const SizedBox(
                    height: 500,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ProductSearchSuccess) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.products.length,
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
                                productId: state.products[index].id,
                              );
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
                            imageUrl: state.products[index].previewImage,
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
                      );
                    },
                  );
                } else {
                  return Container();
                  // TODO: Recent searches
                  // return const RecentSearches();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RecentSearches extends StatelessWidget {
  const RecentSearches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> searchHistory = ['shirts', 'shorts', 'tops', 'jeans'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.small),
          child: Text(
            'Recent searches',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: Insets.small),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: Insets.small),
          itemCount: searchHistory.length,
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              onTap: () {
                // TODO : Search
              },
              title: Text(
                searchHistory[index],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(
                Icons.history,
                size: 20,
              ),
              minLeadingWidth: 20,
              trailing: IconButton(
                onPressed: () {
                  // TODO : Remove from recent searches
                },
                icon: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.black87,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String) onSubmitted;

  const SearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearchBarEmpty = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      autofocus: true,
      textInputAction: TextInputAction.search,
      onSubmitted: widget.onSubmitted,
      onChanged: (value) {
        setState(() {
          isSearchBarEmpty = value.isEmpty;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black45,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: Insets.xSmall,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).disabledColor,
          ),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.xSmall),
          child: Icon(
            Icons.search,
            size: 18,
            color: Colors.black45,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 35,
        ),
        suffixIcon: isSearchBarEmpty
            ? null
            : IconButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    isSearchBarEmpty = true;
                  });
                },
                icon: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.black45,
                ),
              ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 35,
        ),
      ),
    );
  }
}
