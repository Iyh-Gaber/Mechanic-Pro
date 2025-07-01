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
 factory MyMechPro.create() => MyMechPro(appRouter: AppRouter());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      //splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
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
         onGenerateRoute: appRouter.generateRoute, // <--- هذا يجب أن يشير إلى الـ AppRouter الصحيح
          initialRoute: Routes.splashView,
           // home: SplashView(),
        );
      },
    );
  }
}
