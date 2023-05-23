import 'event_base.dart';

enum EntityEvent {
  insert,
  update,
  delete,
}

class OnEntityChangeEvent extends EventBase<String> {
  final EntityEvent event;
  bool get isIncidentChange => tag == 'Incident';
  bool get isNotificationChange => tag == 'Notification';
  OnEntityChangeEvent({required this.event, super.data, super.tag});
}
