import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/app_color.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row( 
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
      children: [
    
    GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.emergencyView);
                },
                child: Image.asset(
                  AppAssets.iconEmrg,
                  //  fit: BoxFit.cover,
                  height: 25.h,
                  width: 25.w,
                ),
              ),
    
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
                    width: 25.h,
                    height: 25.w,
                  ),
                ),
    
    
    
    ],);
  }
}
