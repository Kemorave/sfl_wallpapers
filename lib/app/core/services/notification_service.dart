// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:sfl/app/core/events/on_entity_change_event.dart';
import 'package:sfl/app/core/events/on_notification_arival_event.dart';
import 'package:sfl/app/data/model/notification_model.dart';
import 'package:sfl/locator.dart';
import 'package:sfl/messenger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../firebase_options.dart';

class OnTokenChange {}

class NotificationService extends GetxService {
  var topics = <String>[];
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    'FMPushNotificationChannel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );
  static const AndroidInitializationSettings _initializationSettingsAndroid =
      AndroidInitializationSettings('logo');
  static const DarwinInitializationSettings _initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  static const InitializationSettings _initializationSettings =
      InitializationSettings(
    android: _initializationSettingsAndroid,
    iOS: _initializationSettingsIOS,
  );
 

  Future removeAllTopics() async {
    for (var element in topics) {
      await _firebaseMessaging.unsubscribeFromTopic(element);
    }
    topics.clear(); 
  }

  Future removeTopic(String topic) async {
    if (!topics.contains(topic)) return;
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    topics.remove(topic); 
  }

  Future addTopic(String topic) async { 
    if (topics.contains(topic)) return;
    await _firebaseMessaging.subscribeToTopic(topic);
    topics.add(topic); 
  }

  Future askNotificationPermission() async {
    FirebaseMessaging messaging = _firebaseMessaging; 
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
  }

 

  RemoteMessage? _openedMessage;
  void openTappedMessage() {
    if (_openedMessage != null) {
      _onFcmNotitificationTap(_openedMessage!);
    }
  }

  Future startJob() async {
    topics = [];  
    await _setupHeadsup();
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onDidReceiveNotificationResponse: _onLocalNotificationTap);
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      Messenger.sendMessage(OnTokenChange());
    });
    _openedMessage = await _firebaseMessaging.getInitialMessage();
    FirebaseMessaging.onBackgroundMessage(onFcmBackgroundNotifcationArrive);
    FirebaseMessaging.onMessage
        .asBroadcastStream()
        .listen(_onFcmForegroundNotifcationArrive);
    FirebaseMessaging.onMessageOpenedApp.listen(_onFcmNotitificationTap);
  }

  Future _setupHeadsup() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);
  }

  static Future<void> onFcmBackgroundNotifcationArrive(
      RemoteMessage message) async {
    if (Firebase.apps.isEmpty) {
      // If you're going to use other Firebase services in the background, such as Firestore,
      // make sure you call `initializeApp` before using other Firebase services.
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      initLocator();
    }
    if (message.data.containsKey("PUSH_RC")) {
      processPushRC(
          dataJson: message.data["PUSH_RC"], type: message.data["type"]);
      return;
    } 
  }

  void _onFcmForegroundNotifcationArrive(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
    //Foreground
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      if (notification.title?.isNotEmpty == true) {
        _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    _androidChannel.id, _androidChannel.name,
                    channelDescription: _androidChannel.description,
                    icon: android.smallIcon,
                    playSound: true,
                    visibility: NotificationVisibility.public
                    // other properties...
                    ),
                iOS: DarwinNotificationDetails(
                    sound: 'default',
                    presentSound: true,
                    subtitle: notification.title)),
            payload: json.encode(message.data));
      }
      if (message.data.containsKey("PUSH_RC")) {
        processPushRC(
            dataJson: message.data["PUSH_RC"], type: message.data["type"]);
      }
    }
  }

  void _onFcmNotitificationTap(RemoteMessage message) {
    if (message.data.containsKey("PUSH_RC")) {
      // var data =
      //     getData(rc: message.data["PUSH_RC"], type: message.data["type"]);
      // if (data is OrderModel) {
      //   Get.find<UserDataService>().showOrderDetails(data);
      // }
      // if (data is NotificationModel) {
      //   openNotification(data);
      // }
    }
  }

  void _onLocalNotificationTap(NotificationResponse payload) {
    try {
      // if (payload == null) {
      //   return;
      // }
      //var order = getData(rc: payload, type: "order");
      //Get.find<UserDataService>().showOrderDetails(order);
    } catch (e) {
      print(e);
    }
  }

  static void processPushRC(
      {required String dataJson, required String type, String? tag}) {
    try {
      switch (type) {
        case "notification":
          final notification =
              NotificationModel.fromJson(json.decode(dataJson));
          Messenger.sendMessage(
              OnNotificationArivalEvent(data: notification, tag: tag));
          break;
        case "entityEvent":
          var eventJson = json.decode(dataJson);
          final eventName = eventJson['event'];
          final eventData = eventJson['data'];
          final eventEntity = eventJson['entity'];
          var eventType = EntityEvent.insert;
          switch (eventName) {
            case 'Update':
              eventType = EntityEvent.update;
              break;
            case 'Delete':
              eventType = EntityEvent.delete;
              break;
          }
          Messenger.sendMessage(OnEntityChangeEvent(
              event: eventType, data: eventData, tag: eventEntity));
          break;
        default:
      }
    } catch (e, s) {
      errorControl().reportError(e, s);
    }
  }
 

  Future<String?> getToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e, s) {
      errorControl().reportError(e, s);
      return null;
    }
  }
}
