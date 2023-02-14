import 'package:flutter/material.dart';

import 'package:chicpic/statics/insets.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.child,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 3 / 5,
      child: ElevatedButton(
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
        child: child ?? Text(label),
      ),
    );
  }
}
