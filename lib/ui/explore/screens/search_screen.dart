import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/explore/products/products_explore_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/variant.dart';

import 'package:chicpic/ui/base_widgets/variant_preview_widget.dart';

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
        if (bloc.state is! VariantSearchLoading &&
            bloc.state is! VariantSearchFailure) {
          bloc.add(VariantSearch(_searchedText!, firstPage: false));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    // Clear searched text
    BlocProvider.of<ProductsExploreBloc>(context).clearSearchedVariants();
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
        VariantSearch(_searchedText!),
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
              padding: const EdgeInsets.only(top: Insets.medium),
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
                if (state is VariantSearchLoading && state.firstPage == true) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  List<VariantPreview> variants =
                      BlocProvider.of<ProductsExploreBloc>(context)
                          .searchedVariants;

                  return GridView.builder(
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
                  );
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
