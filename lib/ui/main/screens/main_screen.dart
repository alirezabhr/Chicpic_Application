import 'package:flutter/material.dart';

import 'package:chicpic/ui/category/screens/categories_screen.dart';
import 'package:chicpic/ui/explore/screens/explore_screen.dart';
import 'package:chicpic/ui/main/screens/notifications_screen.dart';
import 'package:chicpic/ui/main/screens/profile_screen.dart';
import 'package:chicpic/ui/main/widgets/image_picker_bottom_sheet.dart';

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
      'icon': const Icon(Icons.camera_enhance),
      'label': 'Upload Image',
    },
    {
      'icon': const Icon(Icons.notifications_none_outlined),
      'page': const NotificationsScreen(),
      'label': 'Notifications',
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
          } else {
            showModalBottomSheet(
              context: context,
              builder: (context) => const ImagePickerBottomSheet(),
            );
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
