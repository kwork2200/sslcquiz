import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../theme/app_theme.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../widgets/common_text.dart';
import '../../widgets/spacing_widget.dart';

class ScoreCard extends StatelessWidget {
  final String question;
  // final String imagePath;
  final List<String> options;
  final VoidCallback onBookmarkTap;
  final bool isBookmarked;
  final int selectedAnswerIndex;
  final bool answerChecked;
  final int correctAnswerIndex;

  const ScoreCard({
    super.key,
    required this.question,
    // required this.imagePath,
    required this.options,
    required this.onBookmarkTap,
    this.isBookmarked = false,
    required this.selectedAnswerIndex,
    required this.answerChecked,
    required this.correctAnswerIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(18.r)),

          border: Border.all(color: Colors.grey,width: 0.3)

      ),
      margin: EdgeInsets.only(right: 15.w,left: 15.w,bottom: 10.h),

      child: SmoothContainer(
        smoothness: 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(

              child: Column(
                children: [


                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                      vertical: AppDimensions.paddingLarge,
                    ),
                    child: CommonText(
                      text: question,
                      textAlign: TextAlign.center,
                      fontSize: AppDimensions.fontXMedium + 1,
                      color: AppTheme().getFontColor(context),
                      fontWeight: AppFontWeights.bold,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // imagePath.isEmpty
                  //     ? SizedBox()
                  //     : Container(
                  //   margin: EdgeInsets.only(bottom: 16.h, top: 12.h),
                  //   color: AppColors.backGroundColor,
                  //   child: Image.asset(
                  //     'assets/icons/$imagePath',
                  //     width: 75.w,
                  //     height: 75.h,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),


                ],
              ),
            ),

            SizedBox(height: 1.h, ),

            for (int i = 0; i < options.length; i++) ...[
                   _buildOptionTile("${i + 1}", options[i], context, i),
              if (i != options.length - 1)
                SizedBox(height: 1.h),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(String index, String text, BuildContext context, int i) {
    // Default colors from theme
    Color bgColor = Colors.white;
    Color circleColor = Theme.of(context).cardColor;
    Color borderColor = AppTheme().getSubFontColor(context);
    Color textColor = AppColors.slateGray;
    Color indexTextColor = AppTheme().getFontColor(context);

    if (answerChecked) {
      bool isSelected = i == selectedAnswerIndex;
      bool isCorrect = i == correctAnswerIndex;

      if (isSelected && isCorrect) {
        bgColor = AppColors.correctColor;
      } else if (isSelected && !isCorrect) {
        bgColor = AppColors.incorrectColor;
      } else if (!isSelected && isCorrect) {
        bgColor = AppColors.correctColor;
      }

      if (bgColor != Colors.white) {
        circleColor = bgColor;
        borderColor = AppColors.backGroundColor;
        textColor = Colors.white;
        indexTextColor = AppColors.backGroundColor;
      }
    }

    return
      Container(

        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(18.r)),

          border: Border.all(color: Colors.grey,width: 0.3)

        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingMedium,
        ),

        margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   width: 28.r,
            //   height: 28.r,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     color: circleColor,
            //     shape: BoxShape.circle,
            //     border: Border.all(
            //       color: borderColor,
            //       width: 0.8,
            //     ),
            //   ),
            //   child: CommonText(
            //     text: index,
            //     fontSize: AppDimensions.fontMedium,
            //     color: indexTextColor,
            //     fontWeight: AppFontWeights.medium,
            //   ),
            // ),
            // Spacing.width(12),
            Expanded(
              child: CommonText(
                text: text,
                fontSize: AppDimensions.fontMedium,
                color: textColor,
                fontWeight: AppFontWeights.bold,
              ),
            ),
          ],
        ),
      );
  }

}
