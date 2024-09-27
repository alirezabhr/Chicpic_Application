import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:chicpic/services/snack_bar.dart';

class TermsConditionsPrivacyPolicyLinks extends StatelessWidget {
  const TermsConditionsPrivacyPolicyLinks({Key? key}) : super(key: key);

  Future<void> _openWebsite(BuildContext context, String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      showSnackBar(context, 'Could not open the website', SnackBarStatus.error);
    }
  }

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
              ..onTap = () async {
                await _openWebsite(
                  context,
                  'https://chicpic.app/terms-conditions',
                );
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
              ..onTap = () async {
                await _openWebsite(
                  context,
                  'https://chicpic.app/privacy-policy',
                );
              },
          ),
        ],
      ),
    );
  }
}
