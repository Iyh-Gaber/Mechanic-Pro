// هذا الملف (lib/shared_widgets/service_card.dart) هو "قالب الكارت"
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String serviceName; // فراغ لاسم الخدمة
  final String serviceDescription; // فراغ لوصف الخدمة
  final double servicePrice; // فراغ لسعر الخدمة
  final IconData icon; // فراغ للأيقونة
  final bool isSelected; // فراغ لتحديد هل الكارت مختار أم لا
  final VoidCallback onTap; // فراغ لما يحدث عند الضغط على الكارت

  const ServiceCard({
    super.key,
    required this.serviceName,
    required this.serviceDescription,
    required this.servicePrice,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // هنا كل كود الـ UI الثابت (الشكل، الألوان، الحدود، التظليل)
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // هنا نستخدم الفراغات لملء المحتوى
            children: [
              Icon(icon, size: 48), // هنا نضع الأيقونة الممررة
              Text(serviceName), // هنا نضع اسم الخدمة الممرر
              Text(serviceDescription), // هنا نضع الوصف الممرر
              Text(
                  '\$${servicePrice.toStringAsFixed(2)}'), // هنا نضع السعر الممرر
            ],
          ),
        ),
      ),
    );
  }
}
