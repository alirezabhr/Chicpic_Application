import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/user_additional/user_additional_bloc.dart';

import 'package:chicpic/statics/insets.dart';

Widget createUserAdditionalForm({
  required BuildContext context,
  required String title,
  String? helper,
  required Widget content,
  VoidCallback? continueBtnOnPressed,
  VoidCallback? backBtnOnPressed,
}) {
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
          helper != null ? Text(helper) : Container(),
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
                            continueBtnOnPressed();
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
                            : FittedBox(
                              child: Row(
                                  children: const [
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
