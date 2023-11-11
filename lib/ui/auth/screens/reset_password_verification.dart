import 'package:chicpic/app_router.dart';
import 'package:chicpic/bloc/auth/auth_bloc.dart';
import 'package:chicpic/statics/insets.dart';
import 'package:chicpic/ui/auth/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordVerificationScreen extends StatelessWidget {
  const ResetPasswordVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userEmail =
        ModalRoute.of(context)!.settings.arguments as String;

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
            Navigator.of(context).pushReplacementNamed(
              AppRouter.resetPassword,
              arguments: userEmail,
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
            Text('Code is sent to $userEmail'),
            OTPForm(userEmail: userEmail),
          ],
        ),
      ),
    );
  }
}
