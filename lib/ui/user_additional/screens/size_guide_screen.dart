import 'package:flutter/material.dart';

import 'package:chicpic/statics/assets_helper.dart';
import 'package:chicpic/statics/insets.dart';

class SizeGuideScreen extends StatelessWidget {
  const SizeGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Size Guide')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How to measure your size:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: Insets.medium),
              Image.asset(AssetsHelper.womenSizeGuide),
              const SizedBox(height: Insets.medium),
              Image.asset(AssetsHelper.menSizeGuide),
            ],
          ),
        ),
      ),
    );
  }
}
