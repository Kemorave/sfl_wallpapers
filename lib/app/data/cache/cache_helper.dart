import 'package:sfl/app/data/network/server_responce.dart';

Future<bool> asyncShouldCache(Map<String, dynamic>? map) async {
  try {
    if (map == null) return false;
    final srv = ServerResponce.fromJson(map);
    return srv.success == true;
  } catch (e) {
    return false;
  }
}
