import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sslcquiz/model/question_data.dart';

class AppData {
  String shuffle = "shuffle";
  String sound = "sound";
  String medium = "medium";
  String tableName = "tableName";
  String lesson = "lesson";
  String quizList = "quizList";
  String title = "title";
  String name = "name";
  String firstTime = "firstTime";
  String dbVersion = "dbVersion";
  String appInstallTime = "appInstallTime";

  Future<bool> getIsFirstTime() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(firstTime) ?? true;
  }

  Future<void> setIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(firstTime, false);
  }

  Future<void> setStudentName(String tName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, tName);
  }

  Future<String> getStudentName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(name) ?? "";
  }

  Future<void> setTitle(String tName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(title, tName);
  }

  Future<String> getTitle() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(title) ?? "";
  }

  Future<bool> isTamil() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(medium) ?? false;
  }

  Future<void> setMedium(bool fromTamil) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(medium, fromTamil);
  }

  Future<void> setTableName(String tName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tableName, tName);
  }

  Future<String> getTableName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(tableName) ?? "";
  }

  Future<void> setLesson(String tName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(lesson, tName);
  }

  Future<String> getLesson() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(lesson) ?? "";
  }


  Future<void> saveQuizList(List<QuestionData> list) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert each QuestionData to a Map, then encode list to JSON
    final List<Map<String, dynamic>> jsonList = list.map((q) => q.toJson()).toList();

    final String encodedData = jsonEncode(jsonList);

    await prefs.setString(quizList, encodedData);
  }


  Future<List<QuestionData>> getQuizList() async {
    final prefs = await SharedPreferences.getInstance();

    final String? data = prefs.getString(quizList);

    if (data != null) {
      final List<dynamic> decodedList = jsonDecode(data);
      List<QuestionData> quizList = decodedList
          .map((item) => QuestionData.fromJson(item as Map<String, dynamic>))
          .toList();

      return quizList;
    }

    return [];

  }


  Future<bool> getShuffle() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(shuffle) ?? true;
  }


  Future<void> setShuffle(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(shuffle, value);
  }




  Future<bool> getSound() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(sound) ?? true;
  }


  Future<void> setSound(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(sound, value);
  }

  // Database version management
  Future<int> getDbVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(dbVersion) ?? 0;
  }

  Future<void> setDbVersion(int version) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(dbVersion, version);
  }

  // Track app installation time to detect fresh installs
  Future<String> getAppInstallTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(appInstallTime) ?? "";
  }

  Future<void> setAppInstallTime(String timestamp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(appInstallTime, timestamp);
  }

  Future<bool> isFreshInstall() async {
    final prefs = await SharedPreferences.getInstance();
    String installTime = prefs.getString(appInstallTime) ?? "";
    
    if (installTime.isEmpty) {
      // First time app is launched after installation
      String now = DateTime.now().toIso8601String();
      await setAppInstallTime(now);
      return true;
    }
    
    return false;
  }

  // Clear all app data (for testing or reset)
  Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

}
