/*import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // طلب صلاحيات الإشعارات من المستخدم
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // الحصول على FCM Token
    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');

    // التعامل مع الإشعارات أثناء وجود التطبيق في المقدمة
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // حفظ الإشعار في SharedPreferences
        saveNotification(
          title: message.notification?.title ?? 'لا يوجد عنوان',
          body: message.notification?.body ?? 'لا يوجد محتوى',
        );
      }
    });
  }

  // دالة لحفظ الإشعار في SharedPreferences
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
    };
    notificationsList.add(jsonEncode(notification));
    await prefs.setStringList('notifications', notificationsList);
  }

  // دالة للحصول على جميع الإشعارات المحفوظة
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationsList = prefs.getStringList('notifications') ?? [];
    return notificationsList
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }
}
*/


import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // طلب صلاحيات الإشعارات من المستخدم
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // الحصول على FCM Token
    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');

    // التعامل مع الإشعارات أثناء وجود التطبيق في المقدمة
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // حفظ الإشعار في SharedPreferences
        saveNotification(
          title: message.notification?.title ?? 'لا يوجد عنوان',
          body: message.notification?.body ?? 'لا يوجد محتوى',
        );
      }
    });
  }

  // دالة لحفظ الإشعار في SharedPreferences
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
      'isRead': false, // تمت إضافة هذا الحقل لتتبع حالة الإشعار
    };
    notificationsList.add(jsonEncode(notification));
    await prefs.setStringList('notifications', notificationsList);
  }

  // دالة للحصول على جميع الإشعارات المحفوظة
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationsList = prefs.getStringList('notifications') ?? [];
    return notificationsList
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }

  // دالة جديدة لوضع علامة "مقروء" على إشعار معين
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
