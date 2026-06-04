import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sslcquiz/screens/home/exit_dialog.dart';
import 'package:sslcquiz/screens/setting/about_us.dart';
import 'package:sslcquiz/screens/setting/contact_us.dart';
import 'package:sslcquiz/screens/setting/terms_condition.dart';
import 'package:sslcquiz/utils/text_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/theme/theme_controller.dart';
import '../../data/app_data.dart';
import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../widgets/common_text.dart';
import '../../widgets/constant_widget.dart';
import '../../widgets/spacing_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    setStatusBar(fromDark: true);
    return WillPopScope(
      onWillPop: () async {
        return await _onBackPressed();
      },
      child: Scaffold(
        key: _scaffoldKey,

        drawer: _buildDrawer(context),

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: AppDimensions.marginAllMedium,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacing.height(30),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer(); // Direct access
                      },
                      child: Icon(Icons.menu, color: AppColors.blackColor),
                    ).marginOnly(top: 10.h),
                    SizedBox(width: 10),
            
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FutureBuilder<String>(
                                  future: AppData().getStudentName(),
                                  builder: (context, snapshot) {
                                    String s = snapshot.data ?? "";
            
                                    return CommonText(
                                      text: TextData.welcome + ", " + s + "!",
                                      fontSize: AppDimensions.fontXLarge1,
                                      color: AppColors.blackColor,
                                      fontWeight: AppFontWeights.medium,
                                    );
                                  },
                                ),
                              ),
            
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.toNamed(AppRoutes.settingScreen);
                              //   },
                              //   child: Icon(
                              //     Icons.settings,
                              //     color: AppColors.practiceTestOrange,
                              //   ),
                              // ),
                            ],
                          ),
            
                          CommonText(
                            text: TextData.desc,
                            fontSize: AppDimensions.fontSmall,
                            color: AppColors.slateGray,
                            fontWeight: AppFontWeights.medium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            
                Spacing.height(30),
            
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.practiceTestOrange, Color(0xFFB86FD3)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(22.h)),
                  ),
            
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 16.w),
            
                      // Quiz Icon or Illustration (Optional: Use SVG or Image.asset)
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Icon(Icons.quiz, size: 30.r, color: Colors.white),
                      ),
                      SizedBox(width: 16.w),
            
                      // Text Info
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: TextData.appTitle,
                              fontSize: AppDimensions.fontXMedium,
                              color: AppColors.white,
                              fontWeight: AppFontWeights.bold,
                            ),
            
                            SizedBox(height: 4.h),
            
                            CommonText(
                              text: TextData.appSubTitle,
                              fontSize: AppDimensions.fontSmall,
                              color: AppColors.white.withOpacity(0.9),
                              fontWeight: AppFontWeights.normal,
                            ),
                          ],
                        ),
                      ),
            
                      // Start Button
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.white,
                      //     foregroundColor: AppColors.practiceTestOrange,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(12.r),
                      //     ),
                      //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      //     elevation: 0,
                      //   ),
                      //   onPressed: () {
                      //     // Navigate to quiz
                      //   },
                      //   child: Text(
                      //     "Start",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.nold,
                      //       fontSize: 14.sp,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
            
                Spacing.height(30),
            
                CommonText(
                  text: TextData.yourStudies,
                  fontSize: AppDimensions.fontXMedium,
                  color: AppColors.blackColor,
                  fontWeight: AppFontWeights.bold,
                ),
                  Spacing.height(30),
            
                _buildMenuItem(TextData.english, context, false,TextData.englishMedium),
                Spacing.height(20),
                _buildMenuItem(TextData.tamil, context, true,TextData.tamilMedium1 ),
                // Spacing.height(20),
                // _buildMenuItem(TextData.socialHistory, context, true),
            
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     _buildMenuItem("btn_tamil_medium.png", context, true),
                //     Spacing.width(8),
                //     _buildMenuItem("btn_english_medium.png", context, false),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(height: 50.h),
          ListTile(
            leading: Icon(Icons.home, color: AppColors.blackColor, size: 20.h),
            title: CommonText(
              text: TextData.home,
              fontSize: AppDimensions.fontXMedium,
              color: AppColors.blackColor,
              fontWeight: AppFontWeights.bold,
            ),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),

          ListTile(
            leading: Icon(Icons.share, color: AppColors.blackColor, size: 20.h),
            title: CommonText(
              text: TextData.share,
              fontSize: AppDimensions.fontXMedium,
              color: AppColors.blackColor,
              fontWeight: AppFontWeights.bold,
            ),
            onTap: () async {
              final String url = await getOpenUrl();

              Share.share(
                '${TextData.checkOutApp} $url',
                subject: TextData.downloadApp,
              );
            },
          ),

          ListTile(
            leading: Icon(
              Icons.star_rate,
              color: AppColors.blackColor,
              size: 20.h,
            ),
            title: CommonText(
              text: TextData.rateUs,
              fontSize: AppDimensions.fontXMedium,
              color: AppColors.blackColor,
              fontWeight: AppFontWeights.bold,
            ),
            onTap: () {
              rateApp(); // Close drawer
            },
          ),
          ListTile(
            leading: Icon(
              Icons.policy,
              color: AppColors.blackColor,
              size: 20.h,
            ),
            title: CommonText(
              text: TextData.termsCondition,
              fontSize: AppDimensions.fontXMedium,
              color: AppColors.blackColor,
              fontWeight: AppFontWeights.bold,
            ),
            onTap: () {
              Get.to(TermsAndConditionsScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_support,
              color: AppColors.blackColor,
              size: 20.h,
            ),
            title: CommonText(
              text: TextData.privacyPolicy,
              fontSize: AppDimensions.fontXMedium,
              color: AppColors.blackColor,
              fontWeight: AppFontWeights.bold,
            ),
            onTap: () {
              Get.to(ContactUsScreen());

            },
          ), ListTile(
            leading: Icon(
              Icons.question_mark_sharp,
              color: AppColors.blackColor,
              size: 20.h,
            ),
            title: CommonText(
              text: TextData.aboutUs,
              fontSize: AppDimensions.fontXMedium,
              color: AppColors.blackColor,
              fontWeight: AppFontWeights.bold,
            ),
            onTap: () {
              Get.to(AboutUsScreen());
            },
          ),

          ListTile(
            leading: Icon(
              Icons.settings,
              color: AppColors.blackColor,
              size: 20.h,
            ),
            title: CommonText(
              text: TextData.settings,
              fontSize: AppDimensions.fontXMedium,
              color: AppColors.blackColor,
              fontWeight: AppFontWeights.bold,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.settingScreen)!.then((value) {
                setState(() {

                });
              },); // Close drawer
            },
          ),
        ],
      ),
    );
  }

  void rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    } else {
      // Fallback: open store page
      openStoreListing();
    }
  }

  void contactUs() async {
    final url = Uri.parse(contactUS);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openTermsAndConditions() async {
    final url = Uri.parse(termsCondition);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openStoreListing() async {
    final String url = await getOpenUrl();

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Future<bool> _onBackPressed() async {
    // SystemNavigator.pop();

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing on tap outside (optional)
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: ExitDialog(),
        );
      },
    );
    return false; // Prevent further handling
  }


  Widget _buildMenuItem(String button, BuildContext context, bool fromTamil,String title) {
    return GestureDetector(
      onTap: () async {
        if (button.contains(TextData.socialHistory)) {
          Get.toNamed(AppRoutes.historyScreen);
        } else {
          await AppData().setMedium(fromTamil);
          Get.toNamed(AppRoutes.subjectScreen);
        }
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
                text: title,
                fontSize: AppDimensions.fontXMedium,
                color: AppColors.blackColor,
                fontWeight: AppFontWeights.bold,
              ),
            ),

            Icon(Icons.navigate_next, color: AppColors.practiceTestOrange),
          ],
        ),
      ),

    );
  }
}
