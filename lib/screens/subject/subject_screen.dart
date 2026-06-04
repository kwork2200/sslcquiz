import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sslcquiz/controller/subject/subject_controller.dart';
import 'package:sslcquiz/screens/home/home_screen.dart';
import 'package:sslcquiz/utils/text_data.dart';

import '../../controller/theme/theme_controller.dart';
import '../../data/app_data.dart';
import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_text.dart';
import '../../widgets/constant_widget.dart';
import '../../widgets/spacing_widget.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  // Use Get.find() instead of Get.put() since binding will create the controller
  late SubjectController subjectController;

  @override
  void initState() {
    super.initState();
    // Get the controller instance created by binding
    subjectController = Get.put(SubjectController());
    // subjectController = Get.find<SubjectController>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          width: double.infinity,

          height: double.infinity,
          margin: EdgeInsets.only(top: 10.h),

          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.practiceTestOrange, Color(0xFFB86FD3)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: TextData.homeTitle,
                textColor: AppColors.backGroundColor,
                back: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));


                },
              ).paddingSymmetric(horizontal: 15.h),

              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.only(top: 15.h),

                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.h),
                      topRight: Radius.circular(25.h),
                    ),
                  ),

                  child:  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),

                    itemCount: subjectController.subjectList.length,
                    itemBuilder: (context, index) {
                      var e = subjectController.subjectList[index];
                      return Obx(() => _buildMenuItem(e.button,subjectController.isTamil.value?e.tamilTitle:e.title, context, () async {
                        bool fromTamil = subjectController.isTamil.value;
                        String tableName = e.englishTable;
                        if (fromTamil) {
                          tableName = e.tamilTable;
                        }


                        await AppData().setTableName(tableName);
                        await AppData().setTitle(e.title);
                        String route = AppRoutes.lessonScreen;
                        if (e.title == TextData.favourite) {
                          route = AppRoutes.questionScreen;
                        }

                        print("e.title==${e.title}");
                        print("tamilTable==${tableName}");
                        Get.toNamed(
                          route,
                          arguments: {
                            'fromFavourite': e.title == TextData.favourite,
                          },
                        );


                      }),);
                    },
                  )
                  // child: GridView.count(
                  //   crossAxisCount: 2,
                  //   // Number of columns
                  //   crossAxisSpacing: 10.h,
                  //   mainAxisSpacing: 10.h,
                  //   padding: EdgeInsets.all(10.h),
                  //   children: List.generate(
                  //     subjectController.subjectList.length,
                  //         (index) {
                  //       var e = subjectController.subjectList[index];
                  //       return _buildMenuItem(e.button, context, () async {
                  //         bool fromTamil = await AppData().isTamil();
                  //         String tableName = e.englishTable;
                  //         if (fromTamil) {
                  //           tableName = e.tamilTable;
                  //         }
                  //         print("tamilTable==${tableName}");
                  //
                  //         await AppData().setTableName(tableName);
                  //         await AppData().setTitle(e.title);
                  //         String route = AppRoutes.lessonScreen;
                  //         if (e.title == TextData.favourite) {
                  //           route = AppRoutes.questionScreen;
                  //         }
                  //         Get.toNamed(
                  //           route,
                  //           arguments: {
                  //             'fromFavourite': e.title == TextData.favourite,
                  //           },
                  //         );
                  //       });
                  //     },
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildMenuItem(
  //   String button,
  //   BuildContext context,
  //   Function function,
  // ) {
  //   return GestureDetector(
  //     onTap: () {
  //       function();
  //     },
  //
  //     child: getButtonImage(
  //       button,
  //       // height: 120.h,
  //       width: 200.w,
  //     ),
  //   ).marginOnly(bottom: 20.h);
  // }

  Widget _buildMenuItem(
    String title,
    String button,
    BuildContext context,
    Function function,
  ) {


    return GestureDetector(
      onTap: () async {
        function();
      },

      child: Container(
        width: double.infinity,
        padding: AppDimensions.paddingAllMedium,
        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: AppColors.slateGray.withOpacity(0.1), // Soft shadow
              offset: Offset(0, 4), // Horizontal & vertical offset
              blurRadius: 10, // How soft the shadow is
              spreadRadius: 1, // How far the shadow spreads
            ),
          ],

          borderRadius: BorderRadius.all(Radius.circular(22.h)),
        ),

        child: Row(
          children: [
            Container(
              height: 50.h,
              width: 50.h,

              decoration: BoxDecoration(
                color: Color(0xFFDED7FF),

                borderRadius: BorderRadius.all(Radius.circular(10.h)),
              ),

              alignment: Alignment.center,

              child: CommonText(
                text: button[0].toString().toUpperCase(),
                fontSize: AppDimensions.fontLarge,
                color: AppColors.practiceTestOrange,
                fontWeight: AppFontWeights.bold,

              ),
            ),

            Spacing.width(20),

            Expanded(
              child: CommonText(
                text: button,
                fontSize: AppDimensions.fontXMedium,
                color: AppColors.blackColor,
                fontWeight: AppFontWeights.bold,
              ),
            ),

            Icon(Icons.navigate_next, color: AppColors.practiceTestOrange),
          ],
        ),
      ),
      // child: getButtonImage(
      //   button,
      //   // height: 120.h,
      //   width: 150.w,
      // ),
    ).marginOnly(top: 15.h);
  }
}
