import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sslcquiz/data/data_constant.dart';
import 'package:sslcquiz/model/subject_model.dart';
import 'package:sslcquiz/screens/subject/subject_screen.dart';
import 'package:sslcquiz/utils/text_data.dart';

import '../../data/app_data.dart';

class SubjectController extends GetxController {
  final List<SubjectModel> subjectList = [
    SubjectModel(title:TextData.tamil, tamilTitle:TextData.tamil, button: "btn_tamil.png", englishTable: DataConstant.tamil, tamilTable: DataConstant.tamil),
    SubjectModel(title:TextData.english, tamilTitle:TextData.tEnglish,button: "btn_english.png", englishTable: DataConstant.english, tamilTable: DataConstant.english),
    SubjectModel(title:TextData.maths, tamilTitle:TextData.tMaths,button: "btn_maths.png", englishTable: DataConstant.englishMaths, tamilTable: DataConstant.tamilMaths),
    SubjectModel(title:TextData.science,tamilTitle:TextData.tScience, button: "btn_science.png", englishTable: DataConstant.englishScience, tamilTable: DataConstant.tamilScience),
    SubjectModel(title:TextData.social,tamilTitle:TextData.tSocial, button: "btn_social.png", englishTable: DataConstant.englishSocial, tamilTable: DataConstant.tamilSocial),
    SubjectModel(title:TextData.favourite, tamilTitle:TextData.tFavourite,button: "btn_favourite.png", englishTable: "", tamilTable: ""),
  ];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getData();
  }


  RxBool isTamil = false.obs;

  getData() async {
    isTamil.value = await AppData().isTamil();

    print("tamilTable==${isTamil.value}");

    update();
  }



}
