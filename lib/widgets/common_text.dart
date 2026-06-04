import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sslcquiz/utils/constant.dart';
import '../utils/colors.dart';
import 'common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final bool? fromTitle;

  const CommonText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color = AppColors.buttonColor,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.fromTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,

        style:fromTitle==null?GoogleFonts.roboto(
          textStyle: GoogleFonts.roboto(fontSize: fontSize.sp, fontWeight: fontWeight, color: color, decoration: decoration),
        ): TextStyle(fontSize: fontSize.sp, fontWeight: fontWeight, color: color, decoration: decoration,
      fontFamily: Constant.font,    decorationColor: color, // <-- underline color
        )
    );
  }
}
