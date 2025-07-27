import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

import 'package:mechpro/core/utils/text_style.dart';

class PageViewCustom extends StatelessWidget {
  const PageViewCustom({
    super.key,
    required this.image,
    required this.title,
    required this.bodytitle,
  });
  final String image;
  final String title;
  final String bodytitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(image)),
        Gap(20),
        Text(title, style: getTitleStyle()),
        Gap(20),
        Text(bodytitle, style: getBodyStyle()),
      ],
    );
  }
}
