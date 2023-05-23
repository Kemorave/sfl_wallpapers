import 'dart:async';

import 'package:event_bus/event_bus.dart';

class Messenger {
  static final EventBus _eventBus = EventBus();

  static void sendMessage<T>(T? event) {
    _eventBus.fire(event);
  }

  static StreamSubscription<T> listen<T>(void Function(T) fun) =>
      _eventBus.on<T>().listen(fun);
}
