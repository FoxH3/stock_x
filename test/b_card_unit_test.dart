// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:stock_x/pagesTools/balance_card.dart';

void main() {
  test("Testen ob die Menge * Preis richtig berechnet wird", () {
    expect(
      calculate("2", "3"),
      equals('6.00'),
    );
  });
}
