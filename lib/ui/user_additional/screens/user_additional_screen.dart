import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/user_additional/widgets/birth_date_form.dart';
import 'package:chicpic/ui/user_additional/widgets/gender_interested_form.dart';
import 'package:chicpic/ui/user_additional/widgets/weight_form.dart';
import 'package:chicpic/ui/user_additional/widgets/height_form.dart';
import 'package:chicpic/ui/user_additional/widgets/shoulder_size_form.dart';
import 'package:chicpic/ui/user_additional/widgets/chest_bust_size_form.dart';
import 'package:chicpic/ui/user_additional/widgets/waist_size_form.dart';
import 'package:chicpic/ui/user_additional/widgets/shirt_fit_form.dart';
import 'package:chicpic/ui/user_additional/widgets/hips_size_form.dart';
import 'package:chicpic/ui/user_additional/widgets/inseam_form.dart';
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
    BlocProvider.of<UserAdditionalBloc>(context).add(
      UserAdditionalInitialize(),
    );

    _userAdditionalFormWidgets = [
      BirthDateForm(
        backBtnOnPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const GenderInterestedForm(),
      const WeightForm(),
      const HeightForm(),
      const ShoulderSizeForm(),
      const ChestBustSizeForm(),
      const WaistSizeForm(),
      const ShirtFitForm(),
      const HipsSizeForm(),
      const InseamForm(),
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

  void showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        padding: const EdgeInsets.all(Insets.small),
        margin: const EdgeInsets.all(Insets.medium),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Your Body Size'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.sizeGuide);
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      body: BlocConsumer<UserAdditionalBloc, UserAdditionalState>(
        listener: (context, state) {
          if (state is UserAdditionalSubmitSuccess) {
            showSnackBar('Your data submitted successfully', Colors.green);
            Navigator.of(context).pop();
          } else if (state is UserAdditionalSubmitFailure) {
            showSnackBar('Error! Can not save your data.', Colors.red);
          }
        },
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
