

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../theme/app_theme.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../widgets/common_text.dart';
import '../../widgets/spacing_widget.dart';

class ExamCard extends StatelessWidget {
  final String question;
  final Uint8List? image;
  final List<String> options;
  final List<Uint8List?> images;
  final VoidCallback onBookmarkTap;
  final bool isBookmarked;
  final int selectedAnswerIndex;
  final bool answerChecked;
  final int correctAnswerIndex;
  final Function(int) onOptionSelected;

  const ExamCard({
    super.key,
    required this.question,
    // required this.imagePath,
    required this.options,
    required this.image,
    required this.images,
    required this.onBookmarkTap,
    this.isBookmarked = false,
    required this.selectedAnswerIndex,
    required this.answerChecked,
    required this.correctAnswerIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      child: SmoothContainer(
        smoothness: 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(

              child: Column(
                children: [

                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle
                      ),
                      height: 30.h,
                      width: 30.h,
                      child: Center(
                        child: GestureDetector(
                          onTap: onBookmarkTap,
                          child: Icon(
                            isBookmarked ? Icons.favorite : Icons.favorite_border,
                            size: 20.h,
                            color:  AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ).paddingAll(8.h),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingSmall,
                      vertical: AppDimensions.paddingLarge,
                    ),
                    child:  Column(
                      children: [

                        image != null
                            ? Image.memory(image!): CommonText(
                          text: question,
                          textAlign: TextAlign.center,
                          fontSize: AppDimensions.fontXMedium + 1,
                          color: AppTheme().getFontColor(context),
                          fontWeight: AppFontWeights.bold,
                          // overflow: TextOverflow.ellipsis,
                        ),

                      ],
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
    // print("imagekj==${images.length}");

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

    bool isImage =images.length > i &&images[i] != null;

    return InkWell(
      onTap: () {
        if (!answerChecked) {
          onOptionSelected(i);
        }
      },
      child: Container(
        width: double.infinity,

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
        child: isImage
            ? Image.memory(images[i]!,height: 50.h,):  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

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
      ),
    );
  }

}
