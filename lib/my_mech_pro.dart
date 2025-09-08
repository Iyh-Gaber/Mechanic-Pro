
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/routing/app_router.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/theme/dark_theme.dart';
import 'package:mechpro/core/theme/light_theme.dart';

class MyMechPro extends StatelessWidget {
  const MyMechPro({super.key, required this.appRouter});
  final AppRouter appRouter;



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Mechanic Pro',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
        
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: Routes.splashView, 
        );
      },
    );
  }
}
