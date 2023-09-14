import 'package:marketplace_line_oa/src/extension/map_extension.dart';

class MarketplaceDataStore {
  MarketplaceDataStore._internal();
  static final MarketplaceDataStore _instance = MarketplaceDataStore._internal();
  factory MarketplaceDataStore() => _instance;

  final Map<String, dynamic> _args = {};
  final Map<String, dynamic> _env = {};

  void setArgs(Map<String, dynamic> args) {
    _args.addAll(args);
  }

  addArgs<T>(String key, T value) {
    _args[key] = value;
  }

  addENV<T>(String key, T value) {
    _env[key] = value;
  }

  T getArgs<T>(String key) {
    T? value = _args.filterByKey(key) as T?;
    if (value == null) {
      throw Exception("Not found value with key : $key");
    }
    return value;
  }

  void setEnv(Map<String, dynamic> env) {
    _env.addAll(env);
  }

  T getEnv<T>(String key) {
    T? value = _env.filterByKey(key) as T?;
    if (value == null) {
      throw Exception("Not found value with key : $key");
    }
    return value;
  }

  bool hasKeyEnv(String key) {
    return _env.containsKey(key);
  }
}
