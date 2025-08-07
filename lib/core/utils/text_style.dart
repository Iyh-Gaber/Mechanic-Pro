
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    fontFamily: fontFamily ?? AppConstants.fontFamily, 
    fontSize: fontSize ?? 30.sp,
    height: height ?? 0.h,
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
    fontSize: fontSize ?? 24.sp,
    fontFamily: fontFamily ?? AppConstants.fontFamily, 
    fontWeight: fontWeight ?? FontWeight.normal,
    height: height ?? 0.h,
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
    height: height ?? 0.h,
    decoration: TextDecoration.underline,
    decorationColor: decorationColor ?? AppColors.blackColor,
    decorationThickness: decorationThickness ?? 2,
    fontSize: fontSize ?? 20.sp,
    fontFamily: fontFamily ?? AppConstants.fontFamily, 
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? AppColors.blackColor,
   
    letterSpacing: letterSpacing,
  );
}

TextStyle getSmallStyle({
  Color? color,
  FontWeight? fontWeight,
  double? fontSize,
  String? fontFamily,
  double? letterSpacing,
  double? height,
  
}) {
  return TextStyle(
    fontFamily: fontFamily ?? AppConstants.fontFamily, 
    height: height ?? 0.h,
    fontSize: fontSize ?? 16.sp,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? AppColors.blackColor,
    letterSpacing: letterSpacing,
    
  );
}
