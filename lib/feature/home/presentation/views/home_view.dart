import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/home/presentation/widgets/app_bar_home.dart';
import 'package:mechpro/feature/home/presentation/widgets/emergency_button.dart';

import 'package:mechpro/feature/home/presentation/widgets/new_services.dart';
import 'package:mechpro/feature/home/presentation/widgets/offer_banner.dart';
import 'package:mechpro/feature/home/presentation/widgets/service_list_item.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/text_style.dart';




class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:

            AppBarHome(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.whColor,
                AppColors.primaryColor,
              ],
              stops: [0.61, 0.3],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OfferBanner(),

                7.verticalSpace,
                EmergencyButton(),
                7.verticalSpace,
                SizedBox(
                  height: 77,
                  child: ListView(
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
                  ),
                ),
                7.verticalSpace,
              
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    LocaleKeys.CoreServices.tr(),
                    style: getSmallStyle(color: AppColors.blackColor),
                  ),
                ),
                16.verticalSpace,
             
             
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      ServiceListItem(
                        icon: Icons.car_repair,
                        title: 'Regular Maintenance',
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
