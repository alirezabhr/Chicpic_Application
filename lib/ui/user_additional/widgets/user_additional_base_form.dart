import 'package:flutter/material.dart';

import 'package:chicpic/statics/insets.dart';


Widget createUserAdditionalForm({
  required BuildContext context,
  required String title,
  String? helper,
  required Widget content,
  required VoidCallback continueBtnOnPressed,
  required VoidCallback backBtnOnPressed,
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
            child: Row(
              children: [
                TextButton(
                  onPressed: backBtnOnPressed,
                  child: const Text('back', style: TextStyle(fontSize: 18)),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      continueBtnOnPressed();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Insets.xSmall,
                    ),
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
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
