import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sslcquiz/controller/lesson/lesson_controller.dart';
import 'package:sslcquiz/controller/question/question_controller.dart';
import 'package:sslcquiz/controller/score/score_controller.dart';
import 'package:sslcquiz/controller/subject/subject_controller.dart';
import 'package:sslcquiz/screens/score/score_h_card.dart';
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

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  ScoreController scoreController = Get.put(ScoreController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scoreController.loadData();
  }

  @override
  Widget build(BuildContext context) {
    scoreController.loadData();
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoutes.lessonScreen);

        return false;
      },
      child: GetBuilder(
        init: ScoreController(),
        builder: (controller) {

          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: getGradient(),

              child: Column(
                children: [
                  CommonAppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: "${controller.title}",
                    textColor: AppColors.backGroundColor,
                    back: () {
                      Get.offAllNamed(AppRoutes.lessonScreen);
                    },
                    actions: [
                      GestureDetector(
                        child: Icon(Icons.share, color: AppColors.white),
                        onTap: () {

                          controller.sharePdf();

                          // Share.share(
                          //   '${controller.title},\n${controller.lesson.value},\n${TextData.time}: ${controller.scoreData!.totalTime},\n${TextData.correct}: ${controller.scoreData!.correct},\n${TextData.wrong}: ${controller.scoreData!.wrong},\n${TextData.score}: ${controller.scoreData!.totalScore}',
                          //   subject: 'Quiz Result',
                          // );
                        },
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 15.h),

                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15.h),
                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.all(Radius.circular(20.h)),
                      ),
                      child:
                          !controller.isLoading.value &&
                              controller.scoreData != null
                          ? Builder(
                              builder: (context) {
                                String status = TextData.poor;
                                String cup = "cup_wood.png";
                                String fullDateTime =controller.scoreData!.scoreDate;

// Split by space
                                String onlyDate = fullDateTime.split(' ')[0];

                                double percentageVal =
                                    ((double.tryParse(
                                          controller.scoreData!.totalScore,
                                        ) ??
                                        0) /
                                    (controller.scoreData!.totalQuestion) * 100);

                                if (percentageVal == 100) {
                                  status = TextData.awesome;
                                  cup = "cup_gold.png";
                                } else if (percentageVal <= 99 &&
                                    percentageVal >= 90) {
                                  status = TextData.nice;
                                  cup = "cup_silver.png";
                                } else if (percentageVal <= 89 &&
                                    percentageVal >= 75) {
                                } else {
                                  status = TextData.good;
                                  cup = "cup_bronz.png";
                                }
                                return Column(
                                  children: [

                                    Expanded(child: ListView(children: [
                                      Center(
                                        child: getAssetImage(cup, height: 50.h),
                                      ),
                                      Spacing.height(10),

                                      CommonText(
                                        text: status,
                                        textAlign: TextAlign.center,
                                        fontSize: AppDimensions.fontXLarge1,
                                        color: AppColors.practiceTestOrange,
                                        fontWeight: AppFontWeights.medium,
                                        fromTitle: true,
                                      ),

                                      _buildMenuItem(TextData.name,controller.name.value),
                                      _buildMenuItem(TextData.duration,controller.scoreData!.totalTime),
                                      _buildMenuItem(TextData.correct,controller.scoreData!.correct),
                                      _buildMenuItem(TextData.wrong,controller.scoreData!.wrong),
                                      _buildMenuItem(TextData.score,controller.scoreData!.totalScore),
                                      _buildMenuItem(TextData.date,onlyDate),

                                      // Spacing.height(20),
                                      //
                                      //
                                      //
                                      //
                                      // Column(
                                      //   children: List.generate(controller.scoreData!.refId.length, (index) {
                                      //     QuestionData item = controller.scoreData!.refId[index];
                                      //     return ScoreCard(
                                      //       question: item.question,
                                      //       // imagePath: controller.getQuestionSign(),
                                      //       options: item.options,
                                      //       isBookmarked:
                                      //       item.favourite ?? false,
                                      //
                                      //       onBookmarkTap: () {
                                      //       },
                                      //       selectedAnswerIndex: item.userAnswer==null ?-1:
                                      //       item.options.indexOf(item.userAnswer??""),
                                      //
                                      //       answerChecked:
                                      //       item.userAnswer!=null,
                                      //       correctAnswerIndex: item.options
                                      //           .indexOf(
                                      //         item.correctAnswer,
                                      //       ),
                                      //
                                      //     );
                                      //   },),
                                      // )


                                    ],)),


                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {

                                              Get.offNamed(
                                                AppRoutes.questionScreen,
                                                arguments: {'fromFavourite': controller.fromFavourite.value},
                                              );

                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.h,
                                                vertical: 12.h,
                                              ),
                                              decoration: getGradient(r: 10.r),
                                              alignment: Alignment.center,
                                              child: CommonText(
                                                text: "Try Again",
                                                fontSize:
                                                    AppDimensions.fontMedium,
                                                color: AppColors.white,
                                                fontWeight: AppFontWeights.bold,
                                              ),

                                            ),
                                          ),


                                        ),

                                        Spacing.width(10),

                                        Expanded(

                                          child: GestureDetector(

                                            onTap: () {
                                              Get.offNamed(
                                                AppRoutes.historyScreen,
                                              );
                                            },

                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.h,
                                                vertical: 12.h,
                                              ),

                                              decoration: getGradient(r: 10.r),

                                              alignment: Alignment.center,

                                              child: CommonText(
                                                text: TextData.socialHistory,
                                                fontSize: AppDimensions.fontMedium,
                                                color: AppColors.white,
                                                fontWeight: AppFontWeights.bold,
                                              ),

                                            ),
                                          ),

                                          // ElevatedButton(
                                          //   style: ElevatedButton.styleFrom(
                                          //     elevation: 8,
                                          //     // Controls the shadow
                                          //     shadowColor: Colors.black,
                                          //     // Optional
                                          //     backgroundColor:
                                          //         AppColors.primaryBlue,
                                          //     padding: EdgeInsets.symmetric(
                                          //       horizontal: 24,
                                          //       vertical: 12,
                                          //     ),
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius.circular(
                                          //             12.h,
                                          //           ),
                                          //     ),
                                          //   ),
                                          //   onPressed: () {
                                          //     Get.offNamed(
                                          //       AppRoutes.historyScreen,
                                          //     );
                                          //   },
                                          //   child: CommonText(
                                          //     text: "Social History",
                                          //     fontSize:
                                          //         AppDimensions.fontMedium,
                                          //     color: AppColors.white,
                                          //     fontWeight:
                                          //         AppFontWeights.medium,
                                          //   ),
                                          // ),
                                        ),
                                      ],
                                    ).marginAll(12.h),
                                  ],
                                );
                              },
                            )
                          : SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(
      String title,
      String value,
      ) {
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



        child: Column(crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            CommonText(
              text: '$title:',
              fontSize: AppDimensions.fontMedium,
              color: AppColors.blackColor,
              fontWeight: AppFontWeights.bold,
            ),

            CommonText(
              text: value,
              fontSize: AppDimensions.fontSmall,
              color: AppColors.slateGray,
              fontWeight: AppFontWeights.medium,
            ),

          ],
        ),
      ),
    ).marginOnly(top: 10.h);
  }
}

