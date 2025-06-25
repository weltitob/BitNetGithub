import 'package:flutter_test/flutter_test.dart';
import 'integration/receive/onchain_receive_test.dart' as onchain_test;

void main() {
  group('Single Test Runner', () {
    onchain_test.main();
  });
}
