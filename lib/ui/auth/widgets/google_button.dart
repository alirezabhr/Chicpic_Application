import 'package:flutter/material.dart';

import 'package:chicpic/statics/assets_helper.dart';
import 'package:chicpic/statics/insets.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, required this.label, this.onPressed})
      : super(key: key);

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 3 / 5,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: Insets.medium),
          ),
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsHelper.googleIcon, scale: 2),
              const SizedBox(width: Insets.xSmall),
              Text(
                label,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
