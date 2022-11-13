import 'package:flutter/material.dart';

class Palette with ChangeNotifier {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xE6333333),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFF6FDFF), // dark=weiß - light=weiß
      onPrimary: Color(0xE6333333), // dark=grau - light=grau
      secondary: Color(0xFFF6FDFF), //dark=grau - light=light
      tertiary: Color(0xFFF6FDFF), //dark=weiß - light=grau
      surfaceVariant: Color(0xFFF6FDFF), //Unbenutzt
      surfaceTint: Color.fromARGB(230, 199, 195, 195), //Unbenutzt
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF6FDFF),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFF6FDFF), // dark=weiß - light=weiß
      onPrimary: Color(0xE6333333), // dark=grau - light=grau
      secondary: Color(0xE6333333), //dark=grau - light=light
      tertiary: Color(0xE6333333), // dark=weiß - light=grau
      surfaceVariant: Color(0xFFF6FDFF), //Unbenutzt
      surfaceTint: Color.fromARGB(230, 199, 195, 195), //Unbenutzt
    ),
  );
}
