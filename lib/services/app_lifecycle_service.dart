// import 'package:flutter/material.dart';
//
// import '../ads/app_open_ad_manager.dart';
//
// class AppLifecycleService extends GetxController with WidgetsBindingObserver {
//   static AppLifecycleService get to => Get.find();
//
//   final isAppInBackground = false.obs;
//   bool _isFirstResume = true;
//   DateTime? _lastAdShownTime;
//
//   @override
//   void onInit() {
//     super.onInit();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void onClose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.onClose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     switch (state) {
//       case AppLifecycleState.paused:
//       case AppLifecycleState.inactive:
//         isAppInBackground.value = true;
//         // Preload ad when app goes to background
//         if (!AppOpenAdManager.instance.isAdAvailable) {
//           AppOpenAdManager.instance.loadAd();
//         }
//         break;
//
//       case AppLifecycleState.resumed:
//         if (_isFirstResume) {
//           print('🔹 First resume - skipping ad (handled by splash)');
//           _isFirstResume = false;
//           return;
//         }
//
//         if (isAppInBackground.value) {
//           // Check if ad was shown recently to avoid spam
//           if (_lastAdShownTime != null) {
//             final timeSinceLastAd = DateTime.now().difference(_lastAdShownTime!);
//             if (timeSinceLastAd.inSeconds < 10) {
//               print('🔹 Ad shown recently (${timeSinceLastAd.inSeconds}s ago), skipping');
//               isAppInBackground.value = false;
//               return;
//             }
//           }
//
//           _showAdOnResume();
//           isAppInBackground.value = false;
//         }
//         break;
//
//       default:
//         break;
//     }
//   }
//
//   Future<void> _showAdOnResume() async {
//     final currentRoute = Get.currentRoute;
//
//     // Don't show ad if on splash screen
//     if (currentRoute == Routes.splash) {
//       print('🔹 On splash screen, skipping ad');
//       return;
//     }
//
//     // Small delay for smooth transition
//     await Future.delayed(const Duration(milliseconds: 300));
//
//     // Record time before showing ad
//     _lastAdShownTime = DateTime.now();
//
//     // Show app open ad
//     AppOpenAdManager.instance.showAdIfAvailable(
//       onAdDismissed: () {
//         print('🔹 App Open Ad dismissed on resume');
//       },
//     );
//   }
// }
