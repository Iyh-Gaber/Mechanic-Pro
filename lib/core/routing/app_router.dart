/*import 'package:flutter/material.dart';
import 'package:mechpro/feature/home/presentation/views/home_view.dart';
import 'package:mechpro/feature/notifications/presentation/views/notification_view.dart';
import 'package:mechpro/feature/offers/presentation/views/offers.dart';
import 'package:mechpro/feature/profile/presentation/views/profile_view.dart';
import 'package:mechpro/core/routing/routes.dart';

class AppRouter {
  // دالة لبناء الـ Widget من اسم المسار والوسائط
   static buildRoute(String routeName, Object? arguments) {
    switch (routeName) {
      case Routes.homeView:
        return const HomeView();
      case Routes.profileView:
        // إذا كان هناك arguments، قم بتمريرها هنا
        // final userId = (arguments as Map<String, dynamic>?)?['userId'];
        return const ProfileView(); // أو ProfileView(userId: userId)
      case Routes.notificationView:
        return const NotificationView();
      case Routes.offersView:
        return const OffersView();
      // أضف كل المسارات الأخرى هنا
      // case Routes.someOtherRoute:
      //   return SomeOtherView(arg: arguments);
      default:
        return const Scaffold(
          body: Center(
            child: Text('Error: Route not found.'),
          ),
        );
    }
  }

  static Route generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) =>  buildRoute(settings.name!, settings.arguments), // <--- استخدام buildRoute هنا
    );
  }
}
*/

/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechpro/feature/auth/presintation/views/registaration_view.dart';
import 'package:mechpro/feature/home/presentation/views/home_view.dart';
import 'package:mechpro/feature/notifications/presentation/views/notification_view.dart';
import 'package:mechpro/feature/offers/presentation/views/offers.dart';
import 'package:mechpro/feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:mechpro/feature/other_services/presentation/views/other_services.dart';
import 'package:mechpro/feature/profile/presentation/views/profile_view.dart';
// تأكد من استيراد الشاشات الجديدة مثل RegistrationView
import 'package:mechpro/core/routing/routes.dart';

import '../../feature/Selling_ original_spare parts/presentation/views/Selling _original _spare_ parts.dart';
import '../../feature/auth/presintation/views/forget_password_view.dart';
import '../../feature/auto_body_repair/presentation/views/auto_body_repair.dart';
import '../../feature/car_rental/presentation/views/car_rental.dart';
import '../../feature/cars_registration/presentation/views/add_new_car.dart';
import '../../feature/cars_registration/presentation/views/cars_registration.dart';
import '../../feature/connect_us/presentation/views/connect_us.dart';
import '../../feature/intro/presentation/views/splash_view.dart';
import '../../feature/layout/layout_view.dart';
import '../../feature/regular_maintenance/data/repo/regular_repo.dart';
import '../../feature/regular_maintenance/presentation/cubit/regular_services_cubit.dart';
import '../../feature/regular_maintenance/presentation/views/regular_maintenance_view.dart';
import '../../feature/repairing_electrical_faults/presentation/views/repairing_electrical_faults.dart';
import '../../feature/repairing_mechanical_faults/presentation/views/repairing_mechanical_faults.dart';
import '../../feature/tool_rental/presentation/views/tool_rental .dart';

class AppRouter {
  // تأكد من أن نوع الإرجاع هنا هو 'Widget' بشكل صريح
  static Widget buildRoute(String routeName, Object? arguments) {
    switch (routeName) {
      case Routes.homeView:
        return const HomeView();
      case Routes.profileView:
        // إذا كان هناك arguments، قم بتمريرها هنا
        // final userId = (arguments as Map<String, dynamic>?)?['userId'];
        return const ProfileView(); // أو ProfileView(userId: userId)
      case Routes.notificationView:
        return const NotificationView();
      case Routes.offersView:
        return const OffersView();
      case Routes.registrationView:
       return const RegistrationView();
       /* return BlocProvider(
        create: ( context)=> AuthCubit(),
        child: const RegistrationView());
        */
      case Routes.onboardingView:
        return const OnboardingView();
      case Routes.addNewCarView:
        return const AddNewCarsView();
      case Routes.carsRegister:
        // قد تحتاج لتمرير بيانات هنا إذا كانت هذه الشاشة تتطلب ذلك
        return const CarsRegister();
      case Routes.forgetPasswordView:
        return const ForgetPasswordView();
      case Routes.layoutView:
        return const LayoutView();
      case Routes.connectUsView:
        return const ConnectUsView();
       case Routes.regularMaintenanceView:
        return BlocProvider(
          
          create: (context) => RegularServicesCubit(RegularMaintenanceRepo()),
          child: const RegularMaintenanceView(),
        );
      case Routes.repairingMechanicalFaultsView:
        return const RepairingMechanicalFaultsView();
      case Routes.repairingElectricalFaultsView:
        return const RepairingElectricalFaults();
      case Routes.repairingAutoBodyView:
        return const RepairingAutoBodyView();
      case Routes.otherServicesView:
        return const OtherServicesView();
      case Routes.sellingOriginalPartsView:
        return const SellingOriginalPartsView();
      case Routes.carRentalView:
        return const CarRentalView();
      case Routes.toolRentalView:
        return const ToolRentalView();
      case Routes.splashView:
        return const SplashView();
      // افتراضي: CarsRegisterView
      // أضف كل المسارات الأخرى هنا
      default:
        // دائمًا يجب أن تُرجع Widget حتى في حالة الخطأ
        return Scaffold(
          body: Center(
            child: Text('Error: Route not found $routeName.'),
          ),
        );
    }
  }

  Route generateRoute(RouteSettings settings) {
    // استخدم الدالة الثابتة buildRoute هنا
    return MaterialPageRoute(
      builder: (_) => AppRouter.buildRoute(settings.name!, settings.arguments),
    );
  }
}
*/

// lib/core/routing/app_router.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Auth
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد BlocProvider
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/cubit/selling_cubit.dart';

// استيراد جميع الشاشات التي تحتاجها
import 'package:mechpro/feature/auth/presintation/views/registaration_view.dart';
import 'package:mechpro/feature/home/presentation/views/home_view.dart';
import 'package:mechpro/feature/notifications/presentation/views/notification_view.dart';
import 'package:mechpro/feature/offers/presentation/views/offers.dart';
import 'package:mechpro/feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:mechpro/feature/orders/presentation/views/orders_view.dart';
import 'package:mechpro/feature/other_services/presentation/views/other_services.dart';
import 'package:mechpro/feature/profile/presentation/views/profile_view.dart';
import 'package:mechpro/core/routing/routes.dart';

import '../../feature/Selling_ original_spare parts/presentation/views/Selling _original _spare_ parts.dart';
import '../../feature/auth/presintation/views/forget_password_view.dart';
import '../../feature/auto_body_repair/presentation/views/auto_body_repair.dart';
import '../../feature/car_rental/presentation/views/car_rental.dart';
import '../../feature/cars_registration/presentation/views/add_new_car.dart';
import '../../feature/cars_registration/presentation/views/cars_registration.dart';
import '../../feature/connect_us/presentation/views/connect_us.dart';
import '../../feature/emergency_situations/presentation/views/emergency_view.dart';
import '../../feature/intro/presentation/views/splash_view.dart';
import '../../feature/layout/layout_view.dart';
import '../../feature/regular_maintenance/data/repo/regular_repo.dart';
import '../../feature/regular_maintenance/presentation/cubit/regular_services_cubit.dart';
import '../../feature/regular_maintenance/presentation/views/regular_maintenance_view.dart';
import '../../feature/repairing_electrical_faults/presentation/views/repairing_electrical_faults.dart';
import '../../feature/repairing_mechanical_faults/presentation/views/repairing_mechanical_faults.dart';
import '../../feature/tool_rental/presentation/views/tool_rental .dart';

// استيراد AuthCubit
import '../../feature/auth/presintation/cubit/auth_cubit.dart';

class AppRouter {
  // دالة ثابتة لبناء الـ Widget بناءً على اسم المسار
  static Widget buildRoute(String routeName, Object? arguments) {
    switch (routeName) {
      case Routes.homeView:
        return const HomeView();
      case Routes.profileView:
        return const ProfileView();
      case Routes.notificationView:
        return const NotificationView();
      case Routes.offersView:
        return const OffersView();
      case Routes.registrationView:
        // هنا يجب أن يتم توفير AuthCubit لشاشة RegistrationView
        // تأكد أنك بتوفر AuthCubit هنا عشان الشاشة تقدر تستخدمه
        return BlocProvider(
          create: (context) =>
              AuthCubit(FirebaseAuth.instance), // مرر FirebaseAuth.instance
          child: const RegistrationView(),
        );
      case Routes.onboardingView:
        return const OnboardingView();
      case Routes.addNewCarView:
        return const AddNewCarsView();
      case Routes.carsRegister:
        return const CarsRegister();
      case Routes.forgetPasswordView:
        return const ForgetPasswordView();
      case Routes.layoutView:
        return const LayoutView();
      case Routes.connectUsView:
        return const ConnectUsView();
      case Routes.regularMaintenanceView:
        return BlocProvider(
          create: (context) => RegularServicesCubit(RegularMaintenanceRepo()),
          child: const RegularMaintenanceView(),
        );
      case Routes.repairingMechanicalFaultsView:
        return const RepairingMechanicalFaultsView();
      case Routes.repairingElectricalFaultsView:
        return const RepairingElectricalFaults();
      case Routes.repairingAutoBodyView:
        return const RepairingAutoBodyView();
      case Routes.otherServicesView:
        return const OtherServicesView();

      case Routes.sellingOriginalPartsView:
        return BlocProvider(
          create: (context) => SellingCubit(),
          child: const SellingOriginalPartsView(),
        );



      case Routes.emergencyView:
        return const EmergencyView();
      case Routes.ordersView:
        return const OrdersView();
      case Routes.carRentalView:
        return const CarRentalView();
      case Routes.toolRentalView:
        return const ToolRentalView();
      case Routes.splashView:
        return const SplashView();
      default:
        return Scaffold(
          body: Center(
            child: Text('Error: Route not found $routeName.'),
          ),
        );
    }
  }


  Route generateRoute(RouteSettings settings) {
    // التحقق من حالة المستخدم الحالي من Firebase Auth
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

    // المسار الذي يحاول المستخدم الوصول إليه
    final String routeName = settings.name ?? '/'; // افتراضيًا المسار الجذر

    // شاشات المصادقة (لا تتطلب تسجيل دخول)
    final bool isAuthScreen = routeName == Routes.registrationView ||
        routeName == Routes.forgetPasswordView ||
        routeName == Routes.onboardingView ||
        routeName == Routes.splashView ||
        routeName == Routes.emergencyView; // أضف SplashView هنا

    // المنطق الأساسي للتوجيه:
    // إذا كان المستخدم غير مسجل دخول (notLoggedIn) ويحاول الوصول لشاشة تتطلب تسجيل دخول (ليست شاشة مصادقة)
    if (!isLoggedIn && !isAuthScreen) {
      // وجهه لشاشة التسجيل/الدخول
      return MaterialPageRoute(
        builder: (_) => AppRouter.buildRoute(Routes.registrationView, null),
        settings: const RouteSettings(name: Routes.registrationView),
      );
    }

    // إذا كان المستخدم مسجل دخول (isLoggedIn) ويحاول الوصول لشاشة مصادقة
    // (يعني بيحاول يروح لشاشة التسجيل/الدخول وهو بالفعل مسجل دخول)
    if (isLoggedIn && isAuthScreen) {
      // وجهه للشاشة الرئيسية
      return MaterialPageRoute(
        builder: (_) => AppRouter.buildRoute(Routes.layoutView, null),
        settings: const RouteSettings(name: Routes.layoutView),
      );
    }

    // في أي حالة أخرى، قم ببناء المسار المطلوب بشكل طبيعي
    return MaterialPageRoute(
      builder: (_) => AppRouter.buildRoute(routeName, settings.arguments),
      settings: settings, // احتفظ بالـ settings الأصلية
    );
  }
}
