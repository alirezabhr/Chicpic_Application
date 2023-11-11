import 'package:flutter/material.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/ui/auth/widgets/otp_request_form.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Forget Password')),
        body: OTPRequestForm(
          title: 'Please enter your email address.',
          onSuccess: (String emailAddress) {
            Navigator.of(context).pushReplacementNamed(
              AppRouter.resetPasswordVerification,
              arguments: emailAddress,
            );
          },
        ),
      ),
    );
  }
}
