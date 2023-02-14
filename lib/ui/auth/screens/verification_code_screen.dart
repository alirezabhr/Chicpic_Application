import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/app_router.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/auth/widgets/submit_button.dart';
import 'package:chicpic/ui/auth/widgets/otp_input.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final int _otpLength = 6;

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  late final AuthBloc authBloc;

  String get otp =>
      _fieldOne.text +
      _fieldTwo.text +
      _fieldThree.text +
      _fieldFour.text +
      _fieldFive.text +
      _fieldSix.text;

  bool get isValidOTP {
    return (otp.length == _otpLength) && (int.tryParse(otp) != null);
  }

  void _routeTo(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final String userEmail = ModalRoute.of(context)!.settings.arguments as String;

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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Your account verified.'),
                backgroundColor: Colors.green,
              ),
            );
            bool hasUserData = authBloc.hasUserData();
            if (hasUserData) {
              await authBloc.verifyUser();
              _routeTo(AppRouter.main);
            } else {
              _routeTo(AppRouter.login);
            }
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.xLarge),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtpInput(controller: _fieldOne, autoFocus: true),
                  OtpInput(controller: _fieldTwo),
                  OtpInput(controller: _fieldThree),
                  OtpInput(controller: _fieldFour),
                  OtpInput(controller: _fieldFive),
                  OtpInput(controller: _fieldSix),
                ],
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return SubmitButton(
                    onPressed: state is VerificationLoading
                        ? null
                        : () {
                            if (!isValidOTP) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please enter the code correctly.'),
                                ),
                              );
                            } else {
                              BlocProvider.of<AuthBloc>(context).add(
                                AuthCheckVerificationCode(
                                  userEmail,
                                  otp,
                                ),
                              );
                            }
                          },
                    label: 'Verify Account',
                    child: state is VerificationLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : null);
              },
            ),
            const SizedBox(height: Insets.medium),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return RichText(
                  text: TextSpan(
                    text: "Didn't receive code? ",
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    children: [
                      state is VerificationLoading
                          ? const TextSpan(
                              text: 'Request Again',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                              ),
                            )
                          : TextSpan(
                              text: 'Request Again',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    AuthRequestVerificationCode(
                                      userEmail,
                                    ),
                                  );
                                },
                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
