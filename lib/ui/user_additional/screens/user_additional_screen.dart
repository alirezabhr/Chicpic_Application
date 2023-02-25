import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/ui/user_additional/widgets/birth_date_form.dart';
import 'package:chicpic/ui/user_additional/widgets/gender_interested_form.dart';
import 'package:chicpic/ui/user_additional/widgets/weight_form.dart';
import 'package:chicpic/ui/user_additional/widgets/height_form.dart';
import 'package:chicpic/ui/user_additional/widgets/bust_size_form.dart';
import 'package:chicpic/ui/user_additional/widgets/waist_size_form.dart';
import 'package:chicpic/ui/user_additional/widgets/shirt_fit_form.dart';
import 'package:chicpic/ui/user_additional/widgets/hip_size_form.dart';
import 'package:chicpic/ui/user_additional/widgets/leg_length_form.dart';
import 'package:chicpic/ui/user_additional/widgets/trouser_fit_form.dart';
import 'package:chicpic/ui/user_additional/widgets/shoe_size_form.dart';

class UserAdditionalScreen extends StatefulWidget {
  const UserAdditionalScreen({Key? key}) : super(key: key);

  @override
  State<UserAdditionalScreen> createState() => _UserAdditionalScreenState();
}

class _UserAdditionalScreenState extends State<UserAdditionalScreen> {
  late final List<Widget> _userAdditionalFormWidgets;

  int _step = 0;

  @override
  void initState() {
    super.initState();
    _userAdditionalFormWidgets = [
      BirthDateForm(
        backBtnOnPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const GenderInterestedForm(),
      const WeightForm(),
      const HeightForm(),
      const BustSizeForm(),
      const WaistSizeForm(),
      const ShirtFitForm(),
      const HipSizeForm(),
      const LegLengthForm(),
      const TrouserFitForm(),
      ShoeSizeForm(
        continueBtnOnPressed: () {
          BlocProvider.of<UserAdditionalBloc>(context).add(
            UserAdditionalSubmit(),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<UserAdditionalBloc, UserAdditionalState>(
        builder: (context, state) {
          if (state is UserAdditionalStepChanged) {
            _step = state.step;
          }

          return Container(
            height: deviceSize.height,
            width: deviceSize.width,
            color: Colors.blue[50],
            child: _userAdditionalFormWidgets[_step],
          );
        },
      ),
    );
  }
}
