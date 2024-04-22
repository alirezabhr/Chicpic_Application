import 'package:flutter/material.dart';

const variantSmallGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3,
);

const variantLargeGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  childAspectRatio: 0.7,
);
