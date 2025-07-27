/*import 'package:flutter/material.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/feature/home/presentation/widgets/new_services.dart';

import '../../../../core/routing/routes.dart';
import '../../../emergency_situations/presentation/views/emergency_situations.dart';

class FutureServicesPart extends StatelessWidget {
   final TextStyle? textStyle;
  const FutureServicesPart({
    super.key, this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        NewServicesItem(
          name: 'Emergency Situation',
          image: AppAssets.iconSos,
        
          onTap: () {
           context.pushNamed(Routes.emergencyView);
          },
           
        
        ),
        NewServicesItem(
          name: 'Order Tracking',
          image: AppAssets.trackOrder,
        ),
        NewServicesItem(
          name: 'Digital Emergency Fund',
          image: AppAssets.digitalemargcy,
        ),
        NewServicesItem(
          name: 'Schedule Maintenance Appointment',
          image: AppAssets.schedualeMaintenance,
        ),
        NewServicesItem(
          name: '  locate Nearby Workshop',
          image: AppAssets.locateWorkshop,
        ),
        NewServicesItem(
          name: 'Manage Services History',onTap: () {
           // context.pushNamed(Routes.historyView);
          },
          image: AppAssets.manageSer,
        ),
      ],
    );
  }
}
*/

// في ملف: lib/feature/home/presentation/widgets/future_services_part.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/app_translate.g.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/feature/home/presentation/widgets/new_services.dart';

import '../../../../core/routing/routes.dart';
import '../../../emergency_situations/presentation/views/emergency_view.dart';

class FutureServicesPart extends StatelessWidget {
  const FutureServicesPart({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        NewServicesItem(
          name: LocaleKeys.EmergencySituation.tr(),
          image: AppAssets.iconSos,
          onTap: () {
            context.pushNamed(Routes.emergencyView);
          },
        ),
        NewServicesItem(
          name: LocaleKeys.OrderTracking.tr(),
          image: AppAssets.trackOrder,
        ),
        NewServicesItem(
          name: LocaleKeys.DigitalEmergencyFund.tr(),
          image: AppAssets.digitalemargcy,
        ),
        NewServicesItem(
          name: LocaleKeys.ScheduleMaintenanceAppointment.tr(),
          image: AppAssets.schedualeMaintenance,
        ),
        NewServicesItem(
          name: LocaleKeys.locateNearbyWorkshop.tr(),
          image: AppAssets.locateWorkshop,
        ),
        NewServicesItem(
          name: LocaleKeys.ManageServicesHistory.tr(),
          onTap: () {
            // context.pushNamed(Routes.historyView);
          },
          image: AppAssets.manageSer,
        ),
      ],
    );
  }
}
