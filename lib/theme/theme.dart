import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 253, 181, 56);
Color reallyLightGrey = Colors.grey.withAlpha(25);
ThemeData appThemeLight =
    ThemeData.light().copyWith(primaryColor: primaryColor);
ThemeData appThemeDark = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: Colors.white,
        // secondary: Colors.white,
      ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: primaryColor,
    selectionColor: primaryColor,
    selectionHandleColor: primaryColor,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(primaryColor),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(primaryColor),
    trackColor: MaterialStateProperty.all(primaryColor.withOpacity(0.5)),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(primaryColor),
  ),
);
