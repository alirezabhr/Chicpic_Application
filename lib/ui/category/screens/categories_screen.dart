import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/repositories/settings/settings_repository.dart';

import 'package:chicpic/bloc/settings/settings_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/models/auth/gender_choices.dart';
import 'package:chicpic/models/product/category.dart';

import 'package:chicpic/ui/base_widgets/filter_button.dart';
import 'package:chicpic/ui/category/widgets/category_item.dart';
import 'package:chicpic/ui/category/widgets/discounted_category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late final SettingsBloc settingsBloc;
  late final SettingsRepository settingsRepository;
  late GenderChoices _selectedGender;
  bool lockDropdown = false;

  List<Category> categories = [];

  Future<void> getCategories() async {
    List<Category> tmp = await APIService.getCategories(_selectedGender);
    setState(() {
      categories = tmp;
    });
  }

  @override
  void initState() {
    super.initState();

    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    settingsRepository = RepositoryProvider.of<SettingsRepository>(context);

    // lock drop down if personalized products are enabled
    lockDropdown = settingsRepository.showPersonalizedProducts;
    _selectedGender = settingsRepository.lastGenderCategory;

    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.small),
          child: BlocListener<SettingsBloc, SettingsState>(
            listener: (context, state) {
              if (state is SettingsLoaded) {
                setState(() {
                  lockDropdown = settingsRepository.showPersonalizedProducts;
                  _selectedGender = settingsRepository.lastGenderCategory;
                });
                getCategories();
              }
            },
            child: DropdownButton<GenderChoices>(
              underline: Container(),
              value: _selectedGender,
              onChanged: lockDropdown
                  ? null
                  : (GenderChoices? newValue) async {
                      if (_selectedGender != newValue) {
                        settingsBloc.add(UpdateGenderCategory(newValue!));
                      }
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
        actions: const [
          FilterButton(),
        ],
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
              DiscountedCategory(gender: _selectedGender),
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
