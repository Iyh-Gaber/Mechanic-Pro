import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/feature/home/presentation/widgets/new_services.dart';

class FutureServicesPart extends StatelessWidget {
  const FutureServicesPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
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
          name: 'Manage Services History',
          image: AppAssets.manageSer,
        ),
      ],
    );
  }
}
