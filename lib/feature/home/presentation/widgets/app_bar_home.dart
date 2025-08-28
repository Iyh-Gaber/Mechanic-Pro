/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/location_button_widget.dart';

import '../../../../core/routing/routes.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
 
  final int unreadNotificationsCount;

  const AppBarHome({
    super.key,
    required this.unreadNotificationsCount,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
         // context.pushNamed(Routes.profileView);
        },
        icon: const Icon(
          Icons.person_pin_circle_outlined,
          color: AppColors.primaryColor,
        ),
        iconSize: 37,
      ),

   // title: LocationButtonWidget() ,


      actions: [
       
        Stack(
          children: [
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.notificationView);
              },
              icon: const Icon(Icons.notifications_none, color: AppColors.primaryColor),
              iconSize: 33,
            ),
            if (unreadNotificationsCount > 0)
              Positioned(
                right: 10,
                top: 7,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$unreadNotificationsCount',
                    style: getSmallStyle(color: Colors.white, fontSize: 10.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          onPressed: () {
            context.pushNamed(Routes.offersView);
          },
          icon: const Icon(Icons.local_offer_outlined, color: AppColors.primaryColor),
        ),
        10.horizontalSpace,
      ],
      backgroundColor: AppColors.whColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // لإضافة خدمة النسخ
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

import '../../../../core/routing/routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// الدالة المستقلة التي أنشأتها مسبقًا للحصول على العنوان
Future<Placemark?> getLocationAddress() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: 'ar_EG',
    );

    if (placemarks.isNotEmpty) {
      return placemarks.first;
    }
    return null;
  } catch (e) {
    print('there is an error to get location $e');
    return null;
  }
}

// الـ Widget الذي يحتوي على الـ AppBar
class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final int unreadNotificationsCount;

   AppBarHome({
    super.key,
    required this.unreadNotificationsCount,
  });

  // دالة لعرض Dialog مع الموقع
  void _showLocationDialog(BuildContext context) async {
    // 1. عرض Dialog تحميل مؤقت
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  AlertDialog(
          backgroundColor: AppColors.bgColor,
          content: Row(
            children: [
              CircularProgressIndicator(color: AppColors.primaryColor,),
              SizedBox(width: 20),
              Text("getting location...",style: getSmallStyle(color: AppColors.primaryColor,),),
            ],
          ),
        );
      },
    );

    // 2. الحصول على العنوان
    final placemark = await getLocationAddress();

    // 3. إخفاء Dialog التحميل
    Navigator.of(context).pop();

    if (placemark != null) {
      // 4. بناء العنوان الكامل
      String fullAddress = '${placemark.country}, ${placemark.locality}, ${placemark.street}';

      // 5. إظهار Dialog بالبيانات والزر
      showDialog(
        
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.bgColor,
            title:  Text(' Your Current Location',style: getSmallStyle(color: AppColors.primaryColor,),),
            content: Text(fullAddress),
            actions: [
              TextButton(
                onPressed: () {
                  // نسخ العنوان إلى الحافظة
                  Clipboard.setData(ClipboardData(text: fullAddress));
                  Navigator.of(context).pop(); // إغلاق الـ Dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    
                     SnackBar(
                      backgroundColor: AppColors.primaryColor,
                      content: Text('Copy The Address Successfully',style: getSmallStyle(color: AppColors.whColor,)),),
                  );
                },
                child:  Text('Copy',style: getSmallStyle(color: AppColors.primaryColor,)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق الـ Dialog
                },
                child:  Text('Close',style: getSmallStyle(color: AppColors.primaryColor,)),
              ),
            ],
          );
        },
      );
    } else {
      // 6. إظهار Dialog في حالة الفشل
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text('Error',style: getSmallStyle(color: AppColors.whColor,)),
            content:  Text('Failed to get location.',style: getSmallStyle(color: AppColors.whColor,)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:  Text('Accept',style: getSmallStyle(color: AppColors.whColor,),),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        // 7. ربط الأيقونة بالدالة الجديدة
        onPressed: () => _showLocationDialog(context),
        icon: const Icon(
          Icons.person_pin_circle_outlined,
          color: AppColors.primaryColor,
        ),
        iconSize: 37,
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.notificationView);
              },
              icon: const Icon(Icons.notifications_none, color: AppColors.primaryColor),
              iconSize: 33,
            ),
            if (unreadNotificationsCount > 0)
              Positioned(
                right: 10,
                top: 7,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$unreadNotificationsCount',
                    style: getSmallStyle(color: Colors.white, fontSize: 10.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          onPressed: () {
            context.pushNamed(Routes.offersView);
          },
          icon: const Icon(Icons.local_offer_outlined, color: AppColors.primaryColor),
        ),
        10.horizontalSpace,
      ],
      backgroundColor: AppColors.whColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}