
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/cubit/selling_cubit.dart';

import 'package:mechpro/feature/auth/presintation/views/registaration_view.dart';

import 'package:mechpro/feature/auto_body_repair/presentation/cubit/auto_body_cubit.dart';
import 'package:mechpro/feature/home/presentation/views/home_view.dart';

import 'package:mechpro/feature/notifications/presentation/cubit/notification_cubit.dart';
import 'package:mechpro/feature/notifications/presentation/views/notification_view.dart';

import 'package:mechpro/feature/offers/presentation/cubit/offers_cubit.dart';
import 'package:mechpro/feature/offers/presentation/views/offers_view.dart';
import 'package:mechpro/feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:mechpro/feature/orders/presentation/views/orders_view.dart';
import 'package:mechpro/feature/other_services/presentation/views/other_services.dart';
import 'package:mechpro/feature/profile/presentation/views/profile_view.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/feature/repairing_electrical_faults/data/repo/electrical_repo.dart';
import 'package:mechpro/feature/repairing_electrical_faults/presentation/cubit/electrical_cubit.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/presentation/cubit/mechanical_cubit.dart';
import 'package:mechpro/feature/tool_rental/presentation/cubit/tool_rental_cubit.dart';

import '../../feature/Selling_ original_spare parts/presentation/views/Selling _original _spare_ parts.dart';
import '../../feature/auth/presintation/views/forget_password_view.dart';
import '../../feature/auto_body_repair/presentation/views/repairing_auto_body_view.dart';
import '../../feature/car_rental/presentation/views/car_rental_view.dart';
import '../../feature/cars_registration/presentation/views/add_new_car.dart';
import '../../feature/cars_registration/presentation/views/cars_registration.dart';
import '../../feature/connect_us/presentation/views/connect_us.dart';
import '../../feature/emergency_situations/presentation/views/emergency_view.dart';
import '../../feature/intro/presentation/views/splash_view.dart';
import '../../feature/layout/layout_view.dart';
import '../../feature/notifications/presentation/widgets/notification_service.dart';
import '../../feature/other_services/presentation/cubit/other_services_cubit.dart';
import '../../feature/regular_maintenance/data/repo/regular_repo.dart';
import '../../feature/regular_maintenance/presentation/cubit/regular_services_cubit.dart';
import '../../feature/regular_maintenance/presentation/views/regular_maintenance_view.dart';
import '../../feature/repairing_electrical_faults/presentation/views/repairing_electrical_faults.dart';
import '../../feature/repairing_mechanical_faults/presentation/views/repairing_mechanical_faults.dart';
import '../../feature/tool_rental/presentation/views/tool_rental_view .dart';

import '../../feature/auth/presintation/cubit/auth_cubit.dart';
import '../../feature/car_rental/presentation/cubit/car_rental_cubit.dart';
import '../../feature/orders/data/repo/order_repo.dart';
import '../../feature/orders/presentation/cubit/orders_cubit.dart';

class AppRouter {
static Widget buildRoute(String routeName, Object? arguments) {
switch (routeName) {
case Routes.homeView:
return const HomeView();
case Routes.profileView:
return const ProfileView();
case Routes.notificationView:
return const NotificationView();

case Routes.offersView:
return MultiBlocProvider(
providers: [
BlocProvider<OffersCubit>(
create: (context) => OffersCubit(),
),
BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
),
],
child: const OffersView(),
);

case Routes.registrationView:
return BlocProvider(
create: (context) => AuthCubit(FirebaseAuth.instance),
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
return MultiBlocProvider(
providers: [
BlocProvider<RegularServicesCubit>(
create: (context) => RegularServicesCubit(RegularMaintenanceRepo()),
),
BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
),
],
child: const RegularMaintenanceView(),
);

case Routes.repairingMechanicalFaultsView:
return MultiBlocProvider(
providers: [
BlocProvider<MechanicalCubit>(
create: (context) => MechanicalCubit(),
),
BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
),
],
child: const RepairingMechanicalFaultsView(),
);

case Routes.repairingElectricalFaultsView:
return MultiBlocProvider(
providers: [
BlocProvider<ElectricalCubit>(
create: (context) => ElectricalCubit(ElectricalRepo()),
),
BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
),
],
child: const RepairingElectricalFaults(),
);

case Routes.repairingAutoBodyView:
return MultiBlocProvider(
providers: [
BlocProvider<AutoBodyCubit>(create: (context) => AutoBodyCubit()),
BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
),
],
child: const RepairingAutoBodyView(serviceName: ''),
);

case Routes.otherServicesView:
return MultiBlocProvider(
providers: [
BlocProvider<OtherServicesCubit>(
create: (context) => OtherServicesCubit(),
),
BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
),
],
child: const OtherServicesView(),
);

case Routes.sellingOriginalPartsView:
return MultiBlocProvider(
providers: [
BlocProvider<SellingCubit>(create: (context) => SellingCubit()),
BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
),
],
child: const SellingOriginalPartsView(),
);

case Routes.emergencyView:
return const EmergencyView();
case Routes.ordersView:
return BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
child: const OrdersView(),
);
case Routes.carRentalView:
return MultiBlocProvider(
providers: [
BlocProvider<CarRentalCubit>(create: (context) => CarRentalCubit()),
BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
),
],
child: const CarRentalView(),
);

case Routes.toolRentalView:
return MultiBlocProvider(
providers: [
BlocProvider<ToolRentalCubit>(
create: (context) => ToolRentalCubit(),
),
BlocProvider<OrdersCubit>(
create: (context) => OrdersCubit(OrdersRepo()),
),
],
child: const ToolRentalView(),
);

case Routes.splashView:
return const SplashView();
default:
return Scaffold(
body: Center(child: Text('Error: Route not found $routeName.')),
);
}
}

Route generateRoute(RouteSettings settings) {
final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
final String routeName = settings.name ?? '/';

final bool isAuthScreen =
routeName == Routes.registrationView ||
routeName == Routes.forgetPasswordView ||
routeName == Routes.onboardingView ||
routeName == Routes.splashView ||
routeName == Routes.emergencyView;

if (!isLoggedIn && !isAuthScreen) {
return MaterialPageRoute(
builder: (_) => AppRouter.buildRoute(Routes.registrationView, null),
settings: const RouteSettings(name: Routes.registrationView),
);
}

if (isLoggedIn && isAuthScreen) {
return MaterialPageRoute(
builder: (_) => AppRouter.buildRoute(Routes.layoutView, null),
settings: const RouteSettings(name: Routes.layoutView),
);
}

return MaterialPageRoute(
builder: (_) => AppRouter.buildRoute(routeName, settings.arguments),
settings: settings,
);
}
}