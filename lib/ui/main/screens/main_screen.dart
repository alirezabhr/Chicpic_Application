import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chicpic/ui/category/screens/categories_screen.dart';
import 'package:chicpic/ui/explore/screens/explore_screen.dart';
import 'package:chicpic/ui/profile/screens/saved_variants_screen.dart';
import 'package:chicpic/ui/profile/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  final List<Map<String, dynamic>> _mainPages = [
    {
      'icon': const Icon(Icons.storefront),
      'page': const CategoriesScreen(),
      'label': 'Home',
    },
    {
      'icon': const Icon(Icons.search),
      'page': const ExploreScreen(),
      'label': 'Explore',
    },
    {
      'icon': const Icon(FontAwesomeIcons.bookmark, size: 18),
      'page': const SavedVariantsScreen(),
      'label': 'Saved Items',
    },
    {
      'icon': const Icon(Icons.person_outline),
      'page': const ProfileScreen(),
      'label': 'Profile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _mainPages[_pageIndex]['page'],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        selectedFontSize: 12,
        currentIndex: _pageIndex,
        onTap: (index) {
          if (_mainPages[index].containsKey('page')) {
            setState(() {
              _pageIndex = index;
            });
          }
        },
        items: _mainPages
            .map((e) => BottomNavigationBarItem(
                  icon: e['icon'],
                  label: e['label'],
                ))
            .toList(),
      ),
    );
  }
}
