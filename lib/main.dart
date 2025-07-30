

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
