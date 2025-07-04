import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.redColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car_filled, color: AppColors.whColor),
                  8.horizontalSpace,
                  Text(
                    LocaleKeys.EmergencySituations.tr(),
                    style: getSmallStyle(color: AppColors.whColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
