import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/statics/shared_preferences_keys.dart';
import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/product/category.dart';

import 'package:chicpic/ui/main/widgets/category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryGender _selectedGender = CategoryGender.women;

  List<Category> categories = [];

  Future<void> getCategories() async {
    List<Category> tmp = await APIService.getCategories(_selectedGender);
    setState(() {
      categories = tmp;
    });
  }

  Future<void> initializeData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _selectedGender = prefs.get(SharedPrefKeys.categoryGender) ==
              CategoryGender.men.abbreviation
          ? CategoryGender.men
          : CategoryGender.women;
    });

    await getCategories();
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.small),
          child: DropdownButton<CategoryGender>(
            underline: Container(),
            value: _selectedGender,
            onChanged: (CategoryGender? newValue) async {
              setState(() {
                _selectedGender = newValue!;
              });
              getCategories();
              final prefs = await SharedPreferences.getInstance();
              prefs.setString(
                SharedPrefKeys.categoryGender,
                _selectedGender.abbreviation,
              );
            },
            items: CategoryGender.values.map((gender) {
              return DropdownMenuItem<CategoryGender>(
                value: gender,
                child: Text(
                  gender.humanReadable.toUpperCase(),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.medium),
                child: Text(
                  '${_selectedGender.humanReadable} Categories',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...categories
                  .map((category) => CategoryItem(category: category))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
