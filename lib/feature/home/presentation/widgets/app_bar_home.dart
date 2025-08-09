/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/app_color.dart';

import '../../../../core/routing/routes.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.pushNamed(Routes.profileView);
          //context.pushTo(ProfileView());
        },
        icon: Icon(
          Icons.person_pin_circle_outlined,
          color: AppColors.primaryColor,
        ),
        iconSize: 37,
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.pushNamed(Routes.notificationView);
          },
          icon: Icon(Icons.notifications_none, color: AppColors.primaryColor),
          iconSize: 33,
        ),
        IconButton(
          onPressed: () {
            context.pushNamed(Routes.offersView);
          },
          icon: Icon(Icons.local_offer_outlined, color: AppColors.primaryColor),
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/app_color.dart';

import '../../../../core/routing/routes.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  // تم إضافة هذا المتغير لاستقبال عدد الإشعارات غير المقروءة
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
      actions: [
        // هنا تم استخدام Stack لعرض العداد فوق الأيقونة
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
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$unreadNotificationsCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
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
