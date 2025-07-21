import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.bgColor,
            child: Icon(
              icon,
              size: 35,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        8.verticalSpace,
        Text(
          label,
          style: getSmallStyle()
        ),
      ],
    );
  }
}
