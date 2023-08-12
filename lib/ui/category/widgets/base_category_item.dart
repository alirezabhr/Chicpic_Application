import 'package:chicpic/statics/insets.dart';
import 'package:flutter/material.dart';

class BaseCategoryItem extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final String? description;
  final Widget? trailing;
  late final Color? backgroundColor;
  late final Gradient? backgroundGradient;
  late final TextStyle titleStyle;
  late final TextStyle descriptionStyle;

  BaseCategoryItem({
    super.key,
    required this.title,
    required this.onTap,
    this.trailing,
    this.description,
    this.backgroundGradient,
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
  }) {
    this.backgroundColor = backgroundColor ?? Colors.white;
    this.titleStyle = titleStyle ?? _defaultTitleStyle;
    this.descriptionStyle = descriptionStyle ?? _defaultDescriptionStyle;
  }

  final double _containerHeight = 80;
  final double _borderRadius = 20;

  final TextStyle _defaultTitleStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  final TextStyle _defaultDescriptionStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: _containerHeight,
        margin: const EdgeInsets.symmetric(vertical: Insets.xSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          color: backgroundColor,
          gradient: backgroundGradient,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Use flexible to avoid overflow text
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: Insets.medium),
                child: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: titleStyle,
                      ),
                      description != null
                          ? Text(
                        description!,
                        style: descriptionStyle,
                      )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _containerHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  topLeft: Radius.zero,
                  bottomLeft: Radius.zero,
                ),
                child: trailing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

