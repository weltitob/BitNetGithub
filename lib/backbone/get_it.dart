import 'package:get_it/get_it.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
//when app gets to big localize stuff with get it and dont import 500 diffrent paths
//just used as a localizer

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<Auth>(Auth());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}