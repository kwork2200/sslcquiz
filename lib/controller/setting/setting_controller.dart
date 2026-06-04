import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sslcquiz/controller/question/question_controller.dart';
import 'package:sslcquiz/data/app_data.dart';
import 'package:sslcquiz/data/data_constant.dart';
import 'package:sslcquiz/model/score_data.dart';
import 'package:sslcquiz/model/subject_model.dart';
import 'package:sslcquiz/screens/subject/subject_screen.dart';
import 'package:sslcquiz/utils/constant.dart';
import 'package:sslcquiz/utils/text_data.dart';
import 'package:vibration/vibration.dart';
import 'package:intl/intl.dart';

import '../../data/database_helper.dart';
import '../../model/lesson_model.dart';
import '../../model/question_data.dart';
import '../../screens/home/name_dialog.dart';
import '../../screens/setting/change_name_dialog.dart';
import '../../utils/sound_player.dart';
import 'package:pdf/widgets.dart' as pw;

class SettingController extends GetxController {

  RxString name = "".obs;
  RxString medium = "".obs;
  RxString language = "".obs;
  RxBool isDarkMode = false.obs;
  RxBool isSound = false.obs;
  RxBool isShuffle= false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getData();
  }

  getData() async {
    name.value = await AppData().getStudentName();
    medium.value = (await AppData().isTamil()) ? TextData.tamil : "English";
    isSound.value = (await AppData().getSound());
    isShuffle.value = (await AppData().getShuffle());
    language.value = (await AppData().isTamil())
        ? TextData.tamilMedium
        : TextData.englishMedium;

    update();
  }

  changeTheme() async {
    if (isDarkMode.value) {
      isDarkMode.value = false;
    } else {
      isDarkMode.value = true;
    }
    update();
  }


  changeShuffleData() async {
    await AppData().setShuffle(!isShuffle.value);
    getData();
    update();
  }



  changeSound() async {
    await AppData().setSound(!isSound.value);
    getData();
    update();
  }

  changeName(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing on tap outside (optional)
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: ChangeNameDialog(name: name.value),
        );
      },
    ).then((value) {
      getData();
    });

    update();
  }

  Future<void> refreshDatabase(BuildContext context) async {
    // Show confirmation dialog
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Refresh Database'),
        content: Text(
          'This will replace the current database with the latest version from assets. All your quiz history and favorites will be preserved. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Refresh', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Refreshing database...'),
                  ],
                ),
              ),
            ),
          ),
        );

        final db = DatabaseHelper();
        await db.forceRefreshDatabase();

        Navigator.pop(context); // Close loading dialog

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Database refreshed successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } catch (e) {
        Navigator.pop(context); // Close loading dialog
        
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error refreshing database: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
    
    update();
  }
}
