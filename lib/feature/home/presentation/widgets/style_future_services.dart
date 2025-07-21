// في ملف: lib/feature/home/presentation/widgets/new_services.dart
/*
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/text_style.dart';

class NewServicesItem extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback? onTap;
  final TextStyle? textStyle;

  const NewServicesItem({
    super.key,
    required this.name,
    required this.image,
    this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // يمكنك إزالة جمل الطباعة هذه الآن بعد أن تأكدنا من عمل الستايل
    // print('NewServicesItem: Name = $name');
    // print('NewServicesItem: textStyle passed = $textStyle');
    // print('NewServicesItem: getBodyStyle() returns = ${getBodyStyle()}'); 
    // print('NewServicesItem: Final style applied = ${textStyle ?? getBodyStyle()}');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 60,
              height: 60,
            ),
            10.verticalSpace,
            // <--- التعديل هنا: لف الـ Text بـ Flexible
            Flexible( 
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: textStyle ?? getSmallStyle(),
                maxLines: 3, // يمكنك تحديد أقصى عدد من الأسطر للسماح بالالتفاف
                overflow: TextOverflow.ellipsis, // يضيف "..." إذا تجاوز النص عدد الأسطر
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
