import 'package:flutter_test/flutter_test.dart';
import 'package:BitNet/main.dart';
import 'package:BitNet/pages/routetrees/widgettree.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

//Test for the main
void main() {
  group('MyApp', () {
    testWidgets('Renders the app correctly', (WidgetTester tester) async {
      // Create a mock SharedPreferences instance
      SharedPreferences.setMockInitialValues({});
      final sharedPreferences = await SharedPreferences.getInstance();

      // Build the app and trigger a frame
      await tester.pumpWidget(MyApp());

      // Verify that the app title is correct
      expect(find.text('Nexus Wallet'), findsOneWidget);

      // Verify that the WidgetTree page is displayed
      expect(find.byType(WidgetTree), findsOneWidget);

      // Verify that the SharedPreferences instance is initialized
      expect(sharedPreferences, isNotNull);
    });
  });
}

