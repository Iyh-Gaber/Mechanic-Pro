


/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/utils/app_assets.dart';

import 'package:mechpro/feature/intro/presentation/views/welcome_views.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    //super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return WelcomeViews();
            },
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(AppAssets.logo)));
  }
}
*/

// splash_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/utils/app_assets.dart';

// تأكدي من أن هذا المسار صحيح لشاشة الترحيب الخاصة بكِ
import 'package:mechpro/feature/intro/presentation/views/welcome_views.dart'; 

// **إضافة استيراد Firebase Messaging**
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // متغير لتخزين رمز الجهاز المميز (FCM Token) لغرض الـ debugging (اختياري)
  String? _fcmToken; 
  
  // يمكنك إضافة متغير لتخزين بيانات الرسالة الأولية إذا فتح التطبيق من إشعار
  // Map<String, dynamic>? _initialMessageData;

  @override
  void initState() {
    super.initState(); // **هذا السطر مهم جداً ويجب أن يكون في البداية**

    // **الخطوة 1: تهيئة Firebase Messaging والتعامل مع الإشعارات**
    // هذه الدالة ستقوم بطلب الأذونات، الحصول على التوكن، وإعداد المستمعات
    _initializeFirebaseMessaging();

    // **الخطوة 2: تأخير التنقل بعد تهيئة الإشعارات**
    // هذا التأخير ثابت لمدة ثانيتين كما كان في كودك الأصلي.
    // يتم استدعاء دالة التنقل بعد انتهاء هذه الثواني.
    Future.delayed(const Duration(seconds: 2), () {
      _navigateToNextScreen();
    });
  }

  // **دالة لتهيئة Firebase Messaging ومستمعات الرسائل**
  // هذه الدالة تقوم بكل العمل المتعلق بالإشعارات
  void _initializeFirebaseMessaging() async {
    // 1. طلب الأذونات من المستخدم (ضروري لظهور الإشعارات، خاصة على iOS)
    // هذا سيظهر للمستخدم مربع حوار يسأله إذا كان يوافق على تلقي الإشعارات.
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,   // السماح بعرض التنبيهات (مثل البانر)
      badge: true,   // السماح بتحديث رقم الشارة على أيقونة التطبيق
      sound: true,   // السماح بتشغيل صوت عند وصول الإشعار
    );
    print('User granted permission: ${settings.authorizationStatus}'); 
    // يمكنك طباعة حالة الإذن لمعرفة ما إذا وافق المستخدم (authorized) أو رفض (denied)

    // 2. الحصول على رمز الجهاز المميز (FCM Token)
    // هذا الرمز فريد لكل جهاز وتطبيق، وستستخدمينه لإرسال الإشعارات المستهدفة.
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      _fcmToken = token; // نحدث المتغير لعرضه في واجهة المستخدم (للتصحيح فقط)
    });
    print("FCM Token: $token"); // سيظهر هذا الرمز في Logcat/Console الخاص بكِ

    // **مهم جداً جداً هنا:**
    // يجب عليكِ الآن إرسال هذا الرمز (token) إلى الخادم الخلفي (Backend) الخاص بكِ.
    // الطريقة الشائعة هي ربط هذا الرمز بمعرف المستخدم (User ID) في قاعدة بياناتك على الخادم.
    // هذا يسمح لكِ لاحقاً بإرسال إشعارات مخصصة لمستخدمين معينين.
    // مثال (افترض أن لديكِ API Client):
    // if (UserSession.isLoggedIn) { // تحقق ما إذا كان المستخدم مسجلاً للدخول
    //   await MyApiClient.sendDeviceTokenToServer(token, UserSession.currentUserId);
    // } else {
    //   // إذا لم يكن المستخدم مسجلاً للدخول، يمكنك تخزين الرمز مؤقتاً
    //   // وإرساله عندما يقوم المستخدم بتسجيل الدخول لأول مرة.
    //   // SharedPreferences.getInstance().then((prefs) => prefs.setString('fcm_token_pending', token));
    // }

    // 3. التعامل مع الرسالة الأولية التي فتحت التطبيق (عندما يكون التطبيق مغلقاً تماماً - Terminated State)
    // هذه الدالة يتم استدعاؤها مرة واحدة عند فتح التطبيق نتيجة النقر على إشعار وكان التطبيق مغلقاً.
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened from terminated state by notification!');
        print('Message data: ${message.data}'); 
        // هنا يمكنك معالجة البيانات الإضافية التي جاءت مع الإشعار.
        // مثلاً، حفظها مؤقتاً أو استخدامها لتوجيه المستخدم لشاشة معينة بعد الـ Splash.
        // _initialMessageData = message.data; 
      }
    });

    // 4. التعامل مع الرسائل عندما يكون التطبيق في المقدمة (Foreground)
    // هذا المستمع يستقبل الإشعارات بينما المستخدم يتفاعل مع تطبيقك.
    // Firebase لا تعرض الإشعارات تلقائياً في هذه الحالة، لذا يجب عليكِ عرضها يدوياً.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification?.title} - ${message.notification?.body}');
        // هنا يمكنك عرض الإشعار يدوياً للمستخدم.
        // سنستخدم دالة مساعدة بسيطة لعمل AlertDialog، ولكن يمكنك استخدام مكتبة 'flutter_local_notifications'
        // لعرض إشعارات نظامية تظهر في شريط التنبيهات.
        _showForegroundNotificationDialog(message.notification?.title, message.notification?.body);
      }
    });

    // 5. التعامل مع النقر على الإشعار عندما يكون التطبيق في الخلفية (Background)
    // هذا المستمع يتم استدعاؤه عندما ينقر المستخدم على إشعار وكان التطبيق في الخلفية (وليس مغلقاً تماماً).
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app from background state!');
      print('Data: ${message.data}');
      // يمكنك هنا أيضاً معالجة البيانات أو تخزينها لتوجيه المستخدم لاحقاً.
      // _openedMessageData = message.data;
    });
  }

  // دالة مساعدة لعرض الإشعار عندما يكون التطبيق في المقدمة
  // تستخدم AlertDialog بسيط بدلاً من إشعار نظامي.
  void _showForegroundNotificationDialog(String? title, String? body) {
    if (context.mounted) { // للتأكد أن الويدجت لا يزال جزءاً من شجرة الويدجت
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title ?? 'Notification'), // عنوان الإشعار
          content: Text(body ?? 'No content'), // محتوى الإشعار
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // زر الإغلاق
              child: const Text('حسناً'),
            ),
          ],
        ),
      );
    }
  }

  // دالة التنقل إلى الشاشة التالية بعد انتهاء Splash Screen
  void _navigateToNextScreen() {
    if (context.mounted) { // للتأكد أن الويدجت لا يزال جزءاً من شجرة الويدجت
      // هنا يمكنك تمرير أي بيانات من الإشعارات إلى WelcomeViews
      // إذا كان التطبيق قد فتح بسبب إشعار وتريدين معالجة البيانات فيه.
      // مثال لتمرير البيانات:
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => WelcomeViews(
      //       initialNotificationData: _initialMessageData ?? _openedMessageData,
      //     ),
      //   ),
      //   (route) => false,
      // );

      // الكود الأصلي الخاص بكِ للتنقل:
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const WelcomeViews(); // تأكدي من استخدام 'const' إذا كانت WelcomeViews ثابتة
          },
        ),
        (route) => false, // هذا يعني إزالة جميع الشاشات السابقة من الـ stack
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // تصميم شاشة Splash Screen الخاصة بكِ
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo), // شعار التطبيق الخاص بكِ
            SizedBox(height: 20.h), // مسافة باستخدام ScreenUtil
            
            // **اختياري:** لعرض الرمز المميز لغرض الـ debugging
            // يمكنك إزالة هذا الجزء في الإصدار النهائي من تطبيقك
            if (_fcmToken != null)
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: SelectableText( // يسمح لك بنسخ الـ token بسهولة من الشاشة
                  'FCM Token: $_fcmToken',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ),
            
            const SizedBox(height: 20), // مسافة لمؤشر التحميل
            const CircularProgressIndicator(), // مؤشر تحميل دائري (اختياري)
          ],
        ),
      ),
    );
  }
}