import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/text_style.dart';

import '../../../../core/utils/app_color.dart';

class CustomServiceCard extends StatelessWidget {
  final String imageUrl;
  final String serviceName;
  final String serviceDescription;
  final VoidCallback? onButtonPressed;

  const CustomServiceCard({
    Key? key,
    required this.imageUrl,
    required this.serviceName,
    required this.serviceDescription,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whColor,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Image instead of Icon
            Image.asset(
              imageUrl,
              width: double.infinity, // Adjust size as needed
              height: 155.0, // Adjust size as needed
              fit: BoxFit.cover,
            ),

            Text(serviceName, style: getSmallStyle()),

            Text(
              serviceDescription,
              textAlign: TextAlign.center,
              style: getSmallStyle(color: AppColors.grColor, fontSize: 17),
              maxLines: 2,
            ),
            ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whColor,
              ),
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
