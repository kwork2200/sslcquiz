# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /usr/local/Cellar/android-sdk/24.3.3/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# Keep app package classes (com.quiz_app.sslcqui)
-keep class com.quiz_app.sslcqui.** { *; }
-keepclassmembers class com.quiz_app.sslcqui.** { *; }

# Keep classes used via reflection / platform channel from Flutter
-keep class * extends io.flutter.plugin.platform.PlatformViewFactory
-keep class * implements io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin$NativeAdFactory

# Keep Facebook Audience Network SDK classes
-keep class com.facebook.ads.** { *; }
-dontwarn com.facebook.ads.**
-dontwarn com.facebook.infer.annotation.**
-keep class com.facebook.infer.annotation.** { *; }

# Keep annotations
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions

# Gson specific classes
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}
