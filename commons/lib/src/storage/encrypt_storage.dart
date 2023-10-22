import 'dart:convert';
import 'dart:typed_data';
import 'package:commons/src/constants/constants.dart';
import 'package:convert/convert.dart';
import 'package:data/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class EncryptStorage {
  late final _aOptions = const AndroidOptions(encryptedSharedPreferences: true);

  Future generateSecureKey() async {
    await _secureKey();
  }

  Future newStorage({required String dbName}) async {
    final cipher = HiveAesCipher(await _key());
    try {
      await Hive.openBox(dbName, encryptionCipher: cipher);
      print('openBox $dbName : ${Hive.isBoxOpen(dbName)}');
    } catch (e) {
      print('NewStorage error $dbName');

      /// When can't create [dbName]
      if (!Hive.isBoxOpen(dbName)) {
        await Hive.deleteBoxFromDisk(dbName);
        await newStorage(dbName: dbName);
      }
    }
  }

  Future<Uint8List> _key() async {
    final secureKey = await _secureKey();
    if (secureKey == null) {
      throw ArgumentError.value(secureKey, "secureKey null");
    }
    final decryptedKey = base64Url.decode(secureKey);
    return decryptedKey;
  }

  Future<String?> _secureKey() async {
    final dbKey = await _genKey();
    final storage = FlutterSecureStorage(aOptions: _aOptions);
    final secureKey = await storage.read(key: dbKey);

    if (secureKey == null) {
      await Hive.deleteBoxFromDisk(DBNAME.IMAGES_DB);
      await Hive.deleteBoxFromDisk(DBNAME.INFO_DB);
      final key = Hive.generateSecureKey();
      await storage.write(key: dbKey, value: base64.encode(key));
    }
    return await storage.read(key: dbKey);
  }

  Future<String> _genKey() async {
    const key = "kg";
    final storage = FlutterSecureStorage(aOptions: _aOptions);
    final kg = await storage.read(key: key);

    if (kg == null) {
      await Hive.deleteFromDisk();
      final random = Encrypt.random(24);
      final dbKey = hex.encode(utf8.encode(random));
      await storage.write(key: key, value: dbKey);
    }

    return (await storage.read(key: key))!;
  }

  Box<E> openStorage<E>(String dbName) {
    return Hive.box(dbName);
  }

  Future<int> clear(String dbName) {
    if (Hive.isBoxOpen(dbName)) {
      return Hive.box(dbName).clear();
    }
    return Future.value(0);
  }
}
