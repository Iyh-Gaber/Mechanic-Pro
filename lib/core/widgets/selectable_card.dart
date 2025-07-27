// lib/core/widgets/selectable_card.dart

import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart'; // تأكد من المسار الصحيح لملف الألوان

class SelectableCard extends StatelessWidget {
  final Widget child; // المحتوى الداخلي للبطاقة (أي Widget)
  final bool isSelected; // هل البطاقة مختارة أم لا
  final VoidCallback onTap; // الوظيفة عند الضغط على البطاقة
  final Color? selectedColor; // لون الخلفية عند الاختيار
  final Color? unselectedColor; // لون الخلفية عند عدم الاختيار
  final Color? shadowColor; // لون الظل

  const SelectableCard({
    super.key,
    required this.child,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = AppColors.primaryColor, // الافتراضي هو اللون الأساسي
    this.unselectedColor = AppColors.whColor, // الافتراضي هو الأبيض
    this.shadowColor, // الافتراضي سيأتي من BoxShadow
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? AppColors.blackColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child, // هنا نضع المحتوى الذي تم تمريره
      ),
    );
  }
}
