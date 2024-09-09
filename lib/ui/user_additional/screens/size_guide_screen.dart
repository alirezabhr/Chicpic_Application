import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import 'package:chicpic/statics/assets_helper.dart';
import 'package:chicpic/statics/insets.dart';

class SizeGuideScreen extends StatelessWidget {
  const SizeGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Size Guide')),
      body: Padding(
        padding: const EdgeInsets.all(Insets.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How to measure your size:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: Insets.medium),
            Flexible(
              child: PinchZoom(
                maxScale: 3.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Image.asset(AssetsHelper.womenSizeGuide),
                ),
              ),
            ),
            const SizedBox(height: Insets.small),
            Flexible(
              child: PinchZoom(
                maxScale: 3.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Image.asset(AssetsHelper.menSizeGuide),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
