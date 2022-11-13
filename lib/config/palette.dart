import 'package:flutter/material.dart';

class Palette with ChangeNotifier {
  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(brightness: Brightness.dark),
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(brightness: Brightness.light),
  );
}
