import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sslcquiz/widgets/spacing_widget.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import 'common_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isLoading;
  final Color? borderColor;
  /// add new N.
  final double? fontSize;

  const CommonButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 58,
    this.borderRadius = 30,
    this.padding,
    this.textStyle,
    this.icon,
    this.isLoading = false,
    this.borderColor,
    /// add new N.
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.w,
      height: height?.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          // backgroundColor: backgroundColor ?? AppColors.buttonColor,
          backgroundColor: backgroundColor ?? (kIsWeb ? AppColors.darkGreen : AppColors.buttonColor),
          // backgroundColor: backgroundColor ?? (kIsWeb ? AppColors.darkGreen : AppColors.buttonColor),
          foregroundColor: textColor ?? Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kIsWeb ? 12.r : borderRadius),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          elevation: 0,
          overlayColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    Spacing.width(8),
                  ],
                  CommonText(
                    text: text,
                    fontWeight: FontWeight.w700,
                    color: textColor ?? Theme.of(context).scaffoldBackgroundColor,
                    /// add new N.
                    fontSize: fontSize ?? AppDimensions.fontMedium,
                  )
                ],
              ),
      ),
    );
  }
}
