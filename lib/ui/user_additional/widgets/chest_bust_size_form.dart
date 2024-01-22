import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/models/auth/gender_choices.dart';

import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';
import 'package:chicpic/ui/user_additional/widgets/bust_size_form.dart';
import 'package:chicpic/ui/user_additional/widgets/chest_size_form.dart';

class ChestBustSizeCreateForm extends StatelessWidget {
  const ChestBustSizeCreateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<UserAdditionalBloc>(context).gender ==
        GenderChoices.women) {
      // return bust size form for females
      return const UserAdditionalBaseCreateForm(
        title: 'Bust Size:',
        content: BustSizeForm(),
      );
    } else {
      // return chest size form for males
      return const UserAdditionalBaseCreateForm(
        title: 'Chest Size:',
        content: ChestSizeForm(),
      );
    }
  }
}

class ChestBustSizeEditForm extends StatelessWidget {
  const ChestBustSizeEditForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<UserAdditionalBloc>(context).gender ==
        GenderChoices.women) {
      // return bust size form for females
      return const UserAdditionalBaseEditForm(
        title: 'Bust Size',
        content: BustSizeForm(),
      );
    } else {
      // return chest size form for males
      return const UserAdditionalBaseEditForm(
        title: 'Chest Size',
        content: ChestSizeForm(),
      );
    }
  }
}
