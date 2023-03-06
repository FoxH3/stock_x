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
      surfaceTint: Color.fromARGB(230, 247, 246,
          246), //Background für Aktien / Gold / Silber Detail Container
    ),
    textTheme: const TextTheme(
      //Platzhalter für das baldige Stylen der Texte
      headline5: TextStyle(
        color: Color(0xFFF6FDFF),
      ), // Überschrift (appbar)
      subtitle1: TextStyle(
        color: Color(0xFFF6FDFF),
      ), // Switch Labeltext
      subtitle2: TextStyle(
        color: Color(0xFFF6FDFF),
      ), // Sliding Panel
      labelMedium: TextStyle(
        color: Color(0xFFF6FDFF),
      ), // Sliding Panel
      bodyText1: TextStyle(
        color: Color(0xFFF6FDFF),
      ), // Haupttext
      bodyText2: TextStyle(
        color: Colors.black,
      ), // Haupttext2 (Light = Weiß - Dark = Black)
      caption: TextStyle(
        color: Colors.black,
      ),
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
      surfaceTint: Color.fromARGB(230, 247, 246, 246), //Unbenutzt
    ),
    textTheme: const TextTheme(
      //Platzhalter für das baldige Stylen der Texte
      headline5: TextStyle(
        color: Color(0xE6333333),
      ), // Überschrift (appbar)
      subtitle1: TextStyle(
        color: Color(0xE6333333),
      ), // Switch Labeltext
      subtitle2: TextStyle(
        color: Color(0xFFF6FDFF),
      ), // Sliding Panel
      labelMedium: TextStyle(
        color: Color(0xFFF6FDFF),
      ), // Sliding Panel
      bodyText1: TextStyle(
        color: Colors.black,
      ), // Haupttext (Light = Black - Dark = Weiß)
      bodyText2: TextStyle(
        color: Color(0xFFF6FDFF),
      ), // Haupttext2 (Light = Weiß - Dark = Black)
      caption: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
