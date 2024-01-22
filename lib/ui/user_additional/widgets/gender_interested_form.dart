import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/auth/gender_choices.dart';

class GenderInterestedForm extends StatefulWidget {
  const GenderInterestedForm({Key? key}) : super(key: key);

  @override
  State<GenderInterestedForm> createState() => _GenderInterestedFormState();
}

class _GenderInterestedFormState extends State<GenderInterestedForm> {
  late GenderChoices _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = BlocProvider.of<UserAdditionalBloc>(context).gender;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.small),
      child: DropdownButtonFormField<GenderChoices>(
        decoration: const InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
        ),
        value: _selectedGender,
        onChanged: (GenderChoices? newValue) async {
          BlocProvider.of<UserAdditionalBloc>(context).gender = newValue!;
          BlocProvider.of<UserAdditionalBloc>(context).shoeSize.gender =
              newValue;
          setState(() {
            _selectedGender = newValue;
          });
        },
        items: GenderChoices.values.map((gender) {
          return DropdownMenuItem<GenderChoices>(
            value: gender,
            child: Text(
              "${gender.humanReadable}'s wear",
            ),
          );
        }).toList(),
      ),
    );
  }
}
