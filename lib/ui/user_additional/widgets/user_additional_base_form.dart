import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/statics/insets.dart';

class UserAdditionalBaseCreateForm extends StatelessWidget {
  final String title;
  final String? helper;
  final Widget content;
  final String backBtnText;
  final String continueBtnText;
  final VoidCallback? continueBtnOnPressed;
  final VoidCallback? backBtnOnPressed;

  const UserAdditionalBaseCreateForm({
    required this.title,
    this.helper,
    required this.content,
    this.backBtnText = 'back',
    this.continueBtnText = 'Continue',
    this.continueBtnOnPressed,
    this.backBtnOnPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.small),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            helper != null ? Text(helper!) : Container(),
            const SizedBox(height: Insets.large),
            content,
            const SizedBox(height: Insets.xLarge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.small),
              child: BlocBuilder<UserAdditionalBloc, UserAdditionalState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      TextButton(
                        onPressed: state is UserAdditionalLoading
                            ? null
                            : backBtnOnPressed ??
                                () {
                                  BlocProvider.of<UserAdditionalBloc>(context)
                                      .add(
                                    UserAdditionalChangeStep(increasing: false),
                                  );
                                },
                        child: Text(
                          'back',
                          style: TextStyle(
                            fontSize: 18,
                            color: state is UserAdditionalLoading
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          if (state is UserAdditionalLoading) {
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            if (continueBtnOnPressed != null) {
                              continueBtnOnPressed!();
                            } else {
                              BlocProvider.of<UserAdditionalBloc>(context).add(
                                UserAdditionalChangeStep(increasing: true),
                              );
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Insets.xSmall,
                          ),
                          height: 50,
                          width: 100,
                          child: state is UserAdditionalLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const FittedBox(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Continue',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: Insets.xSmall),
                                      Icon(Icons.arrow_right_alt),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAdditionalBaseEditForm extends StatelessWidget {
  final String title;
  final String? helper;
  final Widget content;

  const UserAdditionalBaseEditForm({
    required this.title,
    this.helper,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(Insets.xSmall),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: Insets.medium),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: Insets.medium,
            vertical: Insets.xSmall,
          ),
          collapsedShape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(Insets.xSmall),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(Insets.xSmall),
          ),
          title: Text(title),
          subtitle: helper != null ? Text(helper!) : null,
          children: [
            const SizedBox(height: Insets.large),
            content,
            const SizedBox(height: Insets.xLarge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.small),
              child: BlocBuilder<UserAdditionalBloc, UserAdditionalState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (state is UserAdditionalLoading) {
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<UserAdditionalBloc>(context).add(
                          UserAdditionalSubmit(),
                        );
                      }
                    },
                    child: SizedBox(
                      height: 30,
                      width: 50,
                      child: state is UserAdditionalLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'Save',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: Insets.xSmall),
                                  Icon(Icons.edit, size: 18),
                                ],
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
