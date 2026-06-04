import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sslcquiz/utils/text_data.dart';

import '../../controller/theme/theme_controller.dart';
import '../../data/app_data.dart';
import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../widgets/common_text.dart';
import '../../widgets/constant_widget.dart';
import '../../widgets/spacing_widget.dart';

class ClearHistoryDialog extends StatelessWidget {

  final Function function;

  ClearHistoryDialog(this.function);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with gradient
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.practiceTestOrange.withOpacity(0.85),
                  AppColors.practiceTestOrange.withOpacity(0.65),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.r),
                topRight: Radius.circular(22.r),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            alignment: Alignment.center,
            child: CommonText(
              text: TextData.clearHistory,
              fontSize: AppDimensions.fontXMedium,
              color: Colors.white,
              fontWeight: AppFontWeights.bold,
            ),
          ),

          Padding(
            padding: AppDimensions.paddingAllMedium,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing.height(25),

                Center(
                  child: CommonText(
                    text: TextData.clearHistoryDesc,
                    textAlign: TextAlign.center,
                    fontSize: AppDimensions.fontMedium,
                    color: AppColors.slateGray,
                    fontWeight: AppFontWeights.normal,
                  ),
                ),

                Spacing.height(12),

                // Themed TextField
                Spacing.height(30),

                // Start Button
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.h,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,

                            border: Border.all(
                              color: AppColors.practiceTestOrange,
                              width: 0.2,
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: AppColors.slateGray.withOpacity(0.1),
                                // Soft shadow
                                offset: Offset(0, 4),
                                // Horizontal & vertical offset
                                blurRadius: 10,
                                // How soft the shadow is
                                spreadRadius: 1, // How far the shadow spreads
                              ),
                            ],

                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: CommonText(
                            text: TextData.no,
                            fontSize: AppDimensions.fontMedium,
                            color: AppColors.blackColor,
                            fontWeight: AppFontWeights.bold,
                          ),
                        ),
                      ),
                    ),
                    Spacing.width(20),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          function();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.h,
                            vertical: 12.h,
                          ),
                          decoration: getGradient(r: 10.r),
                          alignment: Alignment.center,
                          child: CommonText(
                            text: TextData.yes,
                            fontSize: AppDimensions.fontMedium,
                            color: AppColors.white,
                            fontWeight: AppFontWeights.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
