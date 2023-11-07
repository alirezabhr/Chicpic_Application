import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:chicpic/statics/insets.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String appName = '';
  List<Map<String, dynamic>> data = [];
  final lastUpdate = '2023-11-07';

  setData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
    });

    data = [
      {
        'Introduction':
            '$appName ("we," "us," or "our") is committed to safeguarding your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, and protect your data when you use our mobile application ("$appName" or "the Application"). By accessing or using $appName, you consent to the practices described in this Privacy Policy.'
      },
      {
        'Information We Collect':
            'User-Provided Information: When you register an account with $appName, we may collect personal information such as your name, email address, and body size information, including but not limited to height, weight, bust size, hips size, waist size, and shoe size.'
                '\nAutomatically Collected Information: $appName may collect certain information automatically, including your device\'s unique identifier, IP address, operating system, and usage data related to the Application.'
      },
      {
        'Use of Information':
            'We use the information we collect for the following purposes:'
                '\nTo provide you with personalized clothing recommendations based on your body size and preferences.'
                '\nTo improve and optimize $appName\'s services and user experience.'
                '\nTo communicate with you regarding updates, offers, and promotions.'
      },
      {
        'Data Security':
            'We take the security of your data seriously. We employ reasonable measures to protect your personal information from unauthorized access, disclosure, alteration, and destruction. However, no method of transmission over the internet or electronic storage is entirely secure, and we cannot guarantee the absolute security of your data.'
      },
      {
        'Disclosure of Information':
            'We do not sell or rent your personal information to third parties. We may share your information with our trusted partners, service providers, and business affiliates for the sole purpose of providing you with our services. We may also disclose your information if required by law or to protect our rights, privacy, safety, or property.'
      },
      {
        'Your Choices':
            'You have the right to access, update, or delete your personal information stored with $appName. You can make these changes through your account settings or by contacting us at [contact email]. You can also opt-out of receiving promotional emails from us by following the instructions included in each email.'
      },
      {
        'Changes to this Privacy Policy':
            '$appName reserves the right to modify or revise this Privacy Policy at any time. Users will be notified of any changes, and it is their responsibility to review the updated Privacy Policy. Your continued use of $appName after any modifications indicates your acceptance of the new policy.'
      },
      {
        'Contact Information':
            'If you have any questions or concerns about this Privacy Policy or your data privacy, please contact us at founder@chicpic.app'
      }
    ];
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$appName Terms & Conditions')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Last Update: $lastUpdate'),
              const SizedBox(height: Insets.medium),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Insets.medium),
                      Text(
                        '${index + 1}- ${data[index].keys.first}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Insets.xSmall),
                      Text(data[index].values.first),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
