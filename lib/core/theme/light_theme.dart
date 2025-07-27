import 'package:flutter/material.dart';

import '../utils/app_color.dart';

ThemeData lightTheme = ThemeData(
  /*
  appBarTheme: AppBarTheme(
    titleTextStyle:TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
  ),
  */
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(
        0xFF336f67,
      ), // Elevated button background color.
      foregroundColor: Colors.white, // Elevated button text color.
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF336f67), // Text button text color.
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color(0xFF336f67); // Color when radio button is selected.
      }
      return Colors.grey; // Default color.
    }),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color(0xFF336f67); // Color when checkbox is selected.
      }
      return Colors.grey; // Default color.
    }),
  ),

  ///todo TextTheme
  textTheme: const TextTheme(
    // headlineLarge: TextStyle( color: ColorApp.primaryColor,  fontSize: 27,  ),
    bodyLarge: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 27,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(color: AppColors.primaryColor, fontSize: 22),
  ),

  ///todo scaffoldBackgroundColor
  scaffoldBackgroundColor: AppColors.whColor,

  ///todo inputDecorationTheme
  inputDecorationTheme: const InputDecorationTheme(
    prefixStyle: TextStyle(),
    suffixIconColor: AppColors.primaryColor,
    hintStyle: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor),
    ),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
  ),

  /*bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.grey,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,

  ),*/
);

///todo access the text style by text theme
//Text('Information Vehicle',style: Theme.of(context).textTheme.bodyLarge,),
//Text(title,style: Theme.of(context).textTheme.bodySmall,),
