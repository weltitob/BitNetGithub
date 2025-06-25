import 'package:bitnet/components/dialogsandsheets/channel_opening_sheet.dart';
import 'package:flutter/material.dart';

/// Simple test widget to test LNURL Channel functionality
class TestChannelWidget extends StatelessWidget {
  const TestChannelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LNURL Channel Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _testDemoChannel(context),
              child: Text('Test Demo Channel'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _testWithRealLnurl(context),
              child: Text('Test with Real LNURL'),
            ),
            SizedBox(height: 20),
            Text(
              'Demo mode: Will show channel opening flow\nwith mock data for testing',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  void _testDemoChannel(BuildContext context) async {
    // Test with a demo LNURL that will trigger the demo response
    await context.showChannelOpeningSheet(
      'lnurl1dp68gurn8ghj7mn0wd68ytnhd9hx2tmvde6hymrs9ashq6f0wccj7mrww4excup0dajx2mrv92x9xp',
      onChannelOpened: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Demo channel opened successfully!')),
        );
      },
    );
  }

  void _testWithRealLnurl(BuildContext context) async {
    // You can replace this with a real LNURL channel request
    await context.showChannelOpeningSheet(
      'https://api.blocktank.to/api/channels/your-channel-id',
      onChannelOpened: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Real channel opened successfully!')),
        );
      },
    );
  }
}

/// Extension to add the test widget to any route
extension TestChannelRoute on BuildContext {
  void showTestChannel() {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => TestChannelWidget(),
      ),
    );
  }
}
