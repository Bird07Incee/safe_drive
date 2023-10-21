import 'package:commons/commons.dart';
final inject = GetIt.instance;

class DI {
  static registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    if (!GetIt.instance.isRegistered<T>()) {
      inject.registerLazySingleton<T>(factoryFunc);
    }
  }
}
