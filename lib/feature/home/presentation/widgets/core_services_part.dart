/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/feature/home/data/models/response/main_services_response/main_services_response.dart';
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';
import 'package:mechpro/feature/home/presentation/widgets/service_list_item.dart';

import '../../../../core/utils/app_color.dart';
import '../../data/models/response/main_services_response/datum.dart';
import '../../data/models/response/main_services_response/main_services_response.dart';
import '../cubit/main_services_cubit.dart';

class CoreServicesPart extends StatelessWidget {
  const CoreServicesPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MainServicesCubit, MainServicesStates>(
          builder: (context, state) {
        if (state is! MainServicesSuccessState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }
        List<Datum>? services = context.read<MainServicesCubit>().mainServicesResponse?.data!.first.serviceName??[];
      //  List<Datum> mainServices = state.MainServicesResponse.data!.mainServices!;
      //  List<> mainServices = state.mainServicesResponse.data!.mainServices!;
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            ServiceListItem(
              icon: Icons.car_repair,
              title: services.toString(),
            //  title: 'Regular Maintenance',
              onTap: () {
                context.pushNamed((Routes.profileView));
              },
            ),
            SizedBox(height: 12),
            ServiceListItem(
              icon: Icons.settings,
              title: 'Mechanical Fault Repairs',
            ),
            12.verticalSpace,
            ServiceListItem(
              icon: Icons.electrical_services,
              title: 'Electrical Fault Repairs',
            ),
            12.verticalSpace,
            ServiceListItem(
              icon: Icons.car_crash,
              title: 'Auto Body Repair',
            ),
            12.verticalSpace,
            ServiceListItem(
              icon: Icons.local_car_wash,
              title: 'Other Services',
            ),
            12.verticalSpace,
          ],
        );
      }),
    );
  }
}
*/

/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart';
// import 'package:mechpro/feature/home/data/models/response/main_services_response/main_services_response.dart'; // هذا الاستيراد غير ضروري هنا
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';
import 'package:mechpro/feature/home/presentation/widgets/service_list_item.dart';

import '../../../../core/utils/app_color.dart';
import '../../data/models/response/main_services_response/datum.dart';
// import '../../data/models/response/main_services_response/main_services_response.dart'; // هذا الاستيراد غير ضروري هنا
import '../cubit/main_services_cubit.dart';

class CoreServicesPart extends StatelessWidget {
  const CoreServicesPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MainServicesCubit, MainServicesStates>(
        builder: (context, state) {
          if (state is MainServicesLoadingState) { // حالة التحميل
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is MainServicesErrorState) { // حالة الخطأ
            return Center(
              child: Text('Error: ${state.message}'), // عرض رسالة الخطأ
            );
          } else if (state is MainServicesSuccessState) {
           
            final MainServicesCubit cubit = context.read<MainServicesCubit>();
            List<Datum>? services = cubit.mainServicesResponse?.data; // هنا ستحصل على List<Datum>


            // تأكد أن services ليست null قبل استخدامها
            if (services == null || services.isEmpty) {
              return Center(
                child: Text('No services found.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final Datum service = services[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0), // مسافة بين العناصر
                  child: ServiceListItem(
                    icon: Icons.miscellaneous_services, // يمكنك تغيير الأيقونات حسب نوع الخدمة
                    title: service.serviceName ?? 'Unknown Service', // عرض اسم الخدمة
                    onTap: () {
                      // يمكنك تمرير بيانات الخدمة للصفحة التالية إذا احتجت
                      context.pushNamed(Routes.profileView);
                    },
                  ),
                );
              },
            );
          }
          // fallback for initial state if needed, or if no state matches
          return const SizedBox.shrink(); // أو أي widget مناسب للحالة الأولية
        },
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';
import 'package:mechpro/feature/home/presentation/widgets/service_list_item.dart';

import '../../../../core/utils/app_color.dart';
import '../../data/models/response/main_services_response/datum.dart';
import '../cubit/main_services_cubit.dart';

class CoreServicesPart extends StatelessWidget {
  const CoreServicesPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MainServicesCubit, MainServicesStates>(
        builder: (context, state) {
          print('CoreServicesPart BlocBuilder received state: ${state.runtimeType}');

          if (state is MainServicesInitialState || state is MainServicesLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is MainServicesErrorState) {
            print('CoreServicesPart received error state: ${state.message}');
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else if (state is MainServicesSuccessState) {
            final List<Datum>? services = state.mainServicesResponse.data;
            print('CoreServicesPart received success state. Services count: ${services?.length ?? 0}');

            if (services == null || services.isEmpty) {
              return Center(
                child: Text('No services found.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final Datum service = services[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ServiceListItem(
                    icon: Icons.miscellaneous_services,
                    title: service.serviceName ?? 'Unknown Service',
                    onTap: () {
                      context.pushNamed(Routes.profileView);
                    },
                  ),
                );
              },
            );
          }
          print('CoreServicesPart received unhandled state: ${state.runtimeType}');
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart'; // تأكد من وجود جميع المسارات هنا
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';
import 'package:mechpro/feature/home/presentation/widgets/service_list_item.dart';

import '../../../../core/utils/app_color.dart';
import '../../data/models/response/main_services_response/datum.dart';
import '../cubit/main_services_cubit.dart';

class CoreServicesPart extends StatelessWidget {
  const CoreServicesPart({
    super.key,
  });

  // تم تحديث هذه الخريطة لربط أسماء الخدمات التي قدمتها بالأيقونات والمسارات الصحيحة.
  static final Map<String, Map<String, dynamic>> _serviceConfig = {
    'Regular maintenance': {
      'icon': Icons.car_repair, // أيقونة مناسبة للصيانة الدورية
      'route': Routes.regularMaintenanceView,
    },
    'Repairing mechanical faults': {
      'icon': Icons.settings, // أيقونة مناسبة لإصلاح الأعطال الميكانيكية
      'route': Routes.repairingMechanicalFaultsView,
    },
    'Repairing electrical faults': {
      // تم تعديل الاسم ليتطابق مع ما قدمته
      'icon':
          Icons.electrical_services, // أيقونة مناسبة لإصلاح الأعطال الكهربائية
      'route': Routes.repairingElectricalFaultsView, // تم تعديل المسار
    },
    'Auto body repair': {
      // تم إضافة هذه الخدمة
      'icon': Icons.car_crash, // أيقونة مناسبة لإصلاح هيكل السيارة
      'route': Routes.repairingAutoBodyView,
    },
    'Other services': {
      // تم إضافة هذه الخدمة
      'icon': Icons.miscellaneous_services, // أيقونة عامة لخدمات أخرى
      'route': Routes.otherServicesView,
    },
    'Selling original spare parts': {
      // تم إضافة هذه الخدمة
      'icon':
          Icons.local_convenience_store_sharp, // أيقونة مناسبة لبيع قطع الغيار
      'route': Routes.sellingOriginalPartsView,
    },
    'Car rental': {
      // تم إضافة هذه الخدمة
      'icon': Icons.directions_car, // أيقونة مناسبة لتأجير السيارات
      'route': Routes.carRentalView,
    },
    'Tool rental': {
      // تم إضافة هذه الخدمة
      'icon': Icons.handyman, // أيقونة مناسبة لتأجير الأدوات
      'route': Routes.toolRentalView,
    },
    // يمكنك إضافة المزيد من الخدمات هنا إذا كانت موجودة في الـ API الخاص بك
    // مع أيقونات ومسارات مناسبة
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MainServicesCubit, MainServicesStates>(
        builder: (context, state) {
          print(
              'CoreServicesPart BlocBuilder received state: ${state.runtimeType}');

          if (state is MainServicesInitialState ||
              state is MainServicesLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.whColor,
              ),
            );
          } else if (state is MainServicesErrorState) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else if (state is MainServicesSuccessState) {
            final List<Datum>? services = state.mainServicesResponse.data;

            if (services == null || services.isEmpty) {
              return Center(
                child: Text('No services found.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final Datum service = services[index];
                final String serviceName = service.serviceName ?? '';

                // البحث عن إعدادات الخدمة في الخريطة
                final Map<String, dynamic>? config =
                    _serviceConfig[serviceName];

                // تحديد الأيقونة: إذا وجدت في الخريطة، استخدمها، وإلا استخدم أيقونة افتراضية
                final IconData icon =
                    config?['icon'] ?? Icons.miscellaneous_services;

                // تحديد المسار: إذا وجد في الخريطة، استخدمه، وإلا استخدم مسار افتراضي
                final String routeName = config?['route'] ??
                    Routes
                        .homeView; // مسار افتراضي إذا لم يتم العثور على الخدمة في الخريطة

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ServiceListItem(
                    icon: icon, // استخدام الأيقونة الديناميكية
                    title: serviceName, // عرض اسم الخدمة
                    onTap: () {
                      // الانتقال إلى المسار المحدد ديناميكيًا
                      context.pushNamed(routeName);
                      print(
                          'Navigating to: $routeName for service: $serviceName');
                    },
                  ),
                );
              },
            );
          }
          print(
              'CoreServicesPart received unhandled state: ${state.runtimeType}');
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
