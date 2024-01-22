import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/services/snack_bar.dart';

import 'package:chicpic/ui/user_additional/widgets/user_additional_base_form.dart';
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

class UserAdditionalScreen extends StatelessWidget {
  const UserAdditionalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      child: BlocProvider.of<UserAdditionalBloc>(context).hasUserAdditional()
          ? const UserAdditionalEditForm()
          : const UserAdditionalCreateForm(),
    );
  }
}

class UserAdditionalHelpBtn extends StatelessWidget {
  const UserAdditionalHelpBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(AppRouter.sizeGuide);
      },
      icon: const Icon(Icons.help),
    );
  }
}

class UserAdditionalEditForm extends StatefulWidget {
  const UserAdditionalEditForm({Key? key}) : super(key: key);

  @override
  State<UserAdditionalEditForm> createState() => _UserAdditionalEditFormState();
}

class _UserAdditionalEditFormState extends State<UserAdditionalEditForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Body Size'),
        actions: const [UserAdditionalHelpBtn()],
      ),
      body: BlocListener<UserAdditionalBloc, UserAdditionalState>(
        listener: (context, state) {
          if (state is UserAdditionalSubmitSuccess) {
            showSnackBar(context, 'Your data submitted successfully',
                SnackBarStatus.success);
            // Re-render the widget
            setState(() {});

          } else if (state is UserAdditionalSubmitFailure) {
            showSnackBar(context, 'Error! Can not save your data.',
                SnackBarStatus.error);
          }
        },
        child: const SingleChildScrollView(
          child: Column(
            children: [
              UserAdditionalBaseEditForm(
                title: 'Birth Date',
                content: BirthDateForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Which gender are you mostly interested in?',
                content: GenderInterestedForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Weight',
                content: WeightForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Height',
                content: HeightForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Shoulder Size',
                content: ShoulderSizeForm(),
              ),
              ChestBustSizeEditForm(),
              UserAdditionalBaseEditForm(
                title: 'Waist Size',
                content: WaistSizeForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Height',
                content: HeightForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Which shirt fit do you prefer?',
                helper: '(Optional)',
                content: ShirtFitForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Hips Size',
                content: HipsSizeForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Inside Leg',
                content: InseamForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Which trouser fit do you prefer?',
                helper: '(Optional)',
                content: TrouserFitForm(),
              ),
              UserAdditionalBaseEditForm(
                title: 'Shoe Size',
                content: ShoeSizeForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserAdditionalCreateForm extends StatefulWidget {
  const UserAdditionalCreateForm({Key? key}) : super(key: key);

  @override
  State<UserAdditionalCreateForm> createState() =>
      _UserAdditionalCreateFormState();
}

class _UserAdditionalCreateFormState extends State<UserAdditionalCreateForm> {
  late final List<Widget> _userAdditionalFormWidgets;

  int _step = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserAdditionalBloc>(context).add(
      UserAdditionalInitialize(),
    );

    _userAdditionalFormWidgets = [
      UserAdditionalBaseCreateForm(
        title: 'Birth Date:',
        backBtnOnPressed: () {
          Navigator.of(context).pop();
        },
        content: const BirthDateForm(),
      ),
      const UserAdditionalBaseCreateForm(
        title: 'Mostly interested in:',
        content: GenderInterestedForm(),
      ),
      const UserAdditionalBaseCreateForm(
        title: 'What do you weigh?',
        content: WeightForm(),
      ),
      const UserAdditionalBaseCreateForm(
        title: 'How tall are you?',
        content: HeightForm(),
      ),
      const UserAdditionalBaseCreateForm(
        title: 'Shoulder Size:',
        content: ShoulderSizeForm(),
      ),
      const ChestBustSizeCreateForm(),
      const UserAdditionalBaseCreateForm(
        title: 'Waist Size:',
        content: WaistSizeForm(),
      ),
      const UserAdditionalBaseCreateForm(
        title: 'Which shirt fit do you prefer?',
        helper: '(Optional)',
        content: ShirtFitForm(),
      ),
      const UserAdditionalBaseCreateForm(
        title: 'Hips Size:',
        content: HipsSizeForm(),
      ),
      const UserAdditionalBaseCreateForm(
        title: 'Inside Leg:',
        content: InseamForm(),
      ),
      const UserAdditionalBaseCreateForm(
        title: 'Which trouser fit do you prefer?',
        helper: '(Optional)',
        content: TrouserFitForm(),
      ),
      UserAdditionalBaseCreateForm(
        title: 'Shoe Size:',
        content: const ShoeSizeForm(),
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Your Body Size'),
        actions: const [UserAdditionalHelpBtn()],
      ),
      body: BlocConsumer<UserAdditionalBloc, UserAdditionalState>(
        listener: (context, state) {
          if (state is UserAdditionalSubmitSuccess) {
            showSnackBar(context, 'Your data submitted successfully',
                SnackBarStatus.success);
            Navigator.of(context).pop();
          } else if (state is UserAdditionalSubmitFailure) {
            showSnackBar(context, 'Error! Can not save your data.',
                SnackBarStatus.error);
          }
        },
        builder: (context, state) {
          if (state is UserAdditionalStepChanged) {
            _step = state.step;
          }

          return SizedBox(
            height: deviceSize.height,
            width: deviceSize.width,
            child: _userAdditionalFormWidgets[_step],
          );
        },
      ),
    );
  }
}
