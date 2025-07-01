import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/routing/app_router.dart';
import 'package:mechpro/core/services/app_locale_storage.dart';
import 'package:mechpro/core/services/dio_provider.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/my_mech_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await DioProvider.init;
  await AppLocaleStorage.init();
  await SharedPreferences.getInstance();
  // ignore: await_only_futures+
  await AppLocaleStorage();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: AppAssets.translation,
        fallbackLocale: Locale('en'),
        child: MyMechPro(appRouter: AppRouter(),)),
  );
}
//flutter pub run easy_localization:generate -S assets/translations -O lib/core/translate -o app_translate.g.dart -f keys
