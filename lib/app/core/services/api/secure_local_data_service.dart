import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SecureLocalDataService extends GetxService {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static IOSOptions _getIOSOptions() => const IOSOptions();
  final _storage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());

  Future<bool> hasKey(String key) => _storage.containsKey(key: key);
  Future<String?> getKey(String key) => _storage.read(key: key);
  Future<void> setKey(String key, String value) =>
      _storage.write(key: key, value: value);
  Future<void> removeKey(String key) => _storage.delete(key: key);
}
