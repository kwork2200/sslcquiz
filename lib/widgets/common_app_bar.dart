import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';
import 'common_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final int? cartCount;
  final int? notificationCount;
  final Widget? leading;
  final List<Widget>? actions;
  final bool forceMaterialTransparency;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Function? back;

  const CommonAppBar({
    super.key,
    this.title,
    this.cartCount = 0,
    this.notificationCount = 0,
    this.leading,
    this.actions,
    this.forceMaterialTransparency = false,
    this.iconColor,
    this.textColor,
    this.back,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        forceMaterialTransparency: forceMaterialTransparency,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            if (back == null) {
              Get.back();
            } else {
              back!();
            }
          },
          child: Icon(Icons.arrow_back_ios, color: AppColors.white),
        ),

        leadingWidth: 10.w,

        // centerTitle: true,
        actions: actions ?? [],

        title: CommonText(
          text: title ?? '',
          fontSize: AppDimensions.fontLarge - 2,
          color: AppColors.white,
          fontWeight: AppFontWeights.bold,
          fromTitle: true,
        ).paddingOnly(left: 25.w),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
