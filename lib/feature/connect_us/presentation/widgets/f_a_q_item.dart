import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

class FAQItem extends StatelessWidget {
  const FAQItem({super.key, required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: getSmallStyle(color: AppColors.blackColor, fontSize: 20),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(answer, style: getSmallStyle(color: AppColors.grColor)),
        ),
      ],
    );
  }
}
