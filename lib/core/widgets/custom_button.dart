import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onpressed,
    this.whColor,
    this.fgColor,
    this.hieght,
    this.width,
    this.borderColor,
  });

  final String text;
  final Function() onpressed;
  final Color? whColor;
  final Color? fgColor;
  final Color? borderColor;
  final double? hieght;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                side: borderColor != null
                    ? BorderSide(color: borderColor ?? AppColors.primaryColor)
                    : BorderSide.none,

                // side: borderColor =!null ??  BorderSide(color:borderColor ):BorderSide.none,
                backgroundColor: whColor ?? AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: onpressed,
            child: Text(
              text,
              style:
                  getSmallStyle(color: fgColor ?? Colors.white, fontSize: 19),
            )));
  }
}
