// lib/core/widgets/section_header.dart

import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart'; // تأكد من المسار الصحيح لملف الألوان
import 'package:mechpro/core/utils/text_style.dart'; // تأكد من المسار الصحيح لملف أنماط النص

class SectionHeader extends StatelessWidget {
  final String title; // عنوان القسم
  final String? leadingText; // نص يظهر على اليسار (مثل الرقم '1')
  final IconData? leadingIcon; // أيقونة تظهر على اليسار (بديل للنص)
  final double titleFontSize; // حجم خط العنوان
  final Color titleColor; // لون العنوان
  final Color leadingColor; // لون النص أو الأيقونة على اليسار
  final double leadingSize; // حجم النص أو الأيقونة على اليسار
  final double spacing; // المسافة بين العنصر الأيسر والعنوان

  const SectionHeader({
    super.key,
    required this.title,
    this.leadingText,
    this.leadingIcon,
    this.titleFontSize = 20,
    this.titleColor = AppColors.blackColor,
    this.leadingColor = AppColors.blackColor, // لون النص/الأيقونة داخل الدائرة
    this.leadingSize = 16, // حجم النص داخل الدائرة
    this.spacing = 10,
  }) : assert(
         leadingText != null || leadingIcon != null,
         'Either leadingText or leadingIcon must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // العنصر الأيسر (رقم أو أيقونة)
        Container(
          width: 27,
          height: 27,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.bgColor],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: leadingText != null
                ? Text(
                    leadingText!,
                    style: getSmallStyle(
                      color: leadingColor,
                      fontSize: leadingSize,
                    ),
                  )
                : Icon(leadingIcon, color: leadingColor, size: leadingSize + 5),
          ),
        ),
        SizedBox(width: spacing),
        // عنوان القسم
        Text(
          title,
          style: getSmallStyle(color: titleColor, fontSize: titleFontSize),
        ),
      ],
    );
  }
}
