import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBlue,
    shadowColor: AppColors.blackColor,
    scaffoldBackgroundColor: AppColors.lightColor,
    // scaffoldBackgroundColor: AppColors.backGroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.backGroundColor,
    ),
    cardColor: AppColors.backGroundColor,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.roboto(
          color: AppColors.blackColor, fontSize: AppDimensions.fontXMedium + 2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryBlue,
    cardColor: AppColors.darkCardColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    shadowColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      // backgroundColor: AppColors.primaryBlue,
      // foregroundColor: AppColors.backGroundColor,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.roboto(
          color: AppColors.backGroundColor,
          fontSize: AppDimensions.fontXMedium + 2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
    ),
  );

  getFontColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.blackColor
        : AppColors.backGroundColor;
  }

  getSubFontColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.subFontColor
        : Colors.white54;
  }

  getTabColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade200
        : AppColors.darkCardColor;
  }

  getQuizBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade100
        : Theme.of(context).scaffoldBackgroundColor;
  }

  getSelectedAnswerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.selectedAnswerColor
        : AppColors.selectedAnswerColor;
  }
}
