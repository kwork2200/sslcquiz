
import 'dart:typed_data';

class QuestionData {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final Uint8List? imageOption1;
  final Uint8List? imageOption2;
  final Uint8List? imageOption3;
  final Uint8List? imageOption4;
  final Uint8List? imageQuestion;
  final List<Uint8List?> imageList;
  final String medium;
  final String tableName;
   String? userAnswer;
  final String lesson;
  int? id;
  int? score;
  bool? favourite;
  int? refId;

  QuestionData({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.lesson,
    required this.imageList,
    this.score,
    this.id,
    required    this.option1,
    required  this.option2,
    required  this.option3,
    required  this.option4,
    required  this.imageOption1,
    required  this.imageOption2,
    required  this.imageOption3,
    required  this.imageOption4,
    this.userAnswer,
    this.favourite,
    required this.imageQuestion,
    required this.medium,
    required this.tableName,
    required this.refId,
  });


  String getValue(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) {
      return "-";
    }
    return value.toString();
  }


  factory QuestionData.fromJson(Map<String, dynamic> json,{bool shuffle=false}) {
    Uint8List? convert(dynamic data) {
      if (data == null) return null;
      return Uint8List.fromList(List<int>.from(data));
    }
    List<String> optionList = [];
    List<Uint8List?> imageList = [];

    optionList.addAll([
      json['option1'],
      json['option2'],
      json['option3'],
      json['option4']
    ].map((e) => (e == null || e.toString().trim().isEmpty) ? "-" : e.toString()));

    bool fav = false;

    if (json['favourite'] != null) {
      var favValue = json['favourite'];
      if (favValue.toString().toLowerCase() == "true" || favValue == 1 || favValue == "1") {
        fav = true;
      }
    }
    print(json);
    print(json['image_question']);
    print(json.containsKey('image_question'));
    print(json['image_question']?.runtimeType);


    Uint8List? imageBytes;

    if (json['image_question'] != null) {
      imageBytes = Uint8List.fromList(List<int>.from(json['image_question']));
    }
    // String imageQuestion = json['image_question']?.runtimeType ==null ?   "":json['image_question'] ?? "";


    if(imageBytes !=null){
       imageList = [];
      // optionList.add(json['image_option1'] ??"");
      // optionList.add(json['image_option2'] ??"");
      // optionList.add(json['image_option3'] ??"");
      // optionList.add(json['image_option4']??"");


       imageList = List<Uint8List?>.generate(4, (index) {
         return convert(json['image_option${index + 1}']);
       });



    }
    optionList.shuffle();
    int s = json['score'] == null  ?0 : (int.tryParse(json['score'].toString())??0);
    int id = json['id'] == null  ?0 : (int.tryParse(json['id'].toString())??0);

    // if(shuffle){
    //    optionList.shuffle();
    // }

    print("imageList==${imageList.length}==${json["question"]}");


    return QuestionData(
      question: json['question'],
      // imageQuestion: "-",
      imageQuestion:imageBytes ,
      options: optionList,
      imageList: imageList,
      correctAnswer: json['correct']??"",
      lesson: json['lesson'],
      score: s ,
      id: id,
      favourite: fav,
      option1: optionList[0],
      option2: optionList[1],
      option3: optionList[2],
      option4: optionList[3],

      imageOption1:imageList.length > 0?   imageList[0]:null,
      imageOption2:imageList.length > 1?   imageList[1]:null,
      imageOption3:imageList.length > 2?   imageList[2]:null,
      imageOption4:imageList.length > 3?   imageList[3]:null,
      medium: json['medium']??"",
      tableName: json['tb_name']??"",
      refId: json['ref_id']??0,
      userAnswer: json['userAnswer']??"",


    );
  }
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'image_option1': imageOption1,
      'image_option2': imageOption2,
      'image_option3': imageOption3,
      'image_option4': imageOption4,
      'image_question': imageQuestion,
      'imageList': imageList,
      'correct': correctAnswer,
      'lesson': lesson,
      'score': score,
      'id': id,
      'favourite': favourite ?? false,
      'userAnswer': userAnswer,
      'medium': medium,
      'tb_name': tableName,
      'ref_id': refId,
    };
  }



}
