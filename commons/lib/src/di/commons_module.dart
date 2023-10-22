import 'package:commons/commons.dart';
import 'package:hive/hive.dart';

final inject = GetIt.instance;

Future diCommonModule() async {
  await _diEncrypted();
  await _storage();
}

_diEncrypted() {
  DI.registerLazySingleton<EncryptStorage>(() => EncryptStorage());
}

Future<void> _storage() async {
  final storage = inject<EncryptStorage>();
  await storage.generateSecureKey();
  await storage.newStorage(dbName: DBNAME.IMAGES_DB);
  await storage.newStorage(dbName: DBNAME.INFO_DB);
}

class AppHive {
  static registerAdapter<T>(
      TypeAdapter<T> adapter, {
        bool internal = false,
        bool override = false,
      }) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(
        adapter,
        internal: internal,
        override: override,
      );
    }
  }
}

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
