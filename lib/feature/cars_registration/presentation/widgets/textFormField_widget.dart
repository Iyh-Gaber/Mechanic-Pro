import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';

import '../../../../core/utils/text_style.dart';

class TextformfieldWidget extends StatelessWidget {
  String title;
  //String hiteTitle;
  TextformfieldWidget({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        7.verticalSpace,
        Text(title, style: getSmallStyle()),
        7.verticalSpace,
        SizedBox(
          width: double.infinity,
          height: 57,
          child: TextFormField(
            decoration: InputDecoration(
                // hintText: hiteTitle,
                ),
          ),
        ),
        10.verticalSpace,
      ],
    );
  }
}
