import 'package:chicpic/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/base_widgets/custom_text_icon_button.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: Column(
        children: [
          CustomTextIconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DeleteAccountDialog();
                },
              );
            },
            color: Colors.red,
            text: 'Delete Account',
            icon: Icons.delete_outline,
          )
        ],
      ),
    );
  }
}

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return SimpleDialog(
      title: const Row(
        children: [
          Icon(Icons.warning_rounded, color: Colors.red),
          SizedBox(width: Insets.small),
          Text(
            'Delete your account?',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      titlePadding: const EdgeInsets.all(Insets.small),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.small),
          child: Text(
              'If you delete your account, all your data will be lost. You can recover your account within 30 days.\n\nAre you sure you want to delete your account?'),
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
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is VerificationFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  } else if (state is VerificationSent) {
                    Navigator.of(context).pushReplacementNamed(
                        AppRouter.deleteAccountVerification,
                        arguments: authBloc.userEmail!,
                    );
                  }
                },
                builder: (context, state) {
                  return TextButton(
                    onPressed: state is VerificationLoading
                        ? null
                        : () {
                      authBloc.add(
                        AuthRequestVerificationCode(authBloc.userEmail!),
                      );
                    },
                    child: const Text(
                      'Delete My Account',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
