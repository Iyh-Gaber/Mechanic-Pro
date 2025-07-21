import 'package:flutter/material.dart';

class NewServicesItem extends StatelessWidget {
  const NewServicesItem({
    super.key,
    required this.name,
    required this.image,
    this.onTap,
    this.textStyle,
  });

  final String name;
  final String image;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 147,
      child: InkWell(
        onTap: onTap,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            image,
            width: 33,
            height: 33,
          ),
          Text(name),
        ]),
      ),
    );
  }
}

// في ملف: lib/feature/home/presentation/widgets/new_services.dart
