
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
          context.pushNamed(Routes.profileView);
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
