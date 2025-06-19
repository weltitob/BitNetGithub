import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  print('🟢 Test file loaded');
  
  test('Simple math test', () {
    print('🟦 Running simple math test');
    expect(2 + 2, equals(4));
    print('✅ Math test passed');
  });
  
  testWidgets('Simple widget test', (WidgetTester tester) async {
    print('🟦 Starting simple widget test');
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Text('Hello Test'),
        ),
      ),
    );
    print('✅ Widget pumped');
    
    expect(find.text('Hello Test'), findsOneWidget);
    print('✅ Text found');
  });
}