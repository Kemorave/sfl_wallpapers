import '../../data/model/notification_model.dart';
import 'event_base.dart';

class OnNotificationArivalEvent extends EventBase<NotificationModel> {
  OnNotificationArivalEvent({super.data, super.tag});
}
