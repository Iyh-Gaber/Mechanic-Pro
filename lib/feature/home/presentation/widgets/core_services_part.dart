

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart'; // تأكد من وجود جميع المسارات هنا
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';
import 'package:mechpro/feature/home/presentation/widgets/service_list_item.dart';

import '../../../../core/utils/app_color.dart';
import '../../data/models/response/main_services_response/datum.dart';
import '../cubit/main_services_cubit.dart';

class CoreServicesPart extends StatelessWidget {
  const CoreServicesPart({super.key});

 
  static final Map<String, Map<String, dynamic>> _serviceConfig = {
    'Regular maintenance': {
      'icon': Icons.car_repair, 
      'route': Routes.regularMaintenanceView,
    },
    'Repairing mechanical faults': {
      'icon': Icons.settings, 
      'route': Routes.repairingMechanicalFaultsView,
    },
    'Repairing electrical faults': {
      
      'icon':
          Icons.electrical_services, 
      'route': Routes.repairingElectricalFaultsView, 
    },
    'Auto body repair': {
    
      'icon': Icons.car_crash, 
      'route': Routes.repairingAutoBodyView,
    },
    'Other services': {
      
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
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MainServicesCubit, MainServicesStates>(
        builder: (context, state) {
          print(
            'CoreServicesPart BlocBuilder received state: ${state.runtimeType}',
          );

          if (state is MainServicesInitialState ||
              state is MainServicesLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.whColor),
            );
          } else if (state is MainServicesErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is MainServicesSuccessState) {
            final List<Datum>? services = state.mainServicesResponse.data;

            if (services == null || services.isEmpty) {
              return Center(child: Text('No services found.'));
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
                final String routeName =
                    config?['route'] ??
                    Routes
                        .homeView; // مسار افتراضي إذا لم يتم العثور على الخدمة في الخريطة

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ServiceListItem(
                    icon: icon, // استخدام الأيقونة الديناميكية
                    title: serviceName, // عرض اسم الخدمة
                  titleStyle: getSmallStyle(),
                  
                    onTap: () {
                      // الانتقال إلى المسار المحدد ديناميكيًا
                      context.pushNamed(routeName);
                      print(
                        'Navigating to: $routeName for service: $serviceName',
                      );
                    },
                  ),
                );
              },
            );
          }
          print(
            'CoreServicesPart received unhandled state: ${state.runtimeType}',
          );
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
