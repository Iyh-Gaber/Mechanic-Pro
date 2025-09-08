

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/app_color.dart';

import 'package:mechpro/feature/intro/presentation/views/welcome_views.dart'; 

import 'package:firebase_messaging/firebase_messaging.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
 
  String? _fcmToken; 
  

  @override
  void initState() {
    super.initState(); 

   
  
    _initializeFirebaseMessaging();

    Future.delayed(const Duration(seconds: 2), () {
      _navigateToNextScreen();
    });
  }
  void _initializeFirebaseMessaging() async {
   
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,  
      badge: true,   
      sound: true,   
    );
    print('User granted permission: ${settings.authorizationStatus}'); 
   

    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      _fcmToken = token; 
    });
    print("FCM Token: $token"); 

   
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened from terminated state by notification!');
        print('Message data: ${message.data}'); 
       
      }
    });

  
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification?.title} - ${message.notification?.body}');
       
        _showForegroundNotificationDialog(message.notification?.title, message.notification?.body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app from background state!');
      print('Data: ${message.data}');
      

    });
  }

  
  void _showForegroundNotificationDialog(String? title, String? body) {
    if (context.mounted) { 
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title ?? 'Notification'), 
          content: Text(body ?? 'No content'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('حسناً'),
            ),
          ],
        ),
      );
    }
  }

  void _navigateToNextScreen() {
    if (context.mounted) { 
   
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const WelcomeViews(); 
          },
        ),
        (route) => false, 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo), 
        
          ],
        ),
      ),
    );
  }
}