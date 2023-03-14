//App passwort test

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_x/main.dart';

void main() {
  group("App Passwort methoden test", () {
    MyHomePageState myHomePageState;
    myHomePageState = MyHomePageState();
    WidgetsFlutterBinding.ensureInitialized();
    test("App Passwort Aktiv?", () async* {
      expectLater(
        await myHomePageState.getAktivValues(),
        equals(false),
      );
    });
    test("was ist AppPasswort?", () async* {
      expectLater(
        await myHomePageState.getPassowrdState(),
        equals(""),
      );
    });
  });
}
