import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sslcquiz/utils/text_data.dart';

import 'colors.dart';

class Constant {
  static String assetImagePath = "assets/images/";
  static String assetButtonsPath = "assets/button/";
  static String assetLessonPath = "assets/lesson/";
  static String svgAssetImagePath = "assets/svg_image/";
  static String font = "KaushanScript";
}
String termsCondition= "https://www.google.com/";
  String contactUS= "https://www.google.com/";
String pr= "https://www.google.com/";
bool isValidEmail(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

Future<String> getOpenUrl() async {
  final PackageInfo info = await PackageInfo.fromPlatform();

  final String packageName = info.packageName;
  var url = 'https://play.google.com/store/apps/details?id=$packageName';

  if (Platform.isAndroid) {
    url = 'https://play.google.com/store/apps/details?id=$packageName';
  } else if (Platform.isIOS) {
    url = 'https://apps.apple.com/app/$packageName';
  }

  return url;
}


getGradient({double r =0,var shape= BoxShape.rectangle}){
  return shape == BoxShape.circle?BoxDecoration(

    shape: shape,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFB86FD3), Color(0xFF583FC7)],
    ),
  ):BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(r)),

shape: shape,
gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFB86FD3), Color(0xFF583FC7)],
    ),
  );
}

setStatusBar({bool fromDark=false}){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 👈 Makes status bar transparent
    statusBarIconBrightness:fromDark?Brightness.dark: Brightness.light, // for white icons
  ));
}
getCommonContainer({required Widget child}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 15.w),

    decoration: BoxDecoration(
      color: AppColors.practiceTestOrange,

      borderRadius: BorderRadius.all(Radius.circular(12.h)),
    ),

    child: Container(
      padding: AppDimensions.paddingAllMedium,
      margin: EdgeInsets.only(left: 5.w),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(12.h)),
      ),

      child: child,
    ),
  ).marginOnly(top: 15.h);
}
class AppDimensions {
  // Padding
  static double paddingXSmall = 4.0;
  static double paddingSmall = 8.0;
  static double paddingMedium = 16.0;
  static double paddingXMedium = 20.0;
  static double paddingXXMedium = 22.0;
  static double paddingLarge = 24.0;
  static double paddingXLarge = 32.0;

  static double webPaddingLarge = 80;

  // Margin
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;
  static const double marginXLarge = 32.0;

  // Font Sizes
  static double fontSmall = 12.0;
  static double fontMedium = 14.0;
  static double fontXMedium = 16.0;
  static double fontLarge = 20.0;
  static double fontXLarge = 24.0;
  static double fontXLarge1 = 28.0;
  static double fontXXLarge = 40.0;

  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;

  static EdgeInsets paddingAllSmall = EdgeInsets.all(paddingSmall.r);
  static EdgeInsets paddingAllMedium = EdgeInsets.all(paddingMedium.r);
  static EdgeInsets paddingAllXMedium = EdgeInsets.all(paddingXMedium.r);
  static EdgeInsets paddingAllLarge = EdgeInsets.all(paddingLarge.r);
  static EdgeInsets paddingAllXLarge = EdgeInsets.all(paddingXLarge.r);

  static EdgeInsets paddingHorizontalSmall = EdgeInsets.symmetric(horizontal: paddingSmall.w);
  static EdgeInsets paddingHorizontalMedium = EdgeInsets.symmetric(horizontal: paddingMedium.w);
  static EdgeInsets paddingHorizontalXMedium = EdgeInsets.symmetric(horizontal: paddingXMedium.w);
  static EdgeInsets paddingHorizontalLarge = EdgeInsets.symmetric(horizontal: paddingLarge.w);
  static EdgeInsets paddingHorizontalXLarge = EdgeInsets.symmetric(horizontal: paddingXLarge.w);

  // web padding
  static EdgeInsets webPaddingHorizontalXLarge = EdgeInsets.symmetric(horizontal: webPaddingLarge.w);

  static EdgeInsets paddingVerticalSmall = EdgeInsets.symmetric(vertical: paddingSmall.h);
  static EdgeInsets paddingVerticalMedium = EdgeInsets.symmetric(vertical: paddingMedium.h);
  static EdgeInsets paddingVerticalLarge = EdgeInsets.symmetric(vertical: paddingLarge.h);
  static EdgeInsets paddingVerticalXLarge = EdgeInsets.symmetric(vertical: paddingXLarge.h);

  static EdgeInsets paddingTopSmall = EdgeInsets.only(top: paddingSmall.h);
  static EdgeInsets paddingTopMedium = EdgeInsets.only(top: paddingMedium.h);
  static EdgeInsets paddingTopLarge = EdgeInsets.only(top: paddingLarge.h);

  static EdgeInsets paddingBottomSmall = EdgeInsets.only(bottom: paddingSmall.h);
  static EdgeInsets paddingBottomMedium = EdgeInsets.only(bottom: paddingMedium.h);
  static EdgeInsets paddingBottomLarge = EdgeInsets.only(bottom: paddingLarge.h);

  static EdgeInsets paddingLeftSmall = EdgeInsets.only(left: paddingSmall.w);
  static EdgeInsets paddingLeftMedium = EdgeInsets.only(left: paddingMedium.w);
  static EdgeInsets paddingLeftXMedium = EdgeInsets.only(left: paddingXMedium.w);
  static EdgeInsets paddingLeftLarge = EdgeInsets.only(left: paddingLarge.w);

  static EdgeInsets paddingRightSmall = EdgeInsets.only(right: paddingSmall.w);
  static EdgeInsets paddingRightMedium = EdgeInsets.only(right: paddingMedium.w);
  static EdgeInsets paddingRightLarge = EdgeInsets.only(right: paddingLarge.w);

  static EdgeInsets marginAllSmall = EdgeInsets.all(marginSmall.r);
  static EdgeInsets marginAllMedium = EdgeInsets.all(marginMedium.r);
  static EdgeInsets marginAllLarge = EdgeInsets.all(marginLarge.r);
  static EdgeInsets marginAllXLarge = EdgeInsets.all(marginXLarge.r);

  static EdgeInsets paddingHorizontalMediumVerticalSmall = EdgeInsets.symmetric(horizontal: paddingMedium.w, vertical: paddingSmall.h);
  static EdgeInsets paddingHorizontalLargeVerticalMedium = EdgeInsets.symmetric(horizontal: paddingLarge.w, vertical: paddingMedium.h);
}

class AppFontWeights {
  // Common Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight normal = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // Alternative Names (Same Values)
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight heavy = FontWeight.w900;
}


showSnackBar(){
  Get.snackbar(
    'Error!', // Title
    TextData.noData, // Message
    colorText: Colors.white,
    backgroundColor: AppColors.incorrectColor,
    snackPosition: SnackPosition.BOTTOM, // or SnackPosition.TOP
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(10),
    borderRadius: 8,
  );
}


showLanguageSnackBar(){
  Get.snackbar(
    'Error!', // Title
    'Please select Language', // Message
    colorText: Colors.white,
    backgroundColor: AppColors.incorrectColor,
    snackPosition: SnackPosition.BOTTOM, // or SnackPosition.TOP
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(10),
    borderRadius: 8,
  );
}
extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
