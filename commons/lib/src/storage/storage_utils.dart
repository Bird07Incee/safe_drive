import 'package:commons/commons.dart';
import 'package:data/data.dart';

class StorageUtils {
  static final _storage = inject<EncryptStorage>();
  static final _infoDB = _storage.openStorage(DBNAME.INFO_DB);

  static String getRandom(int len) {
    return Encrypt.random(len);
  }

  static Future<void> put(String key, dynamic value) {
    return _infoDB.put(key, value);
  }

  static E? get<E>(String key, {E? defaultValue}) {
    return _infoDB.get(key, defaultValue: defaultValue) ?? defaultValue;
  }

}
