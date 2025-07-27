/*import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/home/presentation/widgets/app_bar_home.dart';
import 'package:mechpro/feature/home/presentation/widgets/core_services_part.dart';
import 'package:mechpro/feature/home/presentation/widgets/emergency_button.dart';

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
  Widget build(BuildContext context) {
   
    return SafeArea(

      
      child: Scaffold(
        appBar: AppBarHome(),


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
                FutureWorkServices(),
                7.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    LocaleKeys.CoreServices.tr(),
                    style: getSmallStyle(color: AppColors.blackColor),
                  ),
                ),
                16.verticalSpace,
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

/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // <--- تم إضافة هذا الاستيراد

import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/home/data/repo/main_services_repo.dart';
import 'package:mechpro/feature/home/presentation/widgets/app_bar_home.dart';
import 'package:mechpro/feature/home/presentation/widgets/core_services_part.dart';
import 'package:mechpro/feature/home/presentation/widgets/emergency_button.dart';

import 'package:mechpro/feature/home/presentation/widgets/future_work_services.dart';

import 'package:mechpro/feature/home/presentation/widgets/offer_banner.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/text_style.dart';
import '../cubit/main_services_cubit.dart'; // تأكد من أن هذا المسار صحيح لـ MainServicesCubit

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
        appBar: AppBarHome(),
        // هنا نضيف BlocProvider لجعل MainServicesCubit متاحًا لجميع الأبناء
        body: BlocProvider<MainServicesCubit>( // <--- تم إضافة BlocProvider هنا
          create: (context) => MainServicesCubit(MainServicesRepo()), // هنا يتم إنشاء مثيل من MainServicesCubit
          child: Container(
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
                  FutureWorkServices(),
                  7.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      LocaleKeys.CoreServices.tr(),
                      style: getSmallStyle(color: AppColors.blackColor),
                    ),
                  ),
                  16.verticalSpace,
                  CoreServicesPart(), // هذا الـ Widget الآن يمكنه الوصول إلى MainServicesCubit
                ],
              ),
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
import 'package:flutter_bloc/flutter_bloc.dart'; // لا يزال مطلوبًا للاستخدام في initState

import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/home/presentation/widgets/app_bar_home.dart';
import 'package:mechpro/feature/home/presentation/widgets/core_services_part.dart';
import 'package:mechpro/feature/home/presentation/widgets/emergency_button.dart';

import 'package:mechpro/feature/home/presentation/widgets/future_work_services.dart';

import 'package:mechpro/feature/home/presentation/widgets/offer_banner.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/text_style.dart';
import '../cubit/main_services_cubit.dart';
import '../cubit/main_services_states.dart';

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

                //  EmergencyButton(),
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
