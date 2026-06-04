import 'dart:convert';

import 'package:sslcquiz/model/question_data.dart';

class ScoreData {
  final String tableName;
  final String scoreDate;
  final String totalTime;
  final String correct;
  final String wrong;
  final String totalScore;
  final String lesson;
  final List<QuestionData> refId;
  final int totalQuestion;
  final int id;


  ScoreData({
    required this.tableName,
    required this.scoreDate,
    required this.totalTime,
    required this.correct,
    required  this.wrong,
    required  this.totalScore,
    required  this.lesson,
    required  this.totalQuestion,
    required this.id,
    required this.refId,
  });

  factory ScoreData.fromJson(Map<String, dynamic> json) {



    List<QuestionData> idList = [];

    if (json['ref_id'] != null && (json['ref_id'] as String).isNotEmpty) {
      List<dynamic>   list = jsonDecode(json['ref_id']);

     idList = list
          .map((item) => QuestionData.fromJson(item as Map<String, dynamic>))
          .toList();



    }

    return ScoreData(
      tableName: json['tb_name']??"",
      scoreDate: json['score_date']??"",
      totalTime: json['total_time']??"",
      correct: json['correct']??"",
      wrong: json['wrong']??"",
      totalScore: json['total_score']??"",
      lesson: json['lesson']??"",
      totalQuestion: json['total_question']?? 0,
      id: json['id']??0,
      refId: idList,


    );
  }
}
