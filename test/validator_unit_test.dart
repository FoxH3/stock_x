//Validator test

import 'package:flutter_test/flutter_test.dart';
import 'package:stock_x/userAuth/validator.dart';

void main() {
  group("Validator testen", () {
    test('zu Kurze Passwort', () async {
      expect(
        Validator.validatePass("pass", "context"),
        "        sechsStellige Passwort eingeben",
      );
    });
    test('Keine Passwort', () async {
      expect(
        Validator.validatePass("", "context"),
        '        Passwort eingeben',
      );
    });
    test('Richtige Passwort', () async {
      expect(
        Validator.validatePass("semon934", "context"),
        null,
      );
    });
  });
}
