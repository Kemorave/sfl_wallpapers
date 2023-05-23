import 'package:sfl/app/core/extentions/responce_extension.dart';
import 'package:flutter/foundation.dart';

import '../../core/action_result.dart';
import '../model/notification_model.dart';
import '../network/server_responce.dart';
import 'base/i_disposible_repository.dart';

class NotificationRepository extends IDisposibleRepository {
  NotificationRepository();
  Future<ActionResult<List<NotificationModel>>> getNotifications() async {
    var res = await client.get("notifications/");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: await compute(
            deserializeModels,
            (ServerResponce.fromJson(res.body ?? {}).data['notifications']
                    as List<dynamic>?) ??
                []));
  }

  static List<NotificationModel> deserializeModels(List<dynamic> list) {
    return list
        .map<NotificationModel>((e) => NotificationModel.fromJson(e))
        .toList();
  }
}
