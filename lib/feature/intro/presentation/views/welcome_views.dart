import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/utils/manage_padding.dart';
import 'package:mechpro/feature/intro/presentation/widgets/header_row.dart';
import 'package:mechpro/feature/intro/presentation/widgets/rich_text_part.dart';
import '../../../../core/routing/app_router.dart';

import '../../../../core/translate/locale_keys.g.dart';

import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_button.dart';

class WelcomeViews extends StatelessWidget {
  const WelcomeViews({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
     
       
       
       
        body: Padding(
        
         padding: 17.all,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  HeaderRow(),


              Gap(155),
              Image.asset(
                AppAssets.logoIcon,
                fit: BoxFit.cover,
                height: 70.h,
                width: 70.w,
              ),
              Gap(37),
          
              RichTextPart(),
              Text(
                LocaleKeys.symbol.tr(),
                textAlign: TextAlign.center,
                style: getSmallStyle(fontSize: 15.sp),
              ),
              Spacer(),
              CustomButton(
                text: LocaleKeys.welcomeButtom.tr(),
                onpressed: () {
                  context.pushAndRemoveUntil(
                    Routes.onboardingView,
                    routeBuilder: AppRouter.buildRoute,
                    predicate: (route) => false,
                  );
                },
              ),
              Gap(27),
            ],
          ),
        ),
      ),
    );
  }
}
