

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');

   
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
   
        saveNotification(
          title: message.notification?.title ?? 'لا يوجد عنوان',
          body: message.notification?.body ?? 'لا يوجد محتوى',
        );
      }
    });
  }


  static Future<void> saveNotification({
    required String title,
    required String body,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationsList = prefs.getStringList('notifications') ?? [];
    Map<String, dynamic> notification = {
      'title': title,
      'body': body,
      'timestamp': DateTime.now().toIso8601String(),
      'isRead': false, 
    };
    notificationsList.add(jsonEncode(notification));
    await prefs.setStringList('notifications', notificationsList);
  }


  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationsList = prefs.getStringList('notifications') ?? [];
    return notificationsList
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }


  static Future<void> markNotificationAsRead(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationsList = prefs.getStringList('notifications') ?? [];
    if (index >= 0 && index < notificationsList.length) {
      final notification = jsonDecode(notificationsList[index]) as Map<String, dynamic>;
      notification['isRead'] = true;
      notificationsList[index] = jsonEncode(notification);
      await prefs.setStringList('notifications', notificationsList);
    }
  }
}
