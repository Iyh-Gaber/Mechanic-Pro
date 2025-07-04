import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/app_assets.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_button.dart';

class WelcomeViews extends StatelessWidget {
  const WelcomeViews({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                if (context.locale.toString() == 'ar') {
                  context.setLocale(Locale('en'));
                } else {
                  context.setLocale(Locale('ar'));
                }
              },
              child: SvgPicture.asset(
                AppAssets.translateSvg,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
                width: 27.h,
                height: 27.w,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Gap(177),
            Image.asset(
              AppAssets.logoIcon,
              fit: BoxFit.cover,
              height: 77.h,
              width: 77.w,
            ),
            Gap(20),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: LocaleKeys.Welcometothe.tr(),
                    style: getSmallStyle(),
                  ),
                  TextSpan(
                    text: LocaleKeys.MechanicPro.tr(),
                    style: getBodyStyle(color: AppColors.primaryColor),
                  ),
                  TextSpan(
                    text: LocaleKeys.platform.tr(),
                    style: getSmallStyle(),
                  ),
                ],
              ),
            ),
            Text(LocaleKeys.symbol.tr(),
                textAlign: TextAlign.center, style: getSmallStyle()),
            Spacer(),
            CustomButton(
              text: LocaleKeys.welcomeButtom.tr(),
              onpressed: () {
                // context.pushAndRemoveUntil(OnboardingView());
                context.pushAndRemoveUntil(
                 // Routes.onboardingView,
                  Routes.homeView,
                  routeBuilder:
                      AppRouter.buildRoute, // تمرير الدالة كـ callback
                  predicate: (route) => false,
                );
              },
            ),
            Gap(27),
          ]),
        ),
      ),
    );
  }
}
