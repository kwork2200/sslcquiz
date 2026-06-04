import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sslcquiz/controller/lesson/lesson_controller.dart';
import 'package:sslcquiz/controller/question/question_controller.dart';
import 'package:sslcquiz/controller/score/score_controller.dart';
import 'package:sslcquiz/controller/setting/setting_controller.dart';
import 'package:sslcquiz/controller/subject/subject_controller.dart';
import 'package:sslcquiz/utils/text_data.dart';

import '../../controller/theme/theme_controller.dart';
import '../../data/app_data.dart';
import '../../model/lesson_model.dart';
import '../../model/question_data.dart';
import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button_widget.dart';
import '../../widgets/common_text.dart';
import '../../widgets/constant_widget.dart';
import '../../widgets/spacing_widget.dart';
import 'gradient_switch.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController settingController = Get.put(SettingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (controller) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: getGradient(),

          child: Column(
            children: [
              CommonAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: TextData.settings,
                textColor: AppColors.backGroundColor,
              ).paddingSymmetric(horizontal: 15.h),

              Expanded(
                child: Container(
                  margin: EdgeInsets.all(15.h),
                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.all(Radius.circular(20.h)),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildChageMenuItem(
                        TextData.name,
                        controller.name.value,
                        () {
                          controller.changeName(context);
                        },
                      ),

                      // _buildChageMenuItem(
                      //   TextData.medium,
                      //   controller.medium.value,
                      //   () {
                      //     controller.changeName(context);
                      //   },
                      // ),
                      //
                      // _buildChageMenuItem(
                      //   TextData.language,
                      //   controller.language.value,
                      //   () {
                      //     controller.changeName(context);
                      //   },
                      // ),

                      // _buildMenuItem(
                      //   TextData.darkMode,
                      //   controller.isDarkMode.value,
                      //   () {
                      //     controller.changeTheme();
                      //   },
                      // ),
                      _buildMenuItem(
                        TextData.sound,
                        controller.isSound.value,
                        () {
                          controller.changeSound();
                        },
                      ),

                      Spacing.height(8),


                      _buildMenuItem(
                        TextData.shuffle,
                        controller.isShuffle.value,
                            () {
                          controller.changeShuffleData();
                        },
                      ),

                      Spacing.height(8),

                      // Database Refresh Button
                      _buildActionMenuItem(
                        'Refresh Database',
                        'Update to latest question data',
                        Icons.refresh,
                        () {
                          controller.refreshDatabase(context);
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, bool value, Function function) {
    return getCommonContainer(
      child: Row(
        children: [
          Expanded(
            child: CommonText(
              text: '${title}',
              fontSize: AppDimensions.fontMedium,
              color: AppColors.blackColor,
              fontWeight: AppFontWeights.bold,
            ),
          ),

          GradientSwitch(
            value: value,
            onChanged: (val) {
              function();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChageMenuItem(String title, String value, Function function) {
    return getCommonContainer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: '${title}',
                  fontSize: AppDimensions.fontMedium,
                  color: AppColors.blackColor,
                  fontWeight: AppFontWeights.bold,
                ),

                value.isNotEmpty
                    ? CommonText(
                        text: '${value}',
                        fontSize: AppDimensions.fontSmall,
                        color: AppColors.slateGray,
                        fontWeight: AppFontWeights.medium,
                      )
                    : SizedBox(),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              function();
            },
            child: CommonText(
              text: TextData.change,
              fontSize: AppDimensions.fontSmall,
              color: AppColors.practiceTestOrange,
              decoration: TextDecoration.underline,
              fontWeight: AppFontWeights.bold,
              fromTitle: true,
            ),
            // child: getAssetImage("btn_history_clear.png", width: 100.h),
          ),
        ],
      ),
    );
  }

  Widget _buildActionMenuItem(String title, String subtitle, IconData icon, Function function) {
    return getCommonContainer(
      child: InkWell(
        onTap: () => function(),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.h),
              decoration: BoxDecoration(
                color: AppColors.practiceTestOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Icon(
                icon,
                color: AppColors.practiceTestOrange,
                size: 24.h,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: AppDimensions.fontMedium,
                    color: AppColors.blackColor,
                    fontWeight: AppFontWeights.bold,
                  ),
                  CommonText(
                    text: subtitle,
                    fontSize: AppDimensions.fontSmall,
                    color: AppColors.slateGray,
                    fontWeight: AppFontWeights.medium,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.slateGray,
              size: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
