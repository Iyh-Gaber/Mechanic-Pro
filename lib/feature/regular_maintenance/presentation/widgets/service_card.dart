/*import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';


class RegularMaintenanceView extends StatelessWidget {
  const RegularMaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: SingleChildScrollView(
  child: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
      Header(),
      HeaderServices(),
      Gap(10),
      
      
      ],),
    ),
  ),
),




    );
  }
}

class HeaderServices extends StatelessWidget {
  const HeaderServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 27,
          height: 27,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.bgColor],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
             '1',
             style: getSmallStyle(color: AppColors.whColor),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
         'Choose your services',
          style: getSmallStyle(color: AppColors.blackColor,fontSize: 20),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                
                    Expanded(
                      child: Text(
                        'Request the services',
                        style: getBodyStyle(),
                        
                        ),

                    ),
         IconButton(
                      icon: Icon(Icons.arrow_forward, color: AppColors.blackColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                 
                  ],
                ),
              );
  }
}



*/

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/datumRegular.dart';

class ServiceCard extends StatelessWidget {
  final DatumRegular service;
  final bool isSelected;
  final IconData icon;

  const ServiceCard({
    super.key,
    required this.service,
    required this.isSelected,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: isSelected ? const Color(0xFF336f67) : Colors.grey.shade300,
          width: isSelected ? 3.0 : 1.0,
        ),
      ),
      color:
          isSelected ? const Color(0xFF336f67).withOpacity(0.1) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              // Aligns the selection icon to the top right.
              alignment: Alignment.topRight,
              child: Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color:
                    isSelected ? const Color(0xFF336f67) : Colors.grey.shade400,
                size: 24,
              ),
            ),
            Icon(
              // Service icon.
              icon, // Use the passed icon
              size: 50,
              color: isSelected ? const Color(0xFF336f67) : Colors.blueGrey,
            ),
            7.verticalSpace,
            Text(
              // Service name.
              service.subServiceName ?? 'N/A', // Use subServiceName from Datum
              // textAlign: TextAlign.center,
              style: getBodyStyle(
                fontSize: 17,
                color: isSelected
                    ? const Color(0xFF336f67).withOpacity(0.7)
                    : AppColors.blackColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            4.verticalSpace,
            Text(
              // Service description.
              service.description ??
                  LocaleKeys.Nodescriptionavailable
                      .tr(), // Use description from Datum
              // textAlign: TextAlign.center,
              style: getBodyStyle(
                fontSize: 15,
                color: isSelected
                    ? const Color(0xFF336f67).withOpacity(0.7)
                    : Colors.grey.shade600,
              ),

              /*TextStyle(
                fontSize: 12.0,
                color: isSelected
                    ? const Color(0xFF336f67).withOpacity(0.7)
                    : Colors.grey.shade600,
              ),-*/
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
