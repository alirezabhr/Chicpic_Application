import 'package:flutter/material.dart';

abstract class CustomTheme {
  static const MaterialColor primaryColor = MaterialColor(
    0xFF505976,
    {
      50: Color.fromRGBO(80, 89, 118, .1),
      100: Color.fromRGBO(80, 89, 118, .2),
      200: Color.fromRGBO(80, 89, 118, .3),
      300: Color.fromRGBO(80, 89, 118, .4),
      400: Color.fromRGBO(80, 89, 118, .5),
      500: Color.fromRGBO(80, 89, 118, .6),
      600: Color.fromRGBO(80, 89, 118, .7),
      700: Color.fromRGBO(80, 89, 118, .8),
      800: Color.fromRGBO(80, 89, 118, .9),
      900: Color.fromRGBO(80, 89, 118, 1),
    },
  );

  static const MaterialColor disabledColor = MaterialColor(0xFFBDBDBD, {});
}
