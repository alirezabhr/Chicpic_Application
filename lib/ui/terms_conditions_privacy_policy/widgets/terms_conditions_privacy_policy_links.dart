import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:chicpic/app_router.dart';

class TermsConditionsPrivacyPolicyLinks extends StatelessWidget {
  const TermsConditionsPrivacyPolicyLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "By signing up, you're agree to our ",
        style: const TextStyle(fontSize: 12, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: 'Terms & Conditions',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, AppRouter.termsConditions);
              },
          ),
          const TextSpan(
            text: ' and ',
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, AppRouter.privacyPolicy);
              },
          ),
        ],
      ),
    );
  }
}
