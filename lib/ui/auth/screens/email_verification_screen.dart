import 'package:flutter/material.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/ui/auth/widgets/otp_request_form.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Verify your account')),
        body: OTPRequestForm(
          title:'Your account is not verified.'
                  'Please enter your email address.',
          onSuccess: (String emailAddress) {
            Navigator.of(context).pushReplacementNamed(
              AppRouter.verificationAccount,
              arguments: emailAddress,
            );
          },
        ),
      ),
    );
  }
}
