import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/statics/shared_preferences_keys.dart';
import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/auth/gender_choices.dart';
import 'package:chicpic/models/product/category.dart';

import 'package:chicpic/ui/category/widgets/category_item.dart';
import 'package:chicpic/ui/category/widgets/discounted_category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  GenderChoices _selectedGender = GenderChoices.women;

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
              GenderChoices.men.abbreviation
          ? GenderChoices.men
          : GenderChoices.women;
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
          child: DropdownButton<GenderChoices>(
            underline: Container(),
            value: _selectedGender,
            onChanged: (GenderChoices? newValue) async {
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
            items: GenderChoices.values.map((gender) {
              return DropdownMenuItem<GenderChoices>(
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
              const DiscountedCategory(),
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
