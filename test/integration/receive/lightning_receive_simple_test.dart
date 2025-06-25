import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Simple Lightning screen test', (WidgetTester tester) async {
    print('🟦 Building simple Lightning screen...');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Receive Lightning')),
          body: Column(
            children: [
              Text('Amount (sats)'),
              TextField(
                key: Key('amount_field'),
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Create Invoice'),
              ),
            ],
          ),
        ),
      ),
    );

    print('✅ Widgets built successfully');

    // Simple checks
    expect(find.text('Receive Lightning'), findsOneWidget);
    expect(find.text('Amount (sats)'), findsOneWidget);
    expect(find.text('Create Invoice'), findsOneWidget);

    print('✅ All widgets found');

    // Try entering text
    await tester.enterText(find.byKey(Key('amount_field')), '1000');
    await tester.pump();

    print('✅ Text entered successfully');
  });
}
