import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
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
import '../../data/native_pdf_service.dart';
import '../../model/lesson_model.dart';
import '../../model/question_data.dart';
import '../../utils/sound_player.dart';
import 'package:pdf/widgets.dart' as pw;

class ScoreController extends GetxController {
  RxString name = "".obs;
  RxString subject = "".obs;
  RxString lesson = "".obs;
  RxString title = "".obs;
  RxBool isLoading = false.obs;
  RxInt rightAnswer = 0.obs;
  RxBool fromFavourite = false.obs;
  RxInt score = 0.obs;
  RxInt wrongAnswer = 0.obs;
  RxInt id = 0.obs;
  RxInt start = 0.obs;
  ScoreData? scoreData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>;
    print("fromFavourite===${args}");
    id.value = args['id'];
    fromFavourite.value = args['fromFavourite'] ?? false;

    SoundPlayer.clapSound();

    getData();
  }

  getData() async {
    isLoading.value = true;
    String medium = (await AppData().isTamil())
        ? "Tamil Medium"
        : "English Medium";
    name.value = await AppData().getStudentName();
    subject.value = await AppData().getTableName();
    lesson.value = await AppData().getLesson();
    String t = await AppData().getTitle();

    title.value = '$medium,$t,${lesson.value}';
    await loadData();
    isLoading.value = false;
    update();
  }

  Future<void> loadData() async {
    final db = DatabaseHelper();

    scoreData = await db.getScoreData(id.value);

    isLoading.value=false;
    print("isLoading==${isLoading.value}===${!isLoading.value &&
        scoreData != null}");

  }


  Future<QuestionData?> getHistoryData(int i) async {
    final db = DatabaseHelper();

    List<QuestionData> list  = await db.getHistory(scoreData!.tableName,i);

    if(list.isEmpty){
      return null;
    }
    return list.first;
  }



  String formatTime() {
    final minutes = ((double.tryParse(scoreData!.totalTime)??0) ~/ 60).toString().padLeft(1, '0');
    final seconds = ((double.tryParse(scoreData!.tableName)??0) % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }



  sharePdf()async{
    generateAndSharePDF();
  }

  Future<void> generateAndSharePDF() async {

    if(scoreData==null){
      return;
    }

    String userName = await AppData().getStudentName();
    List<QuestionData> questionList = await AppData().getQuizList();
    if(questionList.isEmpty){
      return;
    }

    // final pdf = pw.Document();
    var fontData = await rootBundle.load(
      "assets/NotoSansTamil_Condensed-Medium.ttf",
      // "assets/Roboto_Condensed-SemiBold.ttf",
    );

    bool isTamil =await AppData().isTamil();

      String t = await AppData().getTitle();

    fontData = await rootBundle.load("assets/fonts/NotoSansTamil_Condensed-Medium.ttf");



    int i =0;


    final data = {
      "name": userName,
      "lesson": scoreData!.lesson,
      "medium": "Tamil",
      "date": scoreData!.scoreDate.split(' ')[0],
      "duration": scoreData!.totalTime,
      "total": scoreData!.totalQuestion,
      "correct": scoreData!.correct,
      "wrong": scoreData!.wrong,
      "score": scoreData!.totalScore,
      "subject": t,
      "tamil": isTamil,
      "questions": questionList.map((q) {

        List<Uint8List?> images = [
          q.imageOption1,
          q.imageOption2,
          q.imageOption3,
          q.imageOption4,
        ];
        Uint8List? answerImage;
        Uint8List? wrongImage;
        bool imageOptions = false;

        for (int i = 0; i < images.length; i++) {
          if (images[i] == null) {
            imageOptions = false;
            break;
          }else{
            imageOptions = true;
          }
        }

        bool userAns=(q.correctAnswer == (q.userAnswer??""));
        print("imageOptions===${imageOptions} ===${q.correctAnswer}===${q.userAnswer}");

        if(imageOptions){
          int   optionLetter = ['A', 'B', 'C', 'D'].indexOf(q.correctAnswer)??0;
          int   wLetter = ['A', 'B', 'C', 'D'].indexOf(q.userAnswer??"")??0;
          if(optionLetter >=0) {
            answerImage = images[optionLetter];
          }


          if(!userAns && wLetter >=0){
            wrongImage = images[wLetter];
          }

        }
        i++;

        print("answerImage==$userAns=${i}==${answerImage}==${wrongImage}===${q.imageQuestion}===${i}==");


        return {
          "question": q.question,
          "correct": q.correctAnswer,
          "user": (q.userAnswer ?? "-").isEmpty?"-":(q.userAnswer ?? "-"),
          'image_option1': q.imageOption1,
          'image_option2': q.imageOption2,
          'image_option3': q.imageOption3,
          'image_option4': q.imageOption4,
          'image_question': q.imageQuestion,
          'correct_image': answerImage,
          'wrong_image': wrongImage,
          'userAnswer': userAns,
        };
      }).toList()
    };

    print("data==${scoreData!.totalScore}===${scoreData!.wrong}===${scoreData!.correct}");

    final path = await NativePdfService.generateTamilPdf(data);

    if (path != null) {
      await Share.shareXFiles([XFile(path)],
          text: 'Here is the quiz PDF!');
    }

//     if (await AppData().isTamil()) {
//       fontData = await rootBundle.load("assets/fonts/NotoSansTamil_Condensed-Medium.ttf");
//       final data = {
//         "name": await AppData().getStudentName(),
//         "lesson": scoreData!.lesson,
//         "medium": "Tamil",
//         "date": scoreData!.scoreDate.split(' ')[0],
//         "duration": scoreData!.totalTime,
//         "total": scoreData!.totalQuestion,
//         "correct": scoreData!.correct,
//         "wrong": scoreData!.wrong,
//         "score": scoreData!.totalScore,
//         "tamil": true,
//         "questions": questionList.map((q) => {
//           "question": q.question,
//           "correct": q.correctAnswer,
//           "user": q.userAnswer ?? "-"
//         }).toList()
//       };
//
//       print("data==${scoreData!.totalScore}===${scoreData!.wrong}===${scoreData!.correct}");
//
//       final path = await NativePdfService.generateTamilPdf(data);
//
//       if (path != null) {
//         await Share.shareXFiles([XFile(path)],
//             text: 'Here is the quiz PDF!');
//       }
//
//     }else{
//
//       final ttf = pw.Font.ttf(fontData);
//
// // Extract just date
//       String onlyDate = scoreData!.scoreDate.split(' ')[0];
//
//
//       String medium = (await AppData().isTamil())
//           ? TextData.tamilMedium
//           : TextData.englishMedium;
//
//       String t = await AppData().getTitle();
//
// // PDF Build
//       pdf.addPage(
//         pw.MultiPage(
//           pageFormat: PdfPageFormat.a4,
//           margin: const pw.EdgeInsets.all(24),
//           build: (pw.Context context) => [
//             // ---------- HEADER ----------
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(
//                   TextData.quizReport,
//                   style: pw.TextStyle(
//                     font: ttf,
//                     fontSize: 24,
//                     fontWeight: pw.FontWeight.bold,
//                     color: PdfColors.blue900,
//                   ),
//                 ),
//                 pw.SizedBox(height: 4),
//                 pw.Container(height: 1, color: PdfColors.grey300),
//                 pw.SizedBox(height: 12),
//
//                 // Metadata
//                 pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Text('${TextData.name}: $userName', style: pw.TextStyle(font: ttf, fontSize: 13)),
//                     pw.Text('${TextData.lesson}: ${scoreData!.lesson} ($medium,$t})', style: pw.TextStyle(font: ttf, fontSize: 13)),
//
//                   ],
//                 ),
//                 pw.SizedBox(height: 4),
//                 pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Text('${TextData.duration}: ${scoreData!.totalTime}', style: pw.TextStyle(font: ttf, fontSize: 13)),
//                     pw.Text('${TextData.date}: $onlyDate', style: pw.TextStyle(font: ttf, fontSize: 13)),
//
//                   ],
//                 ),
//                 pw.SizedBox(height: 18),
//
//                 // ---------- SCORE SUMMARY ----------
//                 pw.Container(
//                   padding: const pw.EdgeInsets.all(12),
//                   decoration: pw.BoxDecoration(
//                     color: PdfColors.blue50,
//                     borderRadius: pw.BorderRadius.circular(8),
//                     border: pw.Border.all(color: PdfColors.blue200),
//                   ),
//                   child: pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//                     children: [
//                       _scoreBox(ttf, TextData.totalQuestions, '${scoreData!.totalQuestion}'),
//                       _scoreBox(ttf, TextData.correct, scoreData!.correct, PdfColors.green800),
//                       _scoreBox(ttf, TextData.wrong, scoreData!.wrong, PdfColors.red800),
//                       _scoreBox(ttf, TextData.score, scoreData!.totalScore, PdfColors.blue900),
//                     ],
//                   ),
//                 ),
//
//                 pw.SizedBox(height: 24),
//
//                 // ---------- Section Header ----------
//                 pw.Text(
//                   TextData.questionReview,
//                   style: pw.TextStyle(
//                     font: ttf,
//                     fontSize: 16,
//                     fontWeight: pw.FontWeight.bold,
//                     color: PdfColors.blue800,
//                   ),
//                 ),
//                 pw.SizedBox(height: 12),
//               ],
//             ),
//
//             // ---------- QUESTIONS ----------
//             ...questionList.asMap().entries.map((entry) {
//               int index = entry.key + 1;
//               final quiz = entry.value;
//               final isCorrect = quiz.userAnswer == quiz.correctAnswer;
//
//               return pw.Container(
//                 margin: const pw.EdgeInsets.only(bottom: 5),
//                 padding: const pw.EdgeInsets.all(5),
//                 // decoration: pw.BoxDecoration(
//                 //   color: PdfColors.grey100,
//                 //   borderRadius: pw.BorderRadius.circular(6),
//                 //   border: pw.Border.all(color: PdfColors.grey300),
//                 // ),
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       '$index. ${quiz.question}',
//                       style: pw.TextStyle(
//                         font: ttf,
//                         fontSize: 14,
//                         fontWeight: pw.FontWeight.bold,
//                         color: PdfColors.black,
//                       ),
//                     ),
//                     pw.SizedBox(height: 8),
//                     pw.Text(
//                       '${TextData.correctAnswer}: ${quiz.correctAnswer}',
//                       style: pw.TextStyle(
//                         font: ttf,
//                         fontSize: 13,
//                         color: PdfColors.green800,
//                       ),
//                     ),
//                     pw.SizedBox(height: 4),
//                     pw.Text(
//                       '${TextData.yourAnswer}: ${quiz.userAnswer ?? "-"}',
//                       style: pw.TextStyle(
//                         font: ttf,
//                         fontSize: 13,
//                         color: isCorrect ? PdfColors.green : PdfColors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       );
//
//       // Save to file
//       final output = await getTemporaryDirectory();
//       final file = File("${output.path}/quiz_questions.pdf");
//       await file.writeAsBytes(await pdf.save());
//
//       print("save==${file.path}");
//
//
//       await Share.shareXFiles([XFile(file.path)], text: 'Here is the quiz PDF!');
//     }
//

  }


  pw.Widget _scoreBox(pw.Font font, String title, String value
      , [PdfColor? valueColor]) {
    return pw.Column(
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            font: font,
            fontSize: 11,
            color: PdfColors.grey800,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(
            font: font,
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: valueColor ?? PdfColors.black,
          ),
        ),
      ],
    );
  }



}
