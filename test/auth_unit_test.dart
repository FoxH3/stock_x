//Test die Auth Methoden.

import 'package:flutter_test/flutter_test.dart';
import 'package:stock_x/userAuth/flutterfire_auth.dart';

void main() {
  group("Auth. methoden Testen", () {
    test("Falsche Login Daten", () async {
      expect(
        await signIn("simon.odischo@hotmail.com", "test1234"),
        equals(true),
      );
    });
    test("Falsche Register Daten", () async {
      expectLater(
        await register("@hotmail.com", "test1234"),
        equals(false),
      );
    });

    test("Reset Password", () async {
      expectLater(
        await resetPassword("t@hotmail.com"),
        equals(false),
      );
    });
  });
}
