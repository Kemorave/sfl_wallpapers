import 'package:sfl/app/data/repositories/api_http_client.dart';

import 'i_http_client.dart';

abstract class IDisposibleRepository {
  late IHttpClient client = ApiHttpClient();

  void dispose() {
    client.dispose();
  }
}
