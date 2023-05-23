import 'package:sfl/app/core/exceptions/network_error_exception.dart';
import 'package:sfl/app/core/exceptions/not_loged_in_exception.dart';
import 'package:get/get.dart';

extension ResponceExtension on Response {
  void ensureSuccess() {
    if (body == null) {
      if (statusCode == 403) {
        throw NotLogedInException('Token error');
      }
      if (statusCode == null &&
          (statusText?.contains('SocketException') == true &&
              statusText?.contains('cancelled') == false)) {
        throw NetworkErrorException('Network error');
      }
    }
  }
}
