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
  String? fontFamily,
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
    decorationColor:
        decorationColor ?? AppColors.blackColor, 
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
