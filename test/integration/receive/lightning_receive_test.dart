import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

// Mock Lightning receive screen for testing
class MockLightningReceiveScreen extends StatefulWidget {
  const MockLightningReceiveScreen({Key? key}) : super(key: key);
  
  @override
  _MockLightningReceiveScreenState createState() => _MockLightningReceiveScreenState();
}

class _MockLightningReceiveScreenState extends State<MockLightningReceiveScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  String? generatedInvoice;
  bool isLoading = false;
  String? copyMessage;
  String? errorMessage;
  
  void _createLightningInvoice() async {
    // Clear previous messages
    setState(() {
      errorMessage = null;
      copyMessage = null;
    });
    
    // Validate amount
    if (amountController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter an amount';
      });
      return;
    }
    
    final amount = int.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      setState(() {
        errorMessage = 'Please enter a valid amount';
      });
      return;
    }
    
    setState(() {
      isLoading = true;
    });
    
    // Simulate API call to create invoice
    await Future.delayed(Duration(seconds: 1));
    
    // Generate mock invoice based on amount
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final mockInvoice = 'lnbc${amount}u${timestamp}pp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqdpl2pkx2ctnv5sxxmmwwd5kgetjypeh2ursdae8g6twvus8g6rfwvs8qun0dfjkxaq8rkx3yf5tcsyz3d73gafnh3cax9rn449d9p5uxz9ezhhypd0elx87sjle52dl8xet2zhp5760q';
    
    setState(() {
      generatedInvoice = mockInvoice;
      isLoading = false;
    });
  }
  
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    setState(() {
      copyMessage = 'Invoice copied to clipboard';
    });
    
    // Clear message after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          copyMessage = null;
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receive Lightning'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Lightning indicator
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bolt, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    'Lightning Invoice',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            
            // Amount input
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount (sats)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_bitcoin),
                errorText: errorMessage,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            SizedBox(height: 16),
            
            // Memo input
            TextField(
              controller: memoController,
              decoration: InputDecoration(
                labelText: 'Memo (optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
                helperText: 'Add a description for this payment',
              ),
              maxLines: 2,
            ),
            SizedBox(height: 24),
            
            // Create invoice button
            ElevatedButton(
              onPressed: isLoading ? null : _createLightningInvoice,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading 
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Create Invoice',
                    style: TextStyle(fontSize: 16),
                  ),
            ),
            
            // Generated invoice display
            if (generatedInvoice != null) ...[
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.qr_code, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Lightning Invoice',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    SelectableText(
                      generatedInvoice!,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _copyToClipboard(generatedInvoice!),
                          icon: Icon(Icons.copy, size: 18),
                          label: Text('Copy'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade700,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // In real app, this would show QR code
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('QR Code would be shown here')),
                            );
                          },
                          icon: Icon(Icons.qr_code_2, size: 18),
                          label: Text('QR Code'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            
            // Success message
            if (copyMessage != null) ...[
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Text(
                      copyMessage!,
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    amountController.dispose();
    memoController.dispose();
    super.dispose();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUp(() {
    // Clear clipboard before each test
    Clipboard.setData(ClipboardData(text: ''));
  });

  group('Lightning Receive Integration Tests', () {
    testWidgets('Complete Lightning invoice creation flow', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MockLightningReceiveScreen(),
        ),
      );
      
      // Verify initial state
      expect(find.text('Receive Lightning'), findsOneWidget);
      expect(find.text('Lightning Invoice'), findsOneWidget);
      expect(find.text('Amount (sats)'), findsOneWidget);
      expect(find.text('Memo (optional)'), findsOneWidget);
      expect(find.text('Create Invoice'), findsOneWidget);
      
      // Enter valid amount
      await tester.enterText(find.byType(TextField).first, '10000');
      
      // Enter memo
      await tester.enterText(find.byType(TextField).last, 'Coffee payment');
      await tester.pump();
      
      // Create invoice
      await tester.tap(find.text('Create Invoice'));
      await tester.pump();
      
      // Verify loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Wait for invoice generation
      await tester.pumpAndSettle();
      
      // Verify invoice is displayed
      expect(find.textContaining('lnbc10000u'), findsOneWidget);
      expect(find.text('Lightning Invoice'), findsNWidgets(2)); // Header and in container
      expect(find.text('Copy'), findsOneWidget);
      expect(find.text('QR Code'), findsOneWidget);
      
      // Copy invoice
      await tester.tap(find.text('Copy'));
      await tester.pump();
      
      // Verify success message
      expect(find.text('Invoice copied to clipboard'), findsOneWidget);
      
      // Verify clipboard content
      final clipboardData = await Clipboard.getData('text/plain');
      expect(clipboardData?.text, contains('lnbc10000u'));
      expect(clipboardData?.text, contains('pp5qqqsyqcyq5'));
    });
    
    testWidgets('Validate amount input errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MockLightningReceiveScreen(),
        ),
      );
      
      // Test empty amount
      await tester.tap(find.text('Create Invoice'));
      await tester.pump();
      
      expect(find.text('Please enter an amount'), findsOneWidget);
      
      // Test invalid amount (non-numeric)
      await tester.enterText(find.byType(TextField).first, 'abc');
      await tester.pump();
      
      // Should not accept non-numeric input due to inputFormatters
      final textField = tester.widget<TextField>(find.byType(TextField).first);
      expect(textField.controller?.text, isEmpty);
      
      // Test zero amount
      await tester.enterText(find.byType(TextField).first, '0');
      await tester.tap(find.text('Create Invoice'));
      await tester.pump();
      
      expect(find.text('Please enter a valid amount'), findsOneWidget);
    });
    
    testWidgets('Create invoice without memo', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MockLightningReceiveScreen(),
        ),
      );
      
      // Enter only amount, no memo
      await tester.enterText(find.byType(TextField).first, '5000');
      
      // Create invoice
      await tester.tap(find.text('Create Invoice'));
      await tester.pumpAndSettle();
      
      // Verify invoice is created successfully
      expect(find.textContaining('lnbc5000u'), findsOneWidget);
    });
    
    testWidgets('Copy message disappears after timeout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MockLightningReceiveScreen(),
        ),
      );
      
      // Create invoice
      await tester.enterText(find.byType(TextField).first, '1000');
      await tester.tap(find.text('Create Invoice'));
      await tester.pumpAndSettle();
      
      // Copy invoice
      await tester.tap(find.text('Copy'));
      await tester.pump();
      
      // Verify message appears
      expect(find.text('Invoice copied to clipboard'), findsOneWidget);
      
      // Wait for message to disappear
      await tester.pump(Duration(seconds: 2));
      await tester.pump();
      
      // Verify message is gone
      expect(find.text('Invoice copied to clipboard'), findsNothing);
    });
    
    testWidgets('QR code button shows placeholder message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MockLightningReceiveScreen(),
        ),
      );
      
      // Create invoice
      await tester.enterText(find.byType(TextField).first, '1000');
      await tester.tap(find.text('Create Invoice'));
      await tester.pumpAndSettle();
      
      // Tap QR code button
      await tester.tap(find.text('QR Code'));
      await tester.pump();
      
      // Verify snackbar message
      expect(find.text('QR Code would be shown here'), findsOneWidget);
    });
  });
  
  group('Lightning Invoice Validation', () {
    test('Validate Lightning invoice format', () {
      // Valid mainnet invoices
      expect(isValidLightningInvoice('lnbc10u1p3xyz...'), isTrue);
      expect(isValidLightningInvoice('lnbc2500u1pvjluezpp5qqqsyqcyq5rqwzq'), isTrue);
      expect(isValidLightningInvoice('lnbc20m1pvjluezpp5qq'), isTrue);
      
      // Valid testnet invoices
      expect(isValidLightningInvoice('lntb10u1p3xyz...'), isTrue);
      expect(isValidLightningInvoice('lntb2500u1pvjluezpp5'), isTrue);
      
      // Valid regtest invoices
      expect(isValidLightningInvoice('lnbcrt10u1p3xyz...'), isTrue);
      
      // Case insensitive
      expect(isValidLightningInvoice('LNBC10u1p3xyz...'), isTrue);
      expect(isValidLightningInvoice('LnBc10u1p3xyz...'), isTrue);
      
      // Invalid formats
      expect(isValidLightningInvoice(''), isFalse);
      expect(isValidLightningInvoice('invalid'), isFalse);
      expect(isValidLightningInvoice('bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh'), isFalse);
      expect(isValidLightningInvoice('lightning:lnbc10u1p3xyz...'), isFalse);
      expect(isValidLightningInvoice('lnurl1234567890'), isFalse);
    });
    
    test('Extract amount from invoice', () {
      expect(extractAmountFromInvoice('lnbc10u1p3xyz'), equals(10));
      expect(extractAmountFromInvoice('lnbc2500u1p3xyz'), equals(2500));
      expect(extractAmountFromInvoice('lnbc20m1p3xyz'), equals(20000000));
      expect(extractAmountFromInvoice('lnbc1p3xyz'), equals(1));
    });
  });
}

// Helper validation functions
bool isValidLightningInvoice(String invoice) {
  if (invoice.isEmpty) return false;
  final validPrefixes = ['lnbc', 'lntb', 'lnbcrt'];
  return validPrefixes.any((prefix) => invoice.toLowerCase().startsWith(prefix));
}

int? extractAmountFromInvoice(String invoice) {
  // Simple extraction for test purposes
  final match = RegExp(r'ln[t]?bc[rt]?(\d+)([munp])').firstMatch(invoice.toLowerCase());
  if (match != null) {
    final amount = int.parse(match.group(1)!);
    final multiplier = match.group(2)!;
    switch (multiplier) {
      case 'm': return amount * 1000000;  // milli-bitcoin
      case 'u': return amount;             // micro-bitcoin (bits)
      case 'n': return amount ~/ 1000;     // nano-bitcoin
      case 'p': return amount ~/ 1000000;  // pico-bitcoin
      default: return amount;
    }
  }
  return null;
}