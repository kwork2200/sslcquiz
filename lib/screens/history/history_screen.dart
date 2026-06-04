import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:sslcquiz/model/score_data.dart';
import 'package:sslcquiz/screens/history/clear_history_dialog.dart';
import 'package:sslcquiz/utils/text_data.dart';

import '../../data/database_helper.dart';

import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_text.dart';
import '../../widgets/spacing_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String firstCharCaps(String msg) {
    if (msg.isEmpty) return "";
    return msg[0].toUpperCase() + msg.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final db = DatabaseHelper();

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
              title: TextData.homeTitle,
              textColor: AppColors.backGroundColor,
              actions: [
                FutureBuilder<List<ScoreData>>(
                    future: db.getScoreHistory(),
                    builder: (context, snapshot) {
                      List<ScoreData> list =[];
                      if (snapshot.connectionState == ConnectionState.done) {
                        list = snapshot.data ?? [];
                      }
                    return list.isEmpty?SizedBox(): GestureDetector(
                      onTap: () {


                        showDialog(
                          context: context,
                          barrierDismissible: false, // Prevent dismissing on tap outside (optional)
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.r),
                              ),
                              insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                              child: ClearHistoryDialog((){
                                db.deleteQuiz();
                                setState(() {

                                });
                              }),
                            );
                          },
                        );

                      },
                      child:  CommonText(
                        text: TextData.clearHistory,
                        fontSize: AppDimensions.fontSmall,
                        color: AppColors.white,
                        decoration: TextDecoration.underline,
                        fontWeight: AppFontWeights.bold,
                        fromTitle: true,
                      ),
                      // child: getAssetImage("btn_history_clear.png", width: 100.h),
                    );
                  }
                ),

                // GestureDetector(
                //   onTap: () {
                //     db.deleteQuiz();
                //   },
                //   child: getAssetImage("share.png", width: 100.h),
                // ),
              ],
            ).paddingSymmetric(horizontal: 15.h),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.h),
                    topRight: Radius.circular(25.h),
                  ),
                ),
                child: FutureBuilder<List<ScoreData>>(
                  future: db.getScoreHistory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<ScoreData> list = snapshot.data ?? [];


                      if(list.isEmpty){
                        return Center(
                          child: CommonText(
                            text: "No Data",
                            fontSize: AppDimensions.fontMedium,
                            color: AppColors.blackColor,
                            fontWeight: AppFontWeights.medium,
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          ScoreData e = list[index];

                          List<String> subjectArray = e.tableName.split("_");
                          String sub = firstCharCaps(subjectArray[1]);

                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.practiceTestOrange.withOpacity(0.3),
                                width: 1,
                              ),
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [

                                // Top colored gradient header
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.practiceTestOrange.withOpacity(0.8),
                                        AppColors.practiceTestOrange.withOpacity(0.6),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(22.r),
                                      topRight: Radius.circular(22.r),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                  child: Row(
                                    children: [
                                      CommonText(
                                        text: "${e.lesson} / $sub",
                                        fontSize: AppDimensions.fontSmall,
                                        color: Colors.white,
                                        fontWeight: AppFontWeights.bold,
                                      ),
                                      Spacer(),
                                      CommonText(
                                        text: e.scoreDate,
                                        fontSize: AppDimensions.fontSmall,
                                        color: Colors.white,
                                        fontWeight: AppFontWeights.bold,
                                      ),
                                    ],
                                  ),
                                ),

                                // Main content
                                Padding(
                                  padding: AppDimensions.paddingAllSmall,
                                  child: Column(
                                    children: [
                                      Spacing.height(20),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                CommonText(
                                                  text: TextData.correct,
                                                  fontSize: AppDimensions.fontMedium,
                                                  color: AppColors.blackColor,
                                                  fontWeight: AppFontWeights.bold,
                                                ),
                                                Spacing.height(4),
                                                CommonText(
                                                  text: e.correct,
                                                  fontSize: AppDimensions.fontMedium,
                                                  color: Colors.green,
                                                  fontWeight: AppFontWeights.bold,
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Gradient divider (optional: you can make this dashed if needed)
                                          Container(
                                            width: 1,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [Colors.grey.shade300, Colors.grey.shade100],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            child: Column(
                                              children: [
                                                CommonText(
                                                  text: TextData.wrong,
                                                  fontSize: AppDimensions.fontMedium,
                                                  color: AppColors.blackColor,
                                                  fontWeight: AppFontWeights.bold,
                                                ),
                                                Spacing.height(4),
                                                CommonText(
                                                  text: e.wrong,
                                                  fontSize: AppDimensions.fontMedium,
                                                  color: Colors.redAccent,
                                                  fontWeight: AppFontWeights.bold,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      Spacing.height(20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          ;
                        },
                      );
                    }
                    return Center(
                      child: SizedBox(
                        height: 30, // set your preferred size
                        width: 30,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
