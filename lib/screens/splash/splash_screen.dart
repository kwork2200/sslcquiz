import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sslcquiz/screens/home/home_screen.dart';
import 'package:sslcquiz/screens/home/name_dialog.dart';
import 'package:sslcquiz/utils/text_data.dart';

import '../../controller/theme/theme_controller.dart';
import '../../data/app_data.dart';
import '../../data/database_helper.dart';
import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../widgets/common_text.dart';
import '../../widgets/constant_widget.dart';
import '../../widgets/spacing_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    // Initialize database first, then proceed
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Force database initialization on app launch
      // This ensures fresh database is always copied from assets
      print("🚀 Initializing database...");
      final db = DatabaseHelper();
      await db.database; // This triggers _initDatabase()
      print("✅ Database initialization complete");
    } catch (e) {
      print("❌ Database initialization error: $e");
    }

    // Wait 3 seconds for splash screen
    await Future.delayed(Duration(seconds: 3));
    
    // Check if first time user
    bool isFirstTime = await AppData().getIsFirstTime();
    String name = await AppData().getStudentName();
    
    if (isFirstTime || name.isEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.r),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: NameDialog(),
          );
        },
      );
    } else {
      Get.to(HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    setStatusBar();


    return WillPopScope(
      onWillPop: () async {
        // Exit the app
        return await _onBackPressed();
      },
      child: Scaffold(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: getGradient(),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              getAssetImage(
                "logo.png",
                width: 150.w,
              ),

              SizedBox(height: 10,),

              CommonText(
                text: TextData.homeTitle,
                fontSize: AppDimensions.fontXXLarge,
                color: AppColors.white,
                fontWeight: AppFontWeights.medium,
                decoration: TextDecoration.underline,
                fromTitle: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    SystemNavigator.pop();
    return false; // Prevent further handling
  }


}
