import 'package:flutter/material.dart';
import '../ads/interstitial_ad_manager.dart';
import '../ads/qureka_interstitial.dart';
import '../services/ad_service.dart';
import '../services/fb_ad_service.dart';
import '../services/remote_config_service.dart';

Future<bool> showManagedInterstitialAd(BuildContext context, {bool alwaysShow = false}) async {
  try {
    debugPrint('🎬 [SHOW AD] showManagedInterstitialAd called (alwaysShow: $alwaysShow)');
    
    final bool googleEnabled = AdService.instance.shouldShowInterstitialAds;
    final bool facebookEnabled = FbAdService.instance.shouldShowInterstitialAds;
    final bool thirdPartyEnabled = RemoteConfigService.instance.showThirdPartyInterstitialAds && ENABLE_THIRD_PARTY_ADS;

    debugPrint('🔍 [SHOW AD] Ad Networks Status:');
    debugPrint('   - Google: $googleEnabled');
    debugPrint('   - Facebook: $facebookEnabled');
    debugPrint('   - Third-party: $thirdPartyEnabled');

    if (!googleEnabled && !facebookEnabled && thirdPartyEnabled) {
      debugPrint('🎯 [SHOW AD] Both Google & Facebook ads disabled - trying third-party ad');
      
      if (alwaysShow) {
        if (context.mounted) {
          await showQurekaInterstitialAd(context);
          InterstitialAdManager.instance.resetCounter();
          return true;
        }
      } else {
        final shouldShow = await InterstitialAdManager.instance.showAdIfAvailable();
        debugPrint('📊 [SHOW AD] Third-party ad decision: $shouldShow');
        if (shouldShow && context.mounted) {
          await showQurekaInterstitialAd(context);
          InterstitialAdManager.instance.resetCounter();
          return true;
        }
      }
      return false;
    }
    
    if (alwaysShow) {
      debugPrint('🚀 [SHOW AD] Calling showAdAlways() - bypassing frequency');
      await InterstitialAdManager.instance.showAdAlways();
      return true;
    } else {
      debugPrint('🎯 [SHOW AD] Calling showAdIfAvailable() - with frequency control');
      final shouldShow = await InterstitialAdManager.instance.showAdIfAvailable();
      debugPrint('📊 [SHOW AD] showAdIfAvailable returned: $shouldShow');
      return shouldShow;
    }
  } catch (e) {
    debugPrint('❌ [SHOW AD] Error in showManagedInterstitialAd: $e');
    return false;
  }
}

/// Show ad before navigation (forward navigation)
/// This should be called before Navigator.push
Future<void> showAdBeforeNavigation(BuildContext context) async {
  try {
    debugPrint('🎯 [NAV AD] Showing ad before navigation');
    
    final bool googleEnabled = AdService.instance.shouldShowInterstitialAds;
    final bool facebookEnabled = FbAdService.instance.shouldShowInterstitialAds;
    final bool thirdPartyEnabled = RemoteConfigService.instance.showThirdPartyInterstitialAds && ENABLE_THIRD_PARTY_ADS;
    
    if (!googleEnabled && !facebookEnabled && thirdPartyEnabled) {
      debugPrint('🎯 [NAV AD] Both Google & Facebook disabled - trying third-party ad');
      final shouldShow = await InterstitialAdManager.instance.showAdIfAvailable();
      if (shouldShow && context.mounted) {
        await showQurekaInterstitialAd(context);
        InterstitialAdManager.instance.resetCounter();
      }
    } else {
      await InterstitialAdManager.instance.showAdIfAvailable();
    }
  } catch (e) {
    debugPrint('❌ [NAV AD] Error showing ad before navigation: $e');
  }
}



