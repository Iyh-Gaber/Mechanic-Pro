/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 

import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/home/presentation/widgets/app_bar_home.dart';
import 'package:mechpro/feature/home/presentation/widgets/core_services_part.dart';


import 'package:mechpro/feature/home/presentation/widgets/future_work_services.dart';

import 'package:mechpro/feature/home/presentation/widgets/offer_banner.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/text_style.dart';
import '../cubit/main_services_cubit.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainServicesCubit>().fetchMainServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whColor,
        appBar: AppBarHome(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.whColor, AppColors.whColor],
              stops: [0.6, 0.3],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OfferBanner(),

                
                FutureWorkServices(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    LocaleKeys.CoreServices.tr(),
                    style: getSmallStyle(color: AppColors.blackColor),
                  ),
                ),
                7.verticalSpace,
                // 16.verticalSpace,
                CoreServicesPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/home/presentation/widgets/app_bar_home.dart';
import 'package:mechpro/feature/home/presentation/widgets/core_services_part.dart';
import 'package:mechpro/feature/home/presentation/widgets/future_work_services.dart';
import 'package:mechpro/feature/home/presentation/widgets/offer_banner.dart';

import 'package:mechpro/feature/notifications/presentation/cubit/notification_cubit.dart';
import 'package:mechpro/feature/notifications/presentation/cubit/notification_state.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/text_style.dart';
import '../cubit/main_services_cubit.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // عند تشغيل الصفحة، نطلب من الـ Cubit جلب الإشعارات
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainServicesCubit>().fetchMainServices();
      // تم إضافة هذا السطر لجلب الإشعارات عند فتح الصفحة
      context.read<NotificationCubit>().fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whColor,
        // هنا تم تصحيح الخطأ باستخدام PreferredSize
        appBar: PreferredSize(
          preferredSize: AppBarHome(unreadNotificationsCount: 0).preferredSize,
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              return AppBarHome(
                unreadNotificationsCount: state.unreadCount,
              );
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.whColor, AppColors.whColor],
              stops: [0.6, 0.3],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OfferBanner(),
                const FutureWorkServices(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    LocaleKeys.CoreServices.tr(),
                    style: getSmallStyle(color: AppColors.blackColor),
                  ),
                ),
                7.verticalSpace,
                const CoreServicesPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
