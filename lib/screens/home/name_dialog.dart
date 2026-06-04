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
import 'home_screen.dart';
class NameDialog extends StatelessWidget {

  String? name = "";
  NameDialog({this.name});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text =name??"";
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
              text: TextData.welcomeQuiz,
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

                CommonText(
                  text: TextData.welcomeQuizDesc,
                  fontSize: AppDimensions.fontSmall,
                  color: AppColors.slateGray,
                  fontWeight: AppFontWeights.normal,
                ),

                Spacing.height(12),

                // Themed TextField
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: AppDimensions.fontMedium,
                    fontWeight: AppFontWeights.medium,
                  ),
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: AppColors.slateGray,
                      fontWeight: AppFontWeights.medium,
                      fontSize: AppDimensions.fontMedium
                    ),
                    hintText: "Enter your name",
                    hintStyle: TextStyle(
                      color: AppColors.slateGray.withOpacity(0.6),
                        fontSize: AppDimensions.fontMedium
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                          color: AppColors.slateGray.withOpacity(0.4)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                          color: AppColors.practiceTestOrange, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),

                Spacing.height(30),

                // Start Button
                GestureDetector(
                  onTap: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty) {
                      Get.snackbar(
                        TextData.nameRequired,
                        TextData.enterNameError,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent.withOpacity(0.8),
                        colorText: Colors.white,
                      );
                      return;
                    }

                    AppData().setStudentName(nameController.text);
                    AppData().setIsFirstTime();
                    Get.to(() => HomeScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.h,
                      vertical: 12.h,
                    ),
                    decoration: getGradient(r: 10.r),
                    alignment: Alignment.center,
                    child: CommonText(
                      text: TextData.startQuiz,
                      fontSize: AppDimensions.fontMedium,
                      color: AppColors.white,
                      fontWeight: AppFontWeights.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

