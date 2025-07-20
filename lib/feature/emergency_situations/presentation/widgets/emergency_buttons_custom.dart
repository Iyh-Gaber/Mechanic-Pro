import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/text_style.dart';

class EmergencyButtonsCustom extends StatelessWidget {
  const EmergencyButtonsCustom({
    super.key,
    required this.context,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final BuildContext context;
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      height: 70, 
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(width: 15),
                Text(
                  text,
                  style: getBodyStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
