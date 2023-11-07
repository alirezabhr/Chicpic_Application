import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:chicpic/statics/insets.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  String appName = '';
  List<Map<String, String>> data = [];
  final lastUpdate = '2023-11-07';

  setData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
    });

    data = [
      {
        'Acceptance of Terms':
            'By accessing or using the $appName mobile application ("$appName" or "the Application"), you agree to comply with and be bound by the following terms and conditions ("Terms"). If you do not agree to these Terms, please do not use $appName.'
      },
      {
        'Description of Service':
            '$appName is a mobile application that allows users to find the best-fitting clothing items from various online shops in Canada based on their provided body size information, including but not limited to height, weight, bust size, hips size, waist size, and shoe size. $appName provides clothing recommendations and links to external online shops where users can make purchases.'
      },
      {
        'User Registration':
            'To use the full range of services provided by $appName, users must register an account. When registering, you are required to provide accurate and complete information about your body size. You are solely responsible for maintaining the confidentiality of your account information.'
      },
      {
        'Privacy':
            'Your use of $appName is subject to our Privacy Policy. By using $appName, you consent to the collection and use of your personal information as described in the Privacy Policy.'
      },
      {
        'User Responsibilities':
            'You agree to use $appName in compliance with all applicable laws and regulations. You are solely responsible for the accuracy and completeness of the body size information you provide. $appName does not guarantee the availability or quality of products from third-party online shops.'
      },
      {
        'Intellectual Property':
            'All content, including but not limited to text, images, logos, and graphics on $appName, is protected by copyright and other intellectual property rights. Users may not reproduce, distribute, or create derivative works based on the content without prior written consent from $appName.'
      },
      {
        'Limitation of Liability':
            '$appName is provided on an "as is" and "as available" basis. We make no warranties or representations about the accuracy or completeness of the information provided through $appName. In no event shall $appName be liable for any direct, indirect, incidental, special, or consequential damages.'
      },
      {
        'Termination':
            '$appName may terminate your account or access to the Application at its discretion, with or without notice, if you violate these Terms or engage in any conduct that $appName deems to be in violation of its policies.'
      },
      {
        'Changes to Terms':
            '$appName reserves the right to modify or revise these Terms at any time. Users will be notified of any changes, and it is their responsibility to review the updated Terms. Your continued use of $appName after any modifications indicates your acceptance of the new Terms.'
      },
      {
        'Contact Information':
            'If you have any questions or concerns about these Terms, please contact us at founder@chicpic.app'
      },
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
                        '${index+1}- ${data[index].keys.first}',
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
