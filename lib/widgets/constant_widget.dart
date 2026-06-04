import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constant.dart';

Widget getAssetImage(String image, {double? width, double? height, Color? color, BoxFit boxFit = BoxFit.contain}) {
  return Image.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width?.w,
    height: height?.h,
    fit: boxFit,
  );
}

Widget getButtonImage(String image, {double? width, double? height, Color? color, BoxFit boxFit = BoxFit.contain}) {
  return Image.asset(
    Constant.assetButtonsPath + image,
    color: color,
    width: width?.w,
    height: height?.h,
    fit: boxFit,
  );
}

Widget getImage(String image, {double? width, double? height, Color? color, BoxFit boxFit = BoxFit.contain}) {
  return Image.asset(
    image,
    color: color,
    width: width?.w,
    height: height?.h,
    fit: boxFit,
  );
}

