// Testsff für die verschlüsselung

import 'package:flutter_test/flutter_test.dart';
import 'package:stock_x/services/provider/encryption.dart';

void main() {
  group("Encryption. methoden Testen Key= NBfKocWKr8mY", () {
    test("KeyHash test", () async {
      expect(
        Encryption.keyHash("NBfKocWKr8mY"),
        equals(
            '\$5\$Gq8RQnsDRFtrjyST\$9UB94bZyhTr/KTxGT3yi3EZHvemJq5EnXO0dtSxz.Y3'),
      );
    });
    test("Prüfung on KeyHash mit Key übereinstimmt", () async {
      expectLater(
        Encryption.keyHashTest("NBfKocWKr8mY",
            "\$5\$Gq8RQnsDRFtrjyST\$9UB94bZyhTr/KTxGT3yi3EZHvemJq5EnXO0dtSxz.Y3"),
        equals(true),
      );
    });

    test("Data Verschlüsslen test Data= SimonTest", () async {
      expectLater(
        Encryption.dataCrypt("SimonTest", "NBfKocWKr8mY"),
        equals('T+z+/cCwlO6yLknd5mXSoA=='),
      );
    });
    test("Data entschlüsslen test DataHash= T+z+/cCwlO6yLknd5mXSoA==",
        () async {
      expectLater(
        Encryption.dataDeCrypt("NBfKocWKr8mY", "T+z+/cCwlO6yLknd5mXSoA=="),
        equals('SimonTest'),
      );
    });
  });
}
