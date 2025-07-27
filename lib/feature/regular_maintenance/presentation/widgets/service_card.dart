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
/*

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
      color: isSelected
          ? const Color(0xFF336f67).withOpacity(0.1)
          : Colors.white,
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
                color: isSelected
                    ? const Color(0xFF336f67)
                    : Colors.grey.shade400,
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
                  LocaleKeys
                      .Nodescriptionavailable.tr(), // Use description from Datum
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
*/
/*
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/datumRegular.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';

class ServiceCard<T> extends StatelessWidget {
  final T service; // الآن تقبل نوع عام
  final bool isSelected;
  final IconData icon;

  const ServiceCard({
    Key? key,
    required this.service,
    required this.isSelected,
    required this.icon,
  }) : super(key: key);

  // دالة مساعدة للحصول على اسم الخدمة، وتتعامل مع الأنواع المختلفة
  String? _getServiceName() {
    if (service is DatumMechanical) {
      return (service as DatumMechanical).subServiceName;
    } else if (service is DatumRegular) {
      return (service as DatumRegular).subServiceName;
    }
    return null; // أو يمكنك رمي خطأ إذا كان النوع غير متوقع
  }

  // دالة مساعدة للحصول على وصف الخدمة، وتتعامل مع الأنواع المختلفة
  String? _getServiceDescription() {
    if (service is DatumMechanical) {
      return (service as DatumMechanical)
          .description; // DatumMechanical تستخدم 'description'
    } else if (service is DatumRegular) {
      return (service as DatumRegular)
          .description; // DatumRegular تستخدم 'subServiceDescription'
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final serviceName = _getServiceName() ?? 'N/A Service';
    final serviceDescription =
        _getServiceDescription() ?? 'No description available';

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
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
        padding: const EdgeInsets.all(12.0),
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
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.blackColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            5.verticalSpace,
            Expanded(
              child: Text(
                serviceDescription,
                textAlign: TextAlign.center,
                style: getSmallStyle(
                  fontSize: 12.0,
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
*/
/*
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

// تأكد من استيراد كل نماذج البيانات التي يمكن أن تمررها إلى ServiceCard
import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/datumRegular.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';
import 'package:mechpro/feature/repairing_electrical_faults/data/models/response/electrical_response/datum_electrical.dart'; // ****** تم إضافة هذا الاستيراد ******

class ServiceCard<T> extends StatelessWidget {
  final T service; // الآن تقبل نوع عام
  final bool isSelected;
  final IconData icon;
  // بما أن ServiceCard يتم لفه بـ GestureDetector في الشاشة الأم،
  // فلا نحتاج لـ onTap هنا بشكل مباشر في ServiceCard نفسه.

  const ServiceCard({
    Key? key,
    required this.service,
    required this.isSelected,
    required this.icon,
  }) : super(key: key);

  // دالة مساعدة للحصول على اسم الخدمة، وتتعامل مع الأنواع المختلفة
  String? _getServiceName() {
    if (service is DatumMechanical) {
      return (service as DatumMechanical).subServiceName;
    } else if (service is DatumRegular) {
      return (service as DatumRegular).subServiceName;
    } else if (service is DatumElectrical) {
      // ****** تم إضافة هذا الشرط ******
      return (service as DatumElectrical).subServiceName;
    }
    return null; // أو يمكنك رمي خطأ إذا كان النوع غير متوقع
  }

  // دالة مساعدة للحصول على وصف الخدمة، وتتعامل مع الأنواع المختلفة
  String? _getServiceDescription() {
    if (service is DatumMechanical) {
      return (service as DatumMechanical).description;
    } else if (service is DatumRegular) {
      // DatumRegular قد تستخدم 'description' أو 'subServiceDescription'
      // بناءً على الكود الذي أرسلته سابقاً، يبدو أنها تستخدم 'description' أيضاً
      return (service as DatumRegular).description;
    } else if (service is DatumElectrical) {
      // ****** تم إضافة هذا الشرط ******
      return (service as DatumElectrical).description;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final serviceName =
        _getServiceName() ??
        'Service Name N/A'; // تم تغيير النص الافتراضي ليكون أوضح
    final serviceDescription =
        _getServiceDescription() ?? 'No description available';

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
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
        padding: const EdgeInsets.all(12.0),
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
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.blackColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            5.verticalSpace,
            Expanded(
              child: Text(
                serviceDescription,
                textAlign: TextAlign.center,
                style: getSmallStyle(
                  fontSize: 12.0,
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
*/

/*
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/datumRegular.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';
import 'package:mechpro/feature/repairing_electrical_faults/data/models/response/electrical_response/datum_electrical.dart';
import 'package:mechpro/feature/auto_body_repair/data/models/response/auto_body_response/datum_auto_body.dart'; // **تم الإضافة**

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
      // **تم الإضافة**
      return (service as DatumAutoBody).subServiceName;
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
      // **تم الإضافة**
      return (service as DatumAutoBody).description;
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
          color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
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
        padding: const EdgeInsets.all(12.0),
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
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.blackColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            5.verticalSpace,
            Expanded(
              child: Text(
                serviceDescription,
                textAlign: TextAlign.center,
                style: getSmallStyle(
                  fontSize: 12.0,
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
*/
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
    } else if (service is DatumOtherServices) { // **تم الإضافة**
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
    } else if (service is DatumOtherServices) { // **تم الإضافة**
      return (service as DatumOtherServices).description;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final serviceName = _getServiceName() ?? 'Service Name N/A';
    final serviceDescription = _getServiceDescription() ?? 'No description available';

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
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
        padding: const EdgeInsets.all(12.0),
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
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.blackColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            5.verticalSpace,
            Expanded(
              child: Text(
                serviceDescription,
                textAlign: TextAlign.center,
                style: getSmallStyle(
                  fontSize: 12.0,
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