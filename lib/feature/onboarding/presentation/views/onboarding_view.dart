import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/app_assets.dart';

import 'package:mechpro/core/utils/app_color.dart';

import 'package:mechpro/feature/onboarding/presentation/widgets/page_view_custom.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';



class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: [
                  PageViewCustom(
                    image: AppAssets.locationWorkShop,
                    title: LocaleKeys.MobileWorkshop.tr(),
                    bodytitle: LocaleKeys.titleMobileWorkshop.tr(),
                  ),
                  PageViewCustom(
                    image: AppAssets.expressWorkShop,
                    title: LocaleKeys.Express.tr(),
                    bodytitle: LocaleKeys.Expresstitle.tr(),
                  ),
                  PageViewCustom(
                    image: AppAssets.service3,
                    title: LocaleKeys.Specialized.tr(),
                    bodytitle: LocaleKeys.Specializedtitle.tr(),
                  ),
                ],
              ),
            ),
            Gap(33),
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                radius: 5,
                activeDotColor: AppColors.primaryColor,
                dotHeight: 5,
                dotWidth: 9,
                spacing: 3,
              ),
            ),
            47.verticalSpace,
            SmallButtom(context),
          ],
        ),
      ),
    );
  }

  Row SmallButtom(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor)),
          onPressed: () {
            context.pushAndRemoveUntil(
              Routes.registrationView,
              routeBuilder: AppRouter.buildRoute, // تمرير الدالة كـ callback
              predicate: (route) => false,
              // context.pushAndRemoveUntil(RegistrationView());
            );
          },
          child: Text(
            LocaleKeys.skip.tr(),
            style: getSmallStyle(color: AppColors.whColor),
          ),
        ),
        Spacer(),
        TextButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor)),
          onPressed: () {
            if (controller.page != 2) {
              controller.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            } else {
             // context.pushAndRemoveUntil(RegistrationView, routeBuilder: (String , Object? ) {  });
              context.pushAndRemoveUntil(
                Routes.registrationView,
                routeBuilder: AppRouter.buildRoute, // تمرير الدالة كـ callback
                predicate: (route) => false,
                // context.pushAndRemoveUntil(RegistrationView());
              );

            }
          },
          child: Icon(Icons.arrow_forward, color: AppColors.whColor),
        ),
      ],
    );
  }
}
