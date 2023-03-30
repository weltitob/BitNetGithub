import 'package:get_it/get_it.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';

//when app gets to big to localize stuff
//used as a localizer

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<Auth>(Auth());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}