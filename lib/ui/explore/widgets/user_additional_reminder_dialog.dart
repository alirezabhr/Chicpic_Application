import 'package:flutter/material.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/statics/insets.dart';

class UserAdditionalReminderDialog extends StatelessWidget {
  const UserAdditionalReminderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Add Your Body Size 👚',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      titlePadding: const EdgeInsets.all(Insets.small),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.small),
          child: Text(
              'To suggest you the best size for you, we need to know your body size.'),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: Insets.xSmall,
            top: Insets.small,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed(
                      AppRouter.userAdditional,
                    ),
                child: const Text('Submit Now'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
