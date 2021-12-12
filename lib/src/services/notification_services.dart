import 'package:Dailoz/main.dart';
import 'package:Dailoz/src/models/task_model.dart';
import 'package:Dailoz/src/repository/task_repository.dart';
import 'package:Dailoz/src/screens/detail_task_screen/detail_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  // initialize flutter notification plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  //init plugin when start app

  Future<void> init() async {
    //init in Android mode
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    // init in Ios Mode
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);
    // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    //     await flutterLocalNotificationPlugin.getNotificationAppLaunchDetails();

    await flutterLocalNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: (
      String? payload,
    ) async {
      if (payload != null) {
        Task task = await TaskRepository().getTaskById(payload);
        Navigator.push(
          navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => DetailTask(
              id: task.id,

            ),
          ),
        );
      }

      // await Navigator.push(context,MaterialPageRoute(builder: (context) => DetailTask))
    });
    tz.initializeTimeZones();
  }

  Future<void> showNotification(
      int id, String title, String body, DateTime time, Task task) async {
    final asiaUtc7 = tz.getLocation('Asia/Ho_Chi_Minh');
    // final tz.TZDateTime now = tz.TZDateTime.now(asiaUtc7);
    final scheduledDate = tz.TZDateTime.from(time, asiaUtc7);

    await flutterLocalNotificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime(
          asiaUtc7,
          scheduledDate.year,
          scheduledDate.month,
          scheduledDate.day,
          scheduledDate.hour,
          scheduledDate.minute,
          scheduledDate.second),
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: 'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/app_icon'
            ),
        iOS: IOSNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: task.id,
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}

  Future<void> selectNotification(
    String? payload,
  ) async {}

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationPlugin.cancelAll();
  }
}
