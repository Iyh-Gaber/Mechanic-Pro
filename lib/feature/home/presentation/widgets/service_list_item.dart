import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart';

class ServiceListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;
  const ServiceListItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap, this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // ظل خفيف
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.black),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                   style: titleStyle,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.blackColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

