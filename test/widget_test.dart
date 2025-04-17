import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:b2b_jewerlry_catalog/main.dart'; // ✅ Ensure this path is correct!

void main() {
  testWidgets('Jewelry catalog grid renders with products', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(JewelryCatalogApp());

    // Allow any animations or async widgets to settle
    await tester.pumpAndSettle();

    // App title should appear
    expect(find.text('Jewelry Catalog'), findsOneWidget);

    // GridView for product listings should be found
    expect(find.byType(GridView), findsOneWidget);

    // Check if any product tile contains the word "Ring", "Necklace", or "Gold"
    final possibleKeywords = ['Ring', 'Necklace', 'Gold', 'Earring', 'Bracelet'];
    bool found = false;

    for (var keyword in possibleKeywords) {
      if (tester.any(find.textContaining(keyword))) {
        found = true;
        break;
      }
    }

    expect(found, isTrue, reason: 'Expected at least one product to contain a keyword like Ring or Necklace.');
  });
}
