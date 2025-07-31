
/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/routing/app_router.dart';
import 'package:mechpro/core/services/app_locale_storage.dart';
import 'package:mechpro/core/services/dio_provider.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/feature/home/data/repo/main_services_repo.dart';
import 'package:mechpro/feature/home/presentation/cubit/main_services_cubit.dart';
import 'package:mechpro/firebase_options.dart';
import 'package:mechpro/my_mech_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // تأكد من استيراد Firebase Auth

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioProvider();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  DioProvider.initialize(); 
  await AppLocaleStorage.init();
  await SharedPreferences.getInstance();
  

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final AppRouter appRouter = AppRouter();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: AppAssets.translation,
      fallbackLocale: const Locale('en'),
      child: BlocProvider<MainServicesCubit>(
        create: (context) => MainServicesCubit(MainServicesRepo()),
        child: MyMechPro(appRouter: appRouter),
      ),
    ),
  );
}
*/

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/routing/app_router.dart';
import 'package:mechpro/core/services/app_locale_storage.dart';
import 'package:mechpro/core/services/dio_provider.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/feature/home/data/repo/main_services_repo.dart';
import 'package:mechpro/feature/home/presentation/cubit/main_services_cubit.dart';
import 'package:mechpro/firebase_options.dart';
import 'package:mechpro/my_mech_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart'; 



// **دالة معالجة رسائل الخلفية (Background Message Handler)**
// هذه الدالة يجب أن تكون دالة على المستوى الأعلى (Top-level function)
// أو دالة ثابتة (static method) داخل كلاس
// @pragma('vm:entry-point') مهمة لضمان عملها في الخلفية على iOS
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // عند استلام رسالة في الخلفية، Firebase يعرض الإشعار تلقائياً.
  // هنا يمكنك معالجة البيانات الإضافية أو إجراء تحديثات.
  // **مهم:** يجب تهيئة Firebase هنا أيضاً إذا كنت ستستخدم أي خدمات Firebase أخرى
  // (مثل Firestore أو Auth) داخل هذه الدالة عند استلام رسالة في الخلفية.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');
  print('Message notification title: ${message.notification?.title}');
  print('Message notification body: ${message.notification?.body}');

  // يمكنك هنا إضافة منطق مخصص، مثل:
  // - حفظ الرسالة في قاعدة بيانات محلية.
  // - تحديث حالة التطبيق.
  // - إرسال تحليل.
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تأكد من تهيئة Flutter Engine

  // تهيئة Firebase في تطبيقك
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // **تسجيل معالج رسائل الخلفية لـ FCM**
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // تهيئة مزودي الخدمات الأخرى
  await DioProvider();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  DioProvider.initialize();
  await AppLocaleStorage.init();
  await SharedPreferences.getInstance(); // لا تحتاج لتعيينها لمتغير إذا كنت لا تستخدمها مباشرة هنا

  final AppRouter appRouter = AppRouter();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: AppAssets.translation,
      fallbackLocale: const Locale('en'),
      child: BlocProvider<MainServicesCubit>(
        create: (context) => MainServicesCubit(MainServicesRepo()),
        child: MyMechPro(appRouter: appRouter),
      ),
    ),
  );
}