import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:sslcquiz/routes/app_pages.dart';
import 'package:sslcquiz/services/ad_service.dart';
import 'package:sslcquiz/services/remote_config_service.dart';
import 'package:sslcquiz/theme/app_theme.dart';

import 'ads/app_open_ad_manager.dart';
import 'ads/interstitial_ad_manager.dart';
import 'controller/theme/theme_controller.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('✅ Firebase initialized');
  await RemoteConfigService.instance.initialize();
  print('🔄 [MAIN] Force fetching Remote Config (attempt 1)...');
  await RemoteConfigService.instance.fetchAndActivate();
  print('🔄 [MAIN] Force fetching Remote Config (attempt 2)...');
  await RemoteConfigService.instance.fetchAndActivate();
  final frequency = AdService.instance.interstitialAdFrequency;
  print('🎯 [MAIN] FINAL INTERSTITIAL FREQUENCY FROM AdService: $frequency');
  print('✅ Remote Config values fetched and activated');

  await MobileAds.instance.initialize();
  print('✅ Google Mobile Ads initialized');
  AppOpenAdManager.instance.loadAd();

  InterstitialAdManager.instance.loadAd();
  print('✅ Interstitial Ad Manager initialized');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return Sizer(builder: (context, orientation, deviceType) {
          return Obx(() => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Quiz',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.theme,
            initialRoute: AppRoutes.splashScreen,
            getPages: AppPages.routes,

            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) return supportedLocales.first;
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
          ),);
        });
      },
    );
  }
}


