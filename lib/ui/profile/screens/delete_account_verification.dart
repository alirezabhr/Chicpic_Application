import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/auth/widgets/otp_form.dart';

class DeleteAccountVerificationScreen extends StatelessWidget {
  const DeleteAccountVerificationScreen({Key? key}) : super(key: key);

  String obfuscateEmailAddress(String email) {
    final List<String> emailParts = email.split('@');
    final String firstPart = emailParts[0];
    final String secondPart = emailParts[1];

    final int firstPartLength = firstPart.length;
    final String firstPartObfuscated = firstPart.replaceRange(
      1,
      firstPartLength-1,
      '*' * 8,
    );

    return '$firstPartObfuscated@$secondPart';
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is VerificationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is VerificationSuccess) {
            // Delete the account
            BlocProvider.of<AuthBloc>(context).add(AuthDeleteUser());
            // pop every screen and push to login page
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.login,
              (Route<dynamic> route) => false,
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const SuccessfulDeleteDialog();
              },
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verification code',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: Insets.small),
            Text('Code is sent to ${obfuscateEmailAddress(email)}'),
            OTPForm(userEmail: email),
          ],
        ),
      ),
    );
  }
}

class SuccessfulDeleteDialog extends StatelessWidget {
  const SuccessfulDeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('You have deleted your account ☹️'),
      titlePadding: const EdgeInsets.all(Insets.small),
      contentPadding: const EdgeInsets.all(Insets.medium),
      children: [
        const Text('We are sad to see you go. Hope to see you soon!'),
        const SizedBox(height: Insets.small),
        const Text(
          'You can restore your account within 30 days by logging in again.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: Insets.large),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            side: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
          ),
          child: const Text(
            'I understand',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
