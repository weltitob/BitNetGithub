// global_percentage_change.dart
import 'dart:async';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/streams/website_streams/usercountstream.dart';


Future<int> _userCountFrom7DaysAgo() async {
  Logs().i("usercount 7 days ago called");
  DateTime sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));
  var snapshot = await usersCollection.where('createdAt', isLessThanOrEqualTo: sevenDaysAgo).get();
  Logs().e("Error: usercount 7 days ago cant work now because of deleted users // createdAt is not there yet");
  return snapshot.size;
}

Future<int> _getCurrentUserCount() async {
  var snapshot = await usersCollection.get();
  return snapshot.size;
}

Stream<double> percentageChangeInUserCountStream() async* {
  await for (int currentUserCount in userCountStream()) {
    int initialUserCount = await _userCountFrom7DaysAgo();
    // Calculate percentage change when user count updates
    if (initialUserCount == 0) {
      yield (currentUserCount > 0) ? 100.0 : 0.0;
    } else {
      double percentageChange = ((currentUserCount - initialUserCount) / initialUserCount) * 100;
      yield percentageChange;
    }
  }
}