import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero, // إزالة الهامش الافتراضي للـ Card
      child: InkWell(
        // لجعل البطاقة قابلة للضغط
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Row(
            children: [
              Icon(icon, size: 30, color: AppColors.whColor),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getSmallStyle(
                      color: AppColors.whColor,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                  4.verticalSpace,
                  Text(
                    subtitle,
                    style: getSmallStyle(color: AppColors.bgColor),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.whColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
