import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sslcquiz/data/app_data.dart';
import 'package:sslcquiz/data/data_constant.dart';
import 'package:sslcquiz/model/subject_model.dart';
import 'package:sslcquiz/screens/subject/subject_screen.dart';
import 'package:sslcquiz/utils/constant.dart';
import 'package:sslcquiz/utils/text_data.dart';
import 'package:vibration/vibration.dart';
import 'package:intl/intl.dart';

import '../../data/database_helper.dart';
import '../../model/lesson_model.dart';
import '../../model/question_data.dart';
import '../../routes/app_pages.dart';
import '../../utils/sound_player.dart';
import 'package:pdf/widgets.dart' as pw;

class QuestionController extends GetxController {
  RxString subject = "".obs;
  RxString lesson = "".obs;
  RxString title = "".obs;
  RxBool isLoading = false.obs;
  RxBool isPlay = false.obs;
  List<QuestionData> questionList = [];
  RxInt rightAnswer = 0.obs;
  RxInt score = 0.obs;
  RxInt wrongAnswer = 0.obs;
  RxInt index = 0.obs;
  RxInt selectedAnswerIndex = (-1).obs;
  RxBool answerChecked = false.obs;
  RxBool fromFavourite = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>;
    fromFavourite.value = args['fromFavourite'] ?? false;

    getData();
  }
  
  @override
  void onReady() {
    super.onReady();
    ever(Get.routing.obs, (_) {
      if (Get.currentRoute == AppRoutes.questionScreen && !fromFavourite.value) {
        refreshFavoriteStates();
      }
    });
  }
  
  Future<void> refreshFavoriteStates() async {
    if (!fromFavourite.value && questionList.isNotEmpty) {
      final db = DatabaseHelper();
      await _syncFavoriteStates(db);
      update();
    }
  }

  @override
  void onClose() {
    cancelTimer();
    super.onClose();
  }

  String medium = "";

  getData() async {
    isLoading.value = true;
    questionList.clear();
    index.value = 0;
    rightAnswer.value = 0;
    score.value = 0;
    wrongAnswer.value = 0;
    selectedAnswerIndex.value = -1;
    answerChecked.value = false;
    start = 0;

    await setTitle();
    await _loadData();
    
    if (!fromFavourite.value && questionList.isNotEmpty) {
      final db = DatabaseHelper();
      await _syncFavoriteStates(db);
    }
    
    isLoading.value = false;
    startTimer();
    update();
  }

  setTitle() async {

    if (!fromFavourite.value) {
      // Always fetch fresh medium value from SharedPreferences
      medium = (await AppData().isTamil()) ? TextData.tamilMedium : TextData.englishMedium;
      subject.value = await AppData().getTableName();
      lesson.value = await AppData().getLesson();
      String t = await AppData().getTitle();

      title.value = '$medium,$t,${lesson.value}';

      print(" Medium loaded: $medium, Subject: ${subject.value}, Lesson: ${lesson.value}");

      if(questionList.isNotEmpty) {
        QuestionData questionData = questionList[index.value];

        selectedAnswerIndex.value = questionData.options.indexOf(
            questionData.userAnswer ?? "") ?? -1;

        answerChecked.value = selectedAnswerIndex.value >= 0;

        print("selectedAnswerIndex.value==${selectedAnswerIndex.value}");
      }
    } else {
      if (questionList.isNotEmpty) {
        QuestionData questionData = questionList[index.value];
        medium = questionData.medium;
        subject.value = questionData.tableName;
        lesson.value = questionData.lesson;

        List<String> subjectArray = subject.value.split("_");
        String sub = firstCharCaps(subjectArray[1]);

        title.value = '$medium,$sub,${lesson.value}';
      }
    }
  }

  String firstCharCaps(String msg) {
    if (msg.isEmpty) return "";
    return msg[0].toUpperCase() + msg.substring(1);
  }

  Future<void> _loadData() async {
    final db = DatabaseHelper();

    if (fromFavourite.value) {

      questionList = await db.getAllFavouriteData();
      setTitle();
    } else {
      questionList = await db.getAllItems(subject.value, lesson.value);
      await _syncFavoriteStates(db);
    }

    if(questionList.isEmpty){
      Get.back();
    }
  }
  
  Future<void> _syncFavoriteStates(DatabaseHelper db) async {
    List<QuestionData> favorites = await db.getFavouritesByFilter(
      medium: medium,
      tableName: subject.value,
      lesson: lesson.value,
    );
    Set<int> favoriteIds = favorites
        .map((fav) => fav.refId ?? 0)
        .toSet();
    for (var question in questionList) {
      question.favourite = favoriteIds.contains(question.id ?? 0);
    }
  }

  Future<void> onFavourite() async {
    final db = DatabaseHelper();
    QuestionData questionData = questionList[index.value];
    String fav = (questionData.favourite ??
        false) ? "true" : "false";
    String updateValue = fav.toLowerCase() == "true" ? "false" : "true";

    if (fromFavourite.value) {
      if (fav.toLowerCase() == "true") {
        await db.removeFavouriteByRefId(
          questionData.refId ?? 0,
          questionData.medium,
          questionData.tableName,
          questionData.lesson,
        );
        await db.updateFavourite(
          questionData.tableName,
          questionData.refId ?? 0,
          "false",
        );
        questionList.removeAt(index.value);
        if (questionList.isEmpty) {
          Get.back();
          return;
        }
        if (index.value >= questionList.length) {
          index.value = questionList.length - 1;
        }
        clearAnswer();
        setTitle();
      }
    } else {
      if (fav.toLowerCase() == "true") {
        await db.deleteFavourite(
          questionData.id ?? 0,
          medium,
          subject.value,
          lesson.value,
        );
      } else {

        print("fav===tre");

        var favMap = {
          "medium": medium,
          "tb_name": subject.value,
          "lesson": lesson.value,
          "question": questionData.question,
          "option1": questionData.option1,
          "option2": questionData.option2,
          "option3": questionData.option3,
          "option4": questionData.option4,
          "correct": questionData.correctAnswer,
          "score": questionData.score,
          "ref_id": questionData.id ?? 0,
          "favourite": 1,
        };

        if (questionData.imageOption1 != null) {
          favMap["image_option1"] = questionData.imageOption1;
        }

        if (questionData.imageOption2 != null) {
          favMap["image_option2"] = questionData.imageOption2;
        }

        if (questionData.imageOption3 != null) {
          favMap["image_option3"] = questionData.imageOption3;
        }

        if (questionData.imageOption4 != null) {
          favMap["image_option4"] = questionData.imageOption4;
        }

        if (questionData.imageQuestion != null) {
          favMap["image_question"] = questionData.imageQuestion;
        }

        await db.insertFavourite(favMap);
      }
      await db.updateFavourite(
        subject.value,
        questionData.id ?? 0,
        updateValue,
      );
      questionData.favourite = updateValue == "false" ? false : true;
    }


    update();
  }
  Future<void> storeScore() async {



    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy HH:mm');
    String date = formatter.format(now);
    List<int> idList = questionList.map((q) => q.id ??0).toList();

    String idString = idList.join(',');


    String jsonString = jsonEncode(questionList);

    print("json===${jsonString}");


    var  map = {
      "tb_name": fromFavourite.value
          ? "Subject_Favourite question"
          : subject.value,
      "score_date": date,
      "total_time": formatTime(),
      "correct": rightAnswer.value,
      "wrong": wrongAnswer.value,
      "total_score": score.value,
      "lesson": lesson.value,
      "total_question": questionList.length,
      "ref_id": jsonString,
    };
    print("insertScoreData===${map}");

    final db = DatabaseHelper();
    int id = await db.insertScoreData(map);
    await AppData().saveQuizList(questionList);
    print("id===${id}");

    Get.offNamed(AppRoutes.scoreScreen, arguments: {
      'id': id,
      'fromFavourite': fromFavourite.value,
    });


  }

  void nextQuestion({bool formSelect=false}) async {

    print("object==${index.value}===${questionList.length - 1}");

    if (index.value < questionList.length - 1) {


      Future.delayed(Duration(seconds:formSelect? 1:0), () {
        clearAnswer();
        index.value++;
        setTitle();
        update();
      });


    } else {
      await storeScore();
    }

  }

  void previousQuestion() {
    clearAnswer();
    if (index.value > 0) {
      index.value--;
    }
    setTitle();
    update();
  }

  void playPauseTimer() {
    if (isPlay.value) {
      isPlay.value = false;
      cancelTimer();
    } else {
      isPlay.value = true;
      startTimer();
    }
  }

  clearAnswer() {
    selectedAnswerIndex.value = -1;
    answerChecked.value = false;
  }

  Timer? _timer;
  int start = 0;

  void startTimer() {
    isPlay.value = true;
    update();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      start++;
      update();
    });
  }

  String formatTime() {
    final minutes = (start ~/ 60).toString().padLeft(1, '0');
    final seconds = (start % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  onBack() {
    _timer!.cancel();
    onBack();
  }

  void selectAnswer(int selectedIndex) async {
    QuestionData questionData = questionList[index.value];

    if (questionData.userAnswer == null || questionData.userAnswer!.isEmpty ) {
      // if (await Vibration.hasVibrator() ?? false) {
      //   Vibration.vibrate(duration: 100); // vibrate for 100ms
      // }

      selectedAnswerIndex.value = selectedIndex;
      answerChecked.value = true;
      questionData.userAnswer =
          questionList[index.value].options[selectedIndex];

      if ((questionData.userAnswer ?? 0) == questionData.correctAnswer) {
        rightAnswer.value = rightAnswer.value + 1;
        score.value = score.value + 1;
        SoundPlayer.playCorrect();
      } else {
        SoundPlayer.playWrong();
        wrongAnswer.value = wrongAnswer.value + 1;
      }
      update();
      nextQuestion(formSelect: true);
    }
  }

}
