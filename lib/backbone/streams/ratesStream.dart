import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/currency/rates_model.dart';
import 'package:http/http.dart' as http;

Stream<RatesModel> ratesStream() async* {
  yield* Stream.periodic(Duration(minutes: 1), (_) async {
    var response = await http.get(Uri.parse(AppTheme.ratesUrl));
    final ratesModel = ratesModelFromJson(response.body);
    return ratesModel;
  }).asyncMap((event) async => await event);
}
