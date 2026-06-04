import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sslcquiz/controller/lesson/lesson_controller.dart';
import 'package:sslcquiz/controller/question/question_controller.dart';
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
import 'exam_card.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // Use Get.find() instead of Get.put() since binding will create the controller
  late QuestionController questionController;

  @override
  void initState() {
    super.initState();
    // Get the controller instance created by binding
    questionController = Get.find<QuestionController>();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBar();
    return GetBuilder<QuestionController>(
      builder: (controller) {
        double progress =
            (controller.index.value+1) / (controller.questionList.length);

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,

          // appBar: CommonAppBar(
          //   backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          //   title: questionController.title.value,
          //   textColor: AppColors.backGroundColor,
          //   back: (){
          //     controller.onBack();
          //   },
          // ),
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration:  getGradient(),

            child: Column(
              children: [
                CommonAppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  title: "${controller.title}",
                  textColor: AppColors.backGroundColor,
                  actions:
                  controller.isLoading.value ||
                      controller.questionList.isEmpty
                      ? []
                      : [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingSmall,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backGroundColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.blackColor,
                            size: 18.sp,
                          ),
                          Spacing.width(4.w),
                          CommonText(
                            text: controller.formatTime(),
                            fontSize: AppDimensions.fontSmall,
                            color: AppColors.blackColor,
                            fontWeight: AppFontWeights.medium,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 15.h),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.only(top: 15.h),

                    // decoration: BoxDecoration(
                    //   color: Theme.of(context).scaffoldBackgroundColor,
                    //
                    //   borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(25.h),
                    //     topRight: Radius.circular(25.h),
                    //   ),
                    //
                    // ),
                    child: !questionController.isLoading.value
                        ? questionController.questionList.isEmpty
                        ? Center(
                      child: CommonText(
                        text: TextData.noData,
                        fontSize: AppDimensions.fontMedium,
                        color: AppColors.white,
                        fontWeight: AppFontWeights.medium,
                      ),
                    )
                        : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Stack(
                                  children: [
                                    // Background bar
                                    Container(
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    // Foreground gradient bar
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Container(
                                          height: 20.h,
                                          width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.practiceTestOrange.withOpacity(0.7),
                                                AppColors.practiceTestOrange.withOpacity(0.5),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(12.r),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )

                            ),
                            Spacing.width(12),

                            CommonText(
                              text:
                              "${controller.index.value + 1}/${controller.questionList.length}",
                              fontSize: AppDimensions.fontMedium,
                              color: AppColors.white,
                              fontWeight: AppFontWeights.medium,
                            ),
                          ],
                        ).paddingAll(15.h),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(15.h),
                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.all(
                                Radius.circular(20.h),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Builder(
                                builder: (context) {
                                  QuestionData item =
                                  controller
                                      .questionList[controller
                                      .index
                                      .value];

                                  return ExamCard(
                                    question: item.question,
                                    image: item.imageQuestion,
                                    images: item.imageList,
                                    // imagePath: controller.getQuestionSign(),
                                    options: item.options,
                                    isBookmarked:
                                    item.favourite ?? false,

                                    onBookmarkTap: () {
                                      controller.onFavourite();
                                    },
                                    selectedAnswerIndex: controller
                                        .selectedAnswerIndex
                                        .value,
                                    answerChecked: controller
                                        .answerChecked
                                        .value,
                                    correctAnswerIndex: item.options
                                        .indexOf(
                                      item.correctAnswer,
                                    ),
                                    onOptionSelected: (index) {
                                      controller.selectAnswer(
                                        index,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Center(
                      child: SizedBox(
                        height: 30, // set your preferred size
                        width: 30,
                        child: CircularProgressIndicator(strokeWidth: 2,color: Colors.white,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          bottomNavigationBar: Obx(
                () =>
            !questionController.isLoading.value &&
                questionController.questionList.isNotEmpty
                ? CustomBottomBar(
              onNextPressed: () => questionController.nextQuestion(),
              onPreviousPressed: () =>
                  questionController.previousQuestion(),
              onPlayPressed: () => questionController.playPauseTimer(),
              isFav:
              questionController
                  .questionList.length>   questionController.index.value?   questionController
                  .questionList[questionController.index.value]
                  .favourite ??
                  false:false,
              isPause: questionController.isPlay.value,
            )
                : SizedBox(),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
      String button,
      BuildContext context,
      Function function,
      ) {
    return Center(
      child: GestureDetector(
        onTap: () {
          function();
        },

        child: getImage(
          button,
          // height: 120.h,
          width: 200.w,
        ),
      ).marginOnly(bottom: 20.h),
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  final VoidCallback onNextPressed;
  final VoidCallback onPreviousPressed;
  final VoidCallback onPlayPressed;
  final bool isFav;
  final bool isPause;

  const CustomBottomBar({
    super.key,
    required this.isPause,
    required this.isFav,
    required this.onNextPressed,
    required this.onPreviousPressed,
    required this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 12.h),
      color: Colors.white,

      child: Row(
        children: [
          Spacing.width(10),

          GestureDetector(
            onTap: onPreviousPressed,

            child: Container(
              width: 100.h,
              padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 12.h),
              decoration: getGradient(r: 10.r),
              child: CommonText(
                text: TextData.previous,
                fontSize: AppDimensions.fontMedium,
                color: AppColors.white,
                fontWeight: AppFontWeights.bold,
              ),
              // child: getAssetImage(
              //   "arrowright.png",
              //   // height: 120.h,
              //   height: 40.h,
              // ),
            ),
          ),


          Spacing.width(10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: getGradient(shape: BoxShape.circle),

                  height: 40.h,
                  width: 40.h,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        onPlayPressed();
                      },
                      child: Icon(
                        !isPause ? Icons.play_arrow : Icons.pause,
                        size: 30.h,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Spacing.width(10),

                Container(
                  decoration: getGradient(shape: BoxShape.circle),
                  height: 40.h,
                  width: 40.h,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.offAllNamed(AppRoutes.home);
                      },
                      child: Icon(
                        Icons.home,
                        size: 30.h,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onNextPressed,

            child: Container(
              width: 100.h,
              padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 12.h),
              decoration: getGradient(r: 10.r),

              child: CommonText(
                text: TextData.next,
                fontSize: AppDimensions.fontMedium,
                color: AppColors.white,
                fontWeight: AppFontWeights.bold,
                textAlign: TextAlign.center,
              ),
              // child: getAssetImage(
              //   "arrowright.png",
              //   // height: 120.h,
              //   height: 40.h,
              // ),
            ),
          ),

          // CommonButton(
          //   text: isLastQuestion ? l10n.finish : l10n.nextExam,
          //   height: 40.h,
          //   backgroundColor: AppColors.primaryBlue,
          //   textColor: AppColors.backGroundColor,
          //   borderRadius: 4.r,
          //   onPressed: onNextPressed,
          // ),
          Spacing.width(10),
        ],
      ),
    );
  }
}
