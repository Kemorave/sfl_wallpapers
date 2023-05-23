import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalDataService extends GetxService {
  LocalDataService(this._storage);
  final GetStorage _storage;
  Future<bool> initStorage() {
    return _storage.initStorage;
  }

  bool hasKey(String key) => _storage.hasData(key);
  String? getKey(String key) => _storage.read(key);
  Future<void> setKey(String key, String value) => _storage.write(key, value);
  Future<void> removeKey(String key) => _storage.remove(key);
  Future<void> removeAll() => _storage.erase();
}
