import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:sslcquiz/routes/app_pages.dart';
import 'package:sslcquiz/theme/app_theme.dart';

import 'controller/theme/theme_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
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
            title: 'quiz',
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



/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ─────────────────────────────────────────
// MAIN
// ─────────────────────────────────────────
void main() {
  runApp(const YesMadamApp());
}

class YesMadamApp extends StatelessWidget {
  const YesMadamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: 'YesMadam',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB5004E)),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

// ─────────────────────────────────────────
// COLORS
// ─────────────────────────────────────────
class AppColors {
  static const primary = Color(0xFFB5004E);
  static const primaryLight = Color(0xFFFCE4EC);
  static const gold = Color(0xFFD4A843);
  static const black = Color(0xFF1A1A1A);
  static const grey = Color(0xFF888888);
  static const lightGrey = Color(0xFFF5F5F5);
  static const bgCream = Color(0xFFFFF8F0);
  static const green = Color(0xFF2E7D32);
  static const orange = Color(0xFFE65100);
  static const eliteBg = Color(0xFF1A1A1A);
}

// ─────────────────────────────────────────
// CONTROLLER
// ─────────────────────────────────────────
class HomeController extends GetxController {
  final currentBottomTab = 0.obs;
  final trendingTab = 0.obs;

  final List<String> trendingTabs = [
    'Waxing',
    'Facial',
    'Mani-Pedi',
    'Body Polish',
  ];

  final List<Map<String, dynamic>> categories = [
    {'label': 'Salon for\nWomen', 'isNew': false, 'color': Color(0xFFFFE4EE)},
    {'label': 'Body\nPolishing', 'isNew': true, 'color': Color(0xFFE8F5E9)},
    {'label': 'Waxing', 'isNew': false, 'color': Color(0xFFFFF3E0)},
    {'label': 'Facials', 'isNew': false, 'color': Color(0xFFE3F2FD)},
  ];

  final List<Map<String, dynamic>> mostBooked = [
    {
      'title': 'Full Arms + Full Legs\n+ Underarms Korean...',
      'duration': '1 hr 15 mins',
      'price': '₹849',
      'mrp': '₹1699',
      'discount': '50% OFF',
      'badge': '',
    },
    {
      'title': 'Korean Body\nPolishing',
      'duration': '2 hrs 10 mins',
      'price': '₹1799',
      'mrp': '₹4999',
      'discount': '64% OFF',
      'badge': 'Most Booked',
    },
    {
      'title': 'Korean\nCandle Massage',
      'duration': '1 hr 55 mins',
      'price': '₹1089',
      'mrp': '₹2199',
      'discount': '50% OFF',
      'badge': 'Candle',
    },
  ];

  final List<Map<String, dynamic>> trendingWaxing = [
    {
      'badge': 'Korean Wax Ritual',
      'title': 'Full Arms + Full Legs\n+ Underarms Korean...',
      'duration': '1 hr 15 mins',
      'price': '₹849',
      'mrp': '₹1699',
      'discount': '50% OFF',
    },
    {
      'badge': 'Rica Tin Wax',
      'title': 'Full Arms, Underarms\n& Full Legs - Rica Tin...',
      'duration': '1 hr 5 mins',
      'price': '₹898',
      'mrp': '₹1599',
      'discount': '43% OFF',
    },
    {
      'badge': 'Honey Aloe',
      'title': 'Full Arms +\n+ Underarm...',
      'duration': '1 hr 5 mins',
      'price': '₹549',
      'mrp': '₹899',
      'discount': '39% OFF',
    },
  ];

  final List<Map<String, dynamic>> salonAtHome = [
    {'label': 'Waxing'},
    {'label': 'Clean-Up'},
    {'label': 'Mani-Pedi'},
    {'label': 'Facial'},
    {'label': 'Body Polishing'},
    {'label': 'Bleach, Dtan\nScrub'},
  ];

  final List<Map<String, dynamic>> bestSellers = [
    {
      'brand': 'RICA',
      'title': 'Full Arms + Half Legs + Underarms Waxing ..',
      'price': '₹677',
      'mrp': '₹1499',
      'duration': '50 mins',
      'bgColor': Color(0xFFB8860B),
    },
    {
      'brand': 'SOKORA',
      'title': 'Korean Glo...',
      'price': '₹1399',
      'mrp': '₹2499',
      'duration': '60 mins',
      'bgColor': Color(0xFF8B1A1A),
    },
  ];

  final List<String> cities = [
    'Agra',
    'Aligarh',
    'Amritsar',
    'Bareilly',
    'Chandigarh',
    'Delhi',
    'Faridabad',
    'Ghaziabad',
    'Gurugram',
    'Lucknow',
    'Noida',
    'Bangalore',
    'Chennai',
    'Hyderabad',
    'Mysore',
    'Vijayawada',
    'Ahmedabad',
    'Mumbai',
    'Pune',
    'Surat',
    'Kolkata',
    'Bhubaneshwar',
    'Guwahati',
    'Patna',
    'Bhopal',
    'Indore',
    'Nagpur',
    'Raipur',
  ];
}

// ─────────────────────────────────────────
// HOME SCREEN
// ─────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 350.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/banner_iamge.png'),

                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                _buildTopBar(),
                // SizedBox(height: 10),
                _buildSearchBar(),
                SizedBox(height: 50),
                SizedBox(height: 18),
                _buildStatsBanner(),
                _buildEliteBanner(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategories(controller),
                  _buildMostBooked(controller),
                  _buildKoreanGlowPackage(),
                  _buildExperienceKorean(),
                  _buildKoreanGlowRituals(),
                  _buildTrendingNearYou(controller),
                  _buildSalonAtHome(controller),
                  _buildBestSellers(controller),
                  _buildKoreanWaxRitualBanner(),
                  _buildStoriesFromBest(),
                  _buildCityGrid(),
                  _buildFooter(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(controller),
    );
  }

  // ── TOP BAR ──────────────────────────────
  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary, size: 18.sp),
                SizedBox(width: 4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sham Nagar',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                          size: 18.sp,
                        ),
                      ],
                    ),
                    Text(
                      'To, Surat - Kamrej Hwy, Sham Nag...',
                      style: TextStyle(fontSize: 10.sp, color: AppColors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Earn button
          Container(
            margin: EdgeInsets.only(right: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.eliteBg,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(Icons.shield, color: AppColors.gold, size: 14.sp),
                SizedBox(width: 4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Earn',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₹5000',
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Buy Elite button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.eliteBg,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                Text(
                  'Buy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Elite',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── SEARCH BAR ───────────────────────────
  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.grey, size: 20.sp),
          SizedBox(width: 10.w),
          Text(
            "Search for 'Hair Spa'",
            style: TextStyle(color: AppColors.grey, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  // ── HERO BANNER ──────────────────────────
  Widget _buildHeroBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      height: 190.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          // Pink background texture
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFCE4EC), Color(0xFFFFCDD2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹200 Off',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'on your first booking',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      'Use Code: FIRST200',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'BOOK NOW',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right side woman image placeholder
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
              child: Container(
                width: 130.w,
                color: const Color(0xFFFFCDD2),
                child: Center(
                  child: Icon(
                    Icons.spa,
                    size: 50.sp,
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── STATS BANNER ─────────────────────────
  Widget _buildStatsBanner() {
    final stats = [
      {'value': '4.8★', 'label': 'App Ratings'},
      {'value': '1 Cr+', 'label': 'Bookings'},
      {'value': 'Verified', 'label': 'Professionals'},
      {'value': 'Free', 'label': 'Cancellation'},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        // boxShadow: [
        //   BoxShadow(color: Colors.black12, blurRadius: 6.r)
        // ],
      ),
      child: Row(
        children: stats.asMap().entries.map((entry) {
          final i = entry.key;
          final s = entry.value;
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: i < stats.length - 1
                    ? Border(
                        right: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      )
                    : null,
              ),
              child: Column(
                children: [
                  Text(
                    s['value']!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    s['label']!,
                    style: TextStyle(fontSize: 9.sp, color: AppColors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── ELITE BANNER ─────────────────────────
  Widget _buildEliteBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.eliteBg,
        // borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Text(
            'Elite',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              color: AppColors.gold,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'Get ',
                style: TextStyle(color: Colors.white, fontSize: 13.sp),
                children: [
                  TextSpan(
                    text: '10% OFF',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                    ),
                  ),
                  TextSpan(
                    text: ' on all bookings',
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14.sp),
        ],
      ),
    );
  }

  // ── CATEGORIES ───────────────────────────
  Widget _buildCategories(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
          child: Text(
            'Explore Our Categories',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.black,
            ),
          ),
        ),
        SizedBox(
          height: 150.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.categories.length,
            itemBuilder: (_, i) {
              final cat = controller.categories[i];
              return Container(
                width: 80.w,
                margin: EdgeInsets.only(right: 12.w),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: cat['color'] as Color,
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.r),
                              child: Image.asset(
                                "assets/images/img.png",
                                fit: BoxFit.cover,
                                height: 100.h,
                                width: 110.w,
                              ),
                            ),
                          ),
                        ),
                        if (cat['isNew'] == true)
                          Positioned(
                            top: 1.h,
                            right: 1.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                'New',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      cat['label'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ── MOST BOOKED ──────────────────────────
  Widget _buildMostBooked(HomeController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      padding: EdgeInsets.all(16.w),
      color: AppColors.bgCream,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Most Booked',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'in your area',
                      style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.15),
                ),
                child: Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Filter chip
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Salon for Women',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 230.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.mostBooked.length,
              itemBuilder: (_, i) {
                final item = controller.mostBooked[i];
                return _buildServiceCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> item) {
    return Container(
      width: 180.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 110.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14.r),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.spa,
                      size: 36.sp,
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                ),
                if ((item['badge'] as String).isNotEmpty)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        item['badge'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 11.sp,
                        color: AppColors.grey,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        item['duration'],
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        item['price'],
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        item['mrp'],
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '| ${item['discount']}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── KOREAN GLOW PACKAGE ──────────────────
  Widget _buildKoreanGlowPackage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8.r)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Your Package & Save 20% Extra',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 12.h),
          // Package card
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.bgCream,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Grid images placeholder
                    Container(
                      width: 90.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: GridView.count(
                        crossAxisCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(4.w),
                        crossAxisSpacing: 3.w,
                        mainAxisSpacing: 3.h,
                        children: List.generate(
                          4,
                          (_) => Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(
                              Icons.spa,
                              size: 16.sp,
                              color: AppColors.primary.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Korean Glow Special',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Multiple services',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Text(
                                '₹3,183',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '₹6,246',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  '49% OFF',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: AppColors.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 11.sp,
                                color: AppColors.grey,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                '4 hrs 32 mins',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Package items
                ...[
                  'Waxing:  Full Arms, Full Legs & Underarms (Korean Waxing Ritual)',
                  'Premium Facial:  Korean Glow Facial (Korean Glow Facial)',
                  'Manicure & Pedicure:  Mani-Pedi Combo (Korean Luxe Mani & pedi)',
                  'Facial Hair Removal:  Eyebrows (Threading)',
                ].map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5.h, right: 6.w),
                          width: 5.w,
                          height: 5.w,
                          decoration: const BoxDecoration(
                            color: AppColors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(item, style: TextStyle(fontSize: 11.sp)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share, size: 20.sp),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.black,
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'EDIT PACKAGE',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'ADD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── EXPERIENCE KOREAN ────────────────────
  Widget _buildExperienceKorean() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEDE7F6), Color(0xFFF8F0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Experience Korean Care',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF6A1B9A),
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(child: _buildKoreanCard('Korean\nGlow Facial')),
              SizedBox(width: 10.w),
              Expanded(child: _buildKoreanCard('Korean\nBody Polishing')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKoreanCard(String title) {
    return Container(
      height: 170.h,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                color: Colors.blueGrey.shade200,
                child: Center(
                  child: Icon(
                    Icons.self_improvement,
                    size: 50.sp,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12.h,
            left: 12.w,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                shadows: [Shadow(blurRadius: 8, color: Colors.black54)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── KOREAN GLOW RITUALS ──────────────────
  Widget _buildKoreanGlowRituals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
          child: Text(
            'Korean Glow Rituals',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(
          height: 220.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              _buildRitualCard(
                'Stripless Korean Bikini Wax',
                '₹799',
                '₹1499',
                '60 mins',
                [
                  'Single-Use Wax',
                  'Skin Brightening',
                  'Free Hygiene Kit',
                  'No Ingrowns',
                ],
                const Color(0xFFE65100),
              ),
              SizedBox(width: 12.w),
              _buildRitualCard('Korean Glow Wax', '₹1399', '₹2499', '75 mins', [
                'Glass Glow',
                'Step Facial',
                'Brightening',
                'Hydration',
              ], const Color(0xFF4A148C)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRitualCard(
    String title,
    String price,
    String mrp,
    String duration,
    List<String> tags,
    Color color,
  ) {
    return Container(
      width: 250.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag chips
          Wrap(
            spacing: 6.w,
            runSpacing: 4.h,
            children: tags
                .map(
                  (t) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4.r),
                      ],
                    ),
                    child: Text(t, style: TextStyle(fontSize: 9.sp)),
                  ),
                )
                .toList(),
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                price,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 6.w),
              Text(
                mrp,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 11.sp, color: AppColors.grey),
              SizedBox(width: 3.w),
              Text(
                duration,
                style: TextStyle(fontSize: 10.sp, color: AppColors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── TRENDING NEAR YOU ────────────────────
  Widget _buildTrendingNearYou(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
          child: Text(
            'Trending Near You',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
          ),
        ),
        // Filter tabs
        SizedBox(
          height: 36.h,
          child:  ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.trendingTabs.length,
            itemBuilder: (_, i) {
              final selected = controller.trendingTab.value == i;
              return GestureDetector(
                onTap: () => controller.trendingTab.value = i,
                child: Container(
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    controller.trendingTabs[i],
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : AppColors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 230.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.trendingWaxing.length,
            itemBuilder: (_, i) {
              final item = controller.trendingWaxing[i];
              return _buildServiceCard(item);
            },
          ),
        ),
      ],
    );
  }

  // ── SALON AT HOME ────────────────────────
  Widget _buildSalonAtHome(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Salon At Home For Women',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
              ),
              Row(
                children: [
                  Text(
                    'SEE ALL',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.9,
          ),
          itemCount: controller.salonAtHome.length,
          itemBuilder: (_, i) {
            final item = controller.salonAtHome[i];
            return Container(
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.spa,
                    size: 30.sp,
                    color: AppColors.primary.withOpacity(0.4),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    item['label']!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ── BEST SELLERS ─────────────────────────
  Widget _buildBestSellers(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
          child: Text(
            'Our Best Sellers',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(
          height: 240.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.bestSellers.length,
            itemBuilder: (_, i) {
              final item = controller.bestSellers[i];
              return Container(
                width: 240.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  color: item['bgColor'] as Color,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['brand'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item['title'],
                      style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['price'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              item['mrp'],
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11.sp,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ── 3 STEP KOREAN WAX RITUAL BANNER ──────
  Widget _buildKoreanWaxRitualBanner() {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFD4A843).withOpacity(0.15),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFD4A843).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full Arms, Full Legs & Underarms',
                  style: TextStyle(fontSize: 10.sp, color: AppColors.grey),
                ),
                SizedBox(height: 4.h),
                Text(
                  '3 Step Korean\nWax Ritual',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Scrub + Wax + Brightening Lotion',
                  style: TextStyle(fontSize: 10.sp, color: AppColors.grey),
                ),
                SizedBox(height: 8.h),
                Text(
                  '@  ₹849',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D3A1A),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 90.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: const Color(0xFFD4A843).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.self_improvement,
              size: 50.sp,
              color: const Color(0xFF5D3A1A).withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  // ── STORIES FROM THE BEST ────────────────
  Widget _buildStoriesFromBest() {
    final celebrities = ['DIVYANKA TRIPATHI', 'EKTA KAPOOR'];
    final subtitles = ['On our HydraGlo Services', 'Trusts our Glow Services'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
          child: Text(
            'Stories From The Best',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: celebrities.length,
            itemBuilder: (_, i) => Container(
              width: 180.w,
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  colors: i == 0
                      ? [const Color(0xFF1565C0), const Color(0xFF42A5F5)]
                      : [const Color(0xFF6A1B9A), const Color(0xFFAB47BC)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.person,
                      size: 80.sp,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  Positioned(
                    bottom: 16.h,
                    left: 12.w,
                    right: 12.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          celebrities[i],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          subtitles[i],
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── CITY GRID ────────────────────────────
  Widget _buildCityGrid() {
    final regions = {
      'NORTH':
          'Agra | Aligarh | Amritsar | Bareilly | Chandigarh | Delhi | '
          'Faridabad | Ghaziabad | Greater Noida | Gurugram | Haldwani | Haridwar | '
          'Jammu | Jhansi | Kanpur | Lucknow | Ludhiana | Meerut | Moradabad | '
          'Noida | Panchkula | Roorkee | Rudrapur | Srinagar | Zirakpur',
      'SOUTH':
          'Bangalore | Chennai | Hyderabad | Mysore | Vijayawada | Tirupati',
      'CENTRAL':
          'Bhopal | Bilaspur | Gwalior | Indore | Jabalpur | Nagpur | Prayagraj | Raipur | Ujjain | Varanasi',
      'EAST':
          'Bhagalpur | Bhubhaneshwar | Cuttack | Guwahati | Kolkata | Patna | Rourkela | Siliguri',
      'WEST':
          'Ahmedabad | Gandhi Nagar | Mumbai | Pune | Pimpri-Chinchwad | Surat',
    };

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: regions.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  entry.value,
                  style: TextStyle(fontSize: 11.sp, color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── FOOTER ───────────────────────────────
  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "India's Most Loved\nHome Salon & Spa App",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Crafted with ',
                style: TextStyle(fontSize: 13.sp, color: AppColors.grey),
              ),
              Icon(Icons.favorite, color: AppColors.primary, size: 14.sp),
              Text(
                ' by team ',
                style: TextStyle(fontSize: 13.sp, color: AppColors.grey),
              ),
              Text(
                'yesmadam',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── BOTTOM NAV ───────────────────────────
  Widget _buildBottomNav(HomeController controller) {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.circle_outlined, 'label': 'Ozuzu'},
      {'icon': null, 'label': 'Korean\nSummer'}, // center FAB style
      {'icon': Icons.calendar_today_outlined, 'label': 'Bookings'},
      {'icon': Icons.person_outline, 'label': 'Account'},
    ];

    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          children: List.generate(items.length, (i) {
            final item = items[i];
            final isCenter = i == 2;
            final isSelected = controller.currentBottomTab.value == i;

            if (isCenter) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.currentBottomTab.value = i,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 4.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 52.w,
                          height: 52.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFF1565C0), Color(0xFF4FC3F7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Korean\nSummer',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.currentBottomTab.value = i,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: isSelected ? AppColors.primary : AppColors.grey,
                      size: 22.sp,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: isSelected ? AppColors.primary : AppColors.grey,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                    if (isSelected && i != 2)
                      Container(
                        margin: EdgeInsets.only(top: 3.h),
                        width: 20.w,
                        height: 2.5.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
*/
