// global_percentage_change.dart
import 'dart:async';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/pages/website/website_landingpage/streams/usercountstream.dart';  // Adjust the import to your project structure

double latestPercentageChange = 0.0;
StreamController<double> _percentageChangeController = StreamController.broadcast();
int _initialUserCount = 0;
int _lastUserCount = 0;
StreamSubscription<int>? _userCountSubscription;

Future<void> startListeningToPercentageChange() async {
  _initialUserCount = await _userCountFrom7DaysAgo();
  _userCountSubscription = userCountStream().listen((currentUserCount) {
    if (_lastUserCount != currentUserCount) {
      _lastUserCount = currentUserCount;
      if (_initialUserCount != 0) {
        latestPercentageChange = ((currentUserCount - _initialUserCount) / _initialUserCount) * 100;
      } else {
        latestPercentageChange = (currentUserCount > 0) ? 100.0 : 0.0;
      }
      _percentageChangeController.add(latestPercentageChange);
    }
  });
}

void stopListeningToPercentageChange() {
  _userCountSubscription?.cancel();
}

Stream<double> get percentageChangeStream => _percentageChangeController.stream;

Future<int> _userCountFrom7DaysAgo() async {
  DateTime sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));
  var snapshot = await usersCollection.where('createdAt', isLessThanOrEqualTo: sevenDaysAgo).get();
  return snapshot.size;
}

Future<int> _getCurrentUserCount() async {
  var snapshot = await usersCollection.get();
  return snapshot.size;
}

//
// Stream<double> percentageChangeInUserCountStream() async* {
//   print("Percentchange called");
//   int initialUserCount = await _userCountFrom7DaysAgo();
//   Timer.periodic(Duration(minutes: 5), (timer) async* {
//     // Get the current user count every 5 minutes
//     int currentUserCount = await _getCurrentUserCount();
//     if (initialUserCount == 0) {
//       yield (currentUserCount > 0) ? 100.0 : 0.0; // 100% increase if we had 0 users 7 days ago and now have more
//     } else {
//       double percentageChange = ((currentUserCount - initialUserCount) / initialUserCount) * 100;
//       yield percentageChange;
//     }
//   });
// }
