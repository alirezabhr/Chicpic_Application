import 'package:chicpic/statics/insets.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final IconData? icon;
  final Color? color;

  const ProfileButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color baseColor =
        color != null ? color! : Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(
          left: Insets.medium,
          right: Insets.medium,
          top: Insets.medium,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.medium,
          vertical: Insets.xSmall,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: baseColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: Insets.xSmall),
                    child: Icon(
                      icon,
                      color: baseColor,
                      size: 16,
                    ),
                  )
                : Container(),
            Text(
              text,
              style: TextStyle(
                color: baseColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: Insets.medium),
          ],
        ),
      ),
    );
  }
}
