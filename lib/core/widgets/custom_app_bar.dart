// lib/core/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart'; // تأكد من المسار الصحيح لملف الألوان
import 'package:mechpro/core/utils/text_style.dart'; // تأكد من المسار الصحيح لملف أنماط النص

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading; // للتحكم في عرض زر الرجوع
  final VoidCallback?
  onLeadingPressed; // للتحكم في وظيفة زر الرجوع عند الضغط عليه

  const CustomAppBar({
    super.key, // استخدم super.key بدلاً من Key? key في الإصدارات الحديثة
    required this.title,
    this.showLeading = false, // القيمة الافتراضية: لا تظهر زر الرجوع
    this.onLeadingPressed,
  }) : assert(
         showLeading == true ? onLeadingPressed != null : true,
         'onLeadingPressed must be provided if showLeading is true',
       ); // تأكيد لضمان أن الوظيفة موجودة لو الزر هيظهر

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // إذا كانت showLeading بـ false، لن يُظهر Flutter زر الرجوع التلقائي
      automaticallyImplyLeading: showLeading,
      leading: showLeading
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.whColor),
              onPressed:
                  onLeadingPressed ??
                  () => Navigator.of(
                    context,
                  ).pop(), // استخدام وظيفة مخصصة أو الرجوع للخلف تلقائياً
            )
          : null, // لا يوجد زر رجوع إذا showLeading بـ false
      backgroundColor: AppColors.primaryColor,
      title: Text(title, style: getBodyStyle(color: AppColors.whColor)),
      centerTitle: true, // لوسيطة العنوان
      elevation: 0, // لإزالة الظل تحت الـ AppBar
    );
  }

  @override
  // تحديد ارتفاع الـ AppBar، وهو ثابت لـ AppBar الافتراضي
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
