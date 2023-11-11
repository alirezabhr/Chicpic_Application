import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chicpic/bloc/auth/auth_bloc.dart';

import 'package:chicpic/statics/insets.dart';

import 'package:chicpic/ui/auth/widgets/otp_input.dart';
import 'package:chicpic/ui/auth/widgets/submit_button.dart';

class OTPForm extends StatefulWidget {
  final String userEmail;

  const OTPForm({required this.userEmail, Key? key}) : super(key: key);

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  final int _otpLength = 6;

  final TextEditingController _fieldOne = TextEditingController();

  final TextEditingController _fieldTwo = TextEditingController();

  final TextEditingController _fieldThree = TextEditingController();

  final TextEditingController _fieldFour = TextEditingController();

  final TextEditingController _fieldFive = TextEditingController();

  final TextEditingController _fieldSix = TextEditingController();

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

  void setOTP(String otp) {
    _fieldOne.text = otp[0];
    _fieldTwo.text = otp[1];
    _fieldThree.text = otp[2];
    _fieldFour.text = otp[3];
    _fieldFive.text = otp[4];
    _fieldSix.text = otp[5];
    FocusScope.of(context).unfocus();
  }

  void pasteOTP() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final String text = clipboardData?.text ?? '';
    final String otpStr = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (otpStr.length == 6) {
      setOTP(otpStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Insets.xLarge),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OtpInput(
                controller: _fieldOne,
                autoFocus: true,
                onPaste: pasteOTP,
              ),
              OtpInput(controller: _fieldTwo, onPaste: pasteOTP),
              OtpInput(controller: _fieldThree, onPaste: pasteOTP),
              OtpInput(controller: _fieldFour, onPaste: pasteOTP),
              OtpInput(controller: _fieldFive, onPaste: pasteOTP),
              OtpInput(controller: _fieldSix, onPaste: pasteOTP),
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
                              content: Text('Please enter the code correctly.'),
                            ),
                          );
                        } else {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthCheckVerificationCode(
                              widget.userEmail,
                              otp,
                            ),
                          );
                        }
                      },
                label: 'Submit OTP',
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
                                AuthRequestVerificationCode(widget.userEmail),
                              );
                            },
                        ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
