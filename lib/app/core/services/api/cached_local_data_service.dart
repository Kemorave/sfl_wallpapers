import 'dart:convert';

import 'package:cached_annotation/cached_annotation.dart';
import 'package:get_storage/get_storage.dart';

import 'local_data_service.dart';

class CachedLocalDataService extends CachedStorage {
  final _service = LocalDataService(GetStorage('cachedContainer'));
  Future<bool> initStorage() {
    return _service.initStorage();
  }

  @override
  Future<Map<String, dynamic>> read(String key) {
    return Future.value(json.decode(_service.getKey(key) ?? "{}"));
  }

  @override
  Future<void> write(String key, Map<String, dynamic> data) {
    return _service.setKey(key, json.encode(data));
  }

  @override
  Future<void> delete(String key) {
    return _service.removeKey(key);
  }

  @override
  Future<void> deleteAll() {
    return _service.removeAll();
  }
}
