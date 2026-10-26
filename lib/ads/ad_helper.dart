import 'dart:io';
import '../services/remote_config_service.dart';

class AdHelper {
  
  /// Get App Open Ad Unit ID from Remote Config
  static String get appOpenUnitId {
    return RemoteConfigService.instance.openAdUnitId;
  }

  /// Get Banner Ad Unit ID from Remote Config
  static String get bannerAdUnitId {
    return RemoteConfigService.instance.bannerAdUnitId;
  }

  /// Get Interstitial Ad Unit ID from Remote Config
  static String get interstitialAdUnitId {
    return RemoteConfigService.instance.interstitialAdUnitId;
  }

  /// Get Native Ad Unit ID from Remote Config
  static String get nativeAdUnitId {
    return RemoteConfigService.instance.nativeAdUnitId;
  }

  /// Check if Banner Ads should be shown
  static bool get showBannerAds {
    return RemoteConfigService.instance.showBannerAds;
  }

  /// Check if Interstitial Ads should be shown
  static bool get showInterstitialAds {
    return RemoteConfigService.instance.showInterstitialAds;
  }

  /// Check if Native Ads should be shown
  static bool get showNativeAds {
    return RemoteConfigService.instance.showNativeAds;
  }

  /// Check if App Open Ads should be shown
  static bool get showOpenAds {
    return RemoteConfigService.instance.showOpenAds;
  }

  /// Get Interstitial Ad Frequency
  static int get interstitialAdFrequency {
    return RemoteConfigService.instance.interstitialAdFrequency;
  }
}
