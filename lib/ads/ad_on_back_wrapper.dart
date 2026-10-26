import 'package:flutter/material.dart';

import '../utils/functions.dart';
import 'interstitial_ad_manager.dart';

/// Guards against overlapping back-ad flows (e.g. rapid double taps) so the ad
/// and the following navigation run only once.
bool _isBackAdInProgress = false;

/// Wrapper widget that shows interstitial ads on back navigation
/// Handles both AppBar back button and system back button
/// 
/// Usage:
/// ```dart
/// AdOnBackWrapper(
///   child: YourScreen(),
/// )
/// ```
class AdOnBackWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onBack;

  const AdOnBackWrapper({
    super.key,
    required this.child,
    this.onBack,
  });

  @override
  State<AdOnBackWrapper> createState() => _AdOnBackWrapperState();
}

class _AdOnBackWrapperState extends State<AdOnBackWrapper> {
  /// Handle back navigation with ad
  Future<bool> _handleBackNavigation() async {
    try {
      debugPrint(' Back navigation triggered, showing ad...');

      await showAdOnBackNavigation(context);

      widget.onBack?.call();

      debugPrint('✅ Back navigation ad flow completed');
      return true;
    } catch (e) {
      debugPrint('❌ Error in back navigation ad: $e');
      return true;
    }
  }

  /// Guards against overlapping back flows (e.g. double taps) so the ad and
  /// the pop run only once.
  bool _isHandlingBack = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent immediate pop
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        if (_isHandlingBack) return;

        _isHandlingBack = true;
        try {
          // Show ad and then pop
          await _handleBackNavigation();

          if (context.mounted) {
            Navigator.of(context).pop();
          }
        } finally {
          _isHandlingBack = false;
        }
      },
      child: widget.child,
    );
  }
}

/// Shows the back-navigation interstitial ad (frequency controlled) WITHOUT
/// performing any navigation. Caller should navigate after this completes.
///
/// Returns `true` when the ad flow actually ran, `false` when the call was
/// ignored because another back-ad flow is still in progress (double tap).
///
/// Use this for custom back buttons which navigate somewhere other than a
/// simple pop:
/// ```dart
/// onTap: () async {
///   if (await showAdOnBackNavigation(context)) {
///     Get.offAllNamed(AppRoutes.someScreen);
///   }
/// }
/// ```
Future<bool> showAdOnBackNavigation(BuildContext context) async {
  if (_isBackAdInProgress) {
    debugPrint('⏭️ Back ad already in progress, ignoring duplicate call');
    return false;
  }
  _isBackAdInProgress = true;
  try {
    await _showBackAd(context);
    return true;
  } finally {
    _isBackAdInProgress = false;
  }
}

/// Helper function to show ad and then navigate back
/// Use this for custom back button onTap handlers
/// 
/// Example:
/// ```dart
/// leading: InkWell(
///   onTap: () => handleBackWithAd(context),
///   child: Icon(Icons.arrow_back),
/// )
/// ```
Future<void> handleBackWithAd(BuildContext context) async {
  if (_isBackAdInProgress) {
    debugPrint('⏭️ Back navigation already in progress, ignoring duplicate tap');
    return;
  }
  _isBackAdInProgress = true;
  try {
    await _showBackAd(context);
  } finally {
    _isBackAdInProgress = false;
  }

  // Navigate back after ad
  if (context.mounted) {
    Navigator.of(context).pop();
  }

  debugPrint('✅ Custom back navigation completed');
}

/// Shared implementation: shows the frequency-controlled back ad.
Future<void> _showBackAd(BuildContext context) async {
  try {
    debugPrint('🔙 Back navigation, showing ad...');

    if (!context.mounted) return;

    // Show ad on back (frequency controlled, same as CBM)
    final shouldShowThirdParty = await InterstitialAdManager.instance.showAdOnBack();

    // If third-party ad should be shown
    if (shouldShowThirdParty && context.mounted) {
      debugPrint('🎯 Showing third-party ad on back navigation');
      await showManagedInterstitialAd(context, alwaysShow: true);
    }
  } catch (e) {
    debugPrint('❌ Error showing ad on back: $e');
  }
}

/// Extension to easily wrap screens with ad-on-back functionality
extension AdOnBackExtension on Widget {
  /// Wraps this widget with AdOnBackWrapper
  Widget withAdOnBack({VoidCallback? onBack}) {
    return AdOnBackWrapper(
      onBack: onBack,
      child: this,
    );
  }
}
