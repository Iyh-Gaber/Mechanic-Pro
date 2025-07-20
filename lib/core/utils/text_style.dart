 /* import 'package:flutter/material.dart';
import 'package:mechpro/core/constants/app_constants.dart';
import 'package:mechpro/core/utils/app_color.dart';

TextStyle getTitleStyle({
  Color? color,
  FontWeight? fontWeight,
  double? fontSize,
  double? height,
  double? letterSpacing,
  String? fontFamily,
}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontSize: fontSize ?? 30,
    height: height ?? 0,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: color ?? AppColors.blackColor,
    letterSpacing: letterSpacing,
  );
}

TextStyle getBodyStyle({
  Color? color,
  FontWeight? fontWeight,
  double? fontSize,
  double? height,
  double? letterSpacing,
  String? fontFamily, required FontStyle fontStyle,
}) {
  return TextStyle(
    fontSize: fontSize ?? 24,
    fontFamily: AppConstants.fontFamily,
    fontWeight: fontWeight ?? FontWeight.normal,
    height: height ?? 0,
    color: color ?? AppColors.blackColor,
    letterSpacing: letterSpacing,
  );
}

TextStyle getDecorationStyle({
  Color? color,
  FontWeight? fontWeight,
  double? fontSize,
  double? height,
  String? fontFamily,
  Color? decorationColor,
  double? letterSpacing,
  double? decorationThickness,
}) {
  return TextStyle(
    height: height ?? 0,
    decoration: TextDecoration.underline,
    decorationColor: decorationColor ?? AppColors.blackColor,
    decorationThickness: decorationThickness ?? 2,
    fontSize: fontSize ?? 20,
    fontFamily: AppConstants.fontFamily,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? AppColors.blackColor,
  );
}

TextStyle getSmallStyle(
    {Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    double? letterSpacing,
    double? height}) {
  return TextStyle(
    fontFamily: AppConstants.fontFamily,
    height: height ?? 0,
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? AppColors.blackColor,
    letterSpacing: letterSpacing,
  );
}
*/
// في ملف: lib/core/utils/text_style.dart

import 'package:flutter/material.dart';
import 'package:mechpro/core/constants/app_constants.dart';
import 'package:mechpro/core/utils/app_color.dart';

TextStyle getTitleStyle({
  Color? color,
  FontWeight? fontWeight,
  double? fontSize,
  double? height,
  double? letterSpacing,
  String? fontFamily,
  // FontStyle? fontStyle, // تم حذف هذا السطر
}) {
  return TextStyle(
    fontFamily: fontFamily ?? AppConstants.fontFamily, // هذا سيستخدم DMDisplay
    fontSize: fontSize ?? 30,
    height: height ?? 0,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: color ?? AppColors.blackColor,
    letterSpacing: letterSpacing,
    // fontStyle: fontStyle, // تم حذف هذا السطر
  );
}

TextStyle getBodyStyle({
  Color? color,
  FontWeight? fontWeight,
  double? fontSize,
  double? height,
  double? letterSpacing,
  String? fontFamily,
  // required FontStyle fontStyle, // <--- هذا هو السطر الذي تسبب في المشكلة، وقد تم حذفه
}) {
  return TextStyle(
    fontSize: fontSize ?? 24,
    fontFamily: fontFamily ?? AppConstants.fontFamily, // هذا سيستخدم DMDisplay
    fontWeight: fontWeight ?? FontWeight.normal,
    height: height ?? 0,
    color: color ?? AppColors.blackColor,
    letterSpacing: letterSpacing,
    // fontStyle: fontStyle, // تم حذف هذا السطر
  );
}

TextStyle getDecorationStyle({
  Color? color,
  FontWeight? fontWeight,
  double? fontSize,
  double? height,
  String? fontFamily,
  Color? decorationColor,
  double? letterSpacing,
  double? decorationThickness,
  // FontStyle? fontStyle, // تم حذف هذا السطر
}) {
  return TextStyle(
    height: height ?? 0,
    decoration: TextDecoration.underline,
    decorationColor: decorationColor ?? AppColors.blackColor,
    decorationThickness: decorationThickness ?? 2,
    fontSize: fontSize ?? 20,
    fontFamily: fontFamily ?? AppConstants.fontFamily, // هذا سيستخدم DMDisplay
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? AppColors.blackColor,
    // fontStyle: fontStyle, // تم حذف هذا السطر
    letterSpacing: letterSpacing,
  );
}

TextStyle getSmallStyle(
    {Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    String? fontFamily,
    double? letterSpacing,
    double? height,
    // FontStyle? fontStyle, // تم حذف هذا السطر
    }) {
  return TextStyle(
    fontFamily: fontFamily ?? AppConstants.fontFamily, // هذا سيستخدم DMDisplay
    height: height ?? 0,
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? AppColors.blackColor,
    letterSpacing: letterSpacing,
    // fontStyle: fontStyle, // تم حذف هذا السطر
  );
}
