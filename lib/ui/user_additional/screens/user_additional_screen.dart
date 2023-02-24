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

class UserAdditionalScreen extends StatefulWidget {
  const UserAdditionalScreen({Key? key}) : super(key: key);

  @override
  State<UserAdditionalScreen> createState() => _UserAdditionalScreenState();
}

class _UserAdditionalScreenState extends State<UserAdditionalScreen> {
  late final List<Widget> _userAdditionalFormWidgets;

  int _step = 0;

  void decreaseStep() {
    if (_step == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _step -= 1;
      });
    }
  }

  void increaseStep() {
    if (_step == _userAdditionalFormWidgets.length - 1) {
      BlocProvider.of<UserAdditionalBloc>(context).add(UserAdditionalSubmit());
    } else {
      setState(() {
        _step += 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _userAdditionalFormWidgets = [
      BirthDateForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
      GenderInterestedForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
      WeightForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
      HeightForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
      BustSizeForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
      WaistSizeForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
      ShirtFitForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
      HipSizeForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
      LegLengthForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
      TrouserFitForm(
        backBtnOnPressed: decreaseStep,
        continueBtnOnPressed: increaseStep,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<UserAdditionalBloc, UserAdditionalState>(
        listener: (context, state) {},
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          color: Colors.blue[50],
          child: _userAdditionalFormWidgets[_step],
        ),
      ),
    );
  }
}
