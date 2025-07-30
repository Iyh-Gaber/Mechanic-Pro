import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

class RichTextPart extends StatelessWidget {
  const RichTextPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: LocaleKeys.Welcometothe.tr(),
            style: getSmallStyle( ),
          ),
          TextSpan(
            text: LocaleKeys.MechanicPro.tr(),
            style: getBodyStyle(
              color: AppColors.primaryColor,
              fontSize: 18.sp,
            ),
          ),
          TextSpan(
            text: LocaleKeys.platform.tr(),
            style: getSmallStyle(),
          ),
        ],
      ),
    );
  }
}
