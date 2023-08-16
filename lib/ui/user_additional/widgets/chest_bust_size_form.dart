import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/auth/user_additional.dart';

import 'package:chicpic/ui/user_additional/widgets/bust_size_form.dart';
import 'package:chicpic/ui/user_additional/widgets/chest_size_form.dart';

class ChestBustSizeForm extends StatelessWidget {
  const ChestBustSizeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<UserAdditionalBloc>(context).gender ==
        UserAdditionalInterestedGender.female) {
      // return bust size form for females
      return const BustSizeForm();
    } else {
      // return chest size form for males
      return const ChestSizeForm();
    }
  }
}
