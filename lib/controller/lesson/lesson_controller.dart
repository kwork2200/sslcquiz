import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sslcquiz/data/data_constant.dart';
import 'package:sslcquiz/model/subject_model.dart';
import 'package:sslcquiz/screens/subject/subject_screen.dart';
import 'package:sslcquiz/utils/constant.dart';
import 'package:sslcquiz/utils/text_data.dart';

import '../../data/app_data.dart';
import '../../data/database_helper.dart';
import '../../model/lesson_model.dart';

class LessonController extends GetxController {

  // List<Lesson> getLessons() {
  //   return List.generate(30, (index) {
  //     int lessonNumber = index + 1;
  //     return Lesson(
  //       table: '${TextData.lesson} $lessonNumber',
  //       image: '${Constant.assetLessonPath}lesson$lessonNumber.png', // adjust path as needed
  //     );
  //   });
  // }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getData();
  }


  RxBool isTamil=false.obs;
  RxString subject = "".obs;
  RxString lesson = "".obs;
  getData() async {
    isTamil.value = await AppData().isTamil();
    subject.value = await AppData().getTableName();
    lesson.value = await AppData().getLesson();
    update();
  }
  final db = DatabaseHelper();


  Future<bool> loadData(String i) async {

  var questionList =  await db.getAllItems(subject.value, i);
  print("questionList==${questionList.length}");
    if(questionList.isEmpty){
      return false;
    }

  return true;

  }

  Future<List<Lesson>> getLessons() async {
    List<Lesson> lessons = [];
    // subject.value = await AppData().getTableName();
    //
    // for (int index = 0; index < 30; index++) {
    //   int lessonNumber = index + 1;
    //
    //   bool hasData = await loadData('${TextData.lesson} $lessonNumber');
    //   if (hasData) {
    //     lessons.add(
    //       Lesson(
    //         table: '${TextData.lesson} $lessonNumber',
    //         image: '${Constant.assetLessonPath}lesson$lessonNumber.png',
    //       ),
    //     );
    //   }
    //   print("lessons==${lessons.length}===$hasData");
    //
    // }
    //
    // return lessons;
    //

    try {
      subject.value = await AppData().getTableName();

      // Generate 30 parallel tasks
      List<Future<Lesson?>> futures = List.generate(30, (index) async {
        int lessonNumber = index + 1;
        String lessonKey = '${TextData.lesson} $lessonNumber';

        bool hasData = await loadData(lessonKey);

        print("Checking $lessonKey -> $hasData");

        if (hasData) {
          return Lesson(
            table: lessonKey,
            image: '${Constant.assetLessonPath}lesson$lessonNumber.png',
          );
        } else {
          return null;
        }
      });

      // Wait for all loadData() calls to finish
      List<Lesson?> results = await Future.wait(futures);

      // Filter out nulls
      lessons = results.whereType<Lesson>().toList();

      print("✅ Final lessons count: ${lessons.length}");

    } catch (e,stackTrace) {
      print("❌ Error in getLessons: $e");
      print("🪵 StackTrace: $stackTrace");

    }

    return lessons;

  }


}
