import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/app_color.dart';

import '../../../../core/routing/routes.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({
    super.key,
  });

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
          icon: Icon(
            Icons.notifications_none,
            color: AppColors.primaryColor,
          ),
          iconSize: 33,
        ),
        IconButton(
          onPressed: () {
            context.pushNamed(Routes.offersView);
          },
          icon: Icon(
            Icons.local_offer_outlined,
            color: AppColors.primaryColor,
          ),
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
