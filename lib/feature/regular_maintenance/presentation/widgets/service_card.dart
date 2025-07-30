
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/datumRegular.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';
import 'package:mechpro/feature/repairing_electrical_faults/data/models/response/electrical_response/datum_electrical.dart';
import 'package:mechpro/feature/auto_body_repair/data/models/response/auto_body_response/datum_auto_body.dart';
import 'package:mechpro/feature/other_services/data/models/response/other_services_response/datum_other_services.dart'; // **تم الإضافة**

class ServiceCard<T> extends StatelessWidget {
  final T service;
  final bool isSelected;
  final IconData icon;

  const ServiceCard({
    Key? key,
    required this.service,
    required this.isSelected,
    required this.icon,
  }) : super(key: key);

  String? _getServiceName() {
    if (service is DatumMechanical) {
      return (service as DatumMechanical).subServiceName;
    } else if (service is DatumRegular) {
      return (service as DatumRegular).subServiceName;
    } else if (service is DatumElectrical) {
      return (service as DatumElectrical).subServiceName;
    } else if (service is DatumAutoBody) {
      return (service as DatumAutoBody).subServiceName;
    } else if (service is DatumOtherServices) {
      // **تم الإضافة**
      return (service as DatumOtherServices).subServiceName;
    }
    return null;
  }

  String? _getServiceDescription() {
    if (service is DatumMechanical) {
      return (service as DatumMechanical).description;
    } else if (service is DatumRegular) {
      return (service as DatumRegular).description;
    } else if (service is DatumElectrical) {
      return (service as DatumElectrical).description;
    } else if (service is DatumAutoBody) {
      return (service as DatumAutoBody).description;
    } else if (service is DatumOtherServices) {
      // **تم الإضافة**
      return (service as DatumOtherServices).description;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final serviceName = _getServiceName() ?? 'Service Name N/A';
    final serviceDescription =
        _getServiceDescription() ?? 'No description available';

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : AppColors.bgColor,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.bgColor,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? AppColors.primaryColor : AppColors.bgColor,
            ),
            10.verticalSpace,
            Text(
              serviceName,
              textAlign: TextAlign.center,
              style: getSmallStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.blackColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            10.verticalSpace,
            Expanded(
              child: Text(
                serviceDescription,
                textAlign: TextAlign.center,
                style: getSmallStyle(
                  fontSize: 15.0,
                  color: isSelected
                      ? AppColors.primaryColor.withOpacity(0.8)
                      : AppColors.grColor,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
