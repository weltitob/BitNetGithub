import 'package:get_it/get_it.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<Auth>(Auth());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}