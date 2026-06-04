import 'package:get/get.dart';
import 'package:sslcquiz/screens/history/history_screen.dart';
import 'package:sslcquiz/screens/home/home_screen.dart';
import 'package:sslcquiz/screens/lesson/lesson_screen.dart';

import '../controller/lesson/lesson_controller.dart';
import '../controller/question/question_controller.dart';
import '../controller/subject/subject_controller.dart';
import '../screens/question/question_screen.dart';
import '../screens/score/score_screen.dart';
import '../screens/setting/setting_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/subject/subject_screen.dart';

abstract class AppRoutes {
  static const home = '/home';
  static const subjectScreen = '/subject';
  static const lessonScreen = '/lesson';
  static const questionScreen = '/QuestionScreen';
  static const scoreScreen = '/ScoreScreen';
  static const historyScreen = '/historyScreen';
  static const splashScreen = '/SplashScreen';
  static const settingScreen = '/SettingScreen';
}

// Binding for SubjectScreen to ensure fresh controller every time
class SubjectBinding extends Bindings {
  @override
  void dependencies() {
    // Delete old instance if exists and create fresh one
    Get.delete<SubjectController>();
    Get.lazyPut<SubjectController>(() => SubjectController());
  }
}

// Binding for LessonScreen to ensure fresh controller every time
class LessonBinding extends Bindings {
  @override
  void dependencies() {
    // Delete old instance if exists and create fresh one
    Get.delete<LessonController>();
    Get.lazyPut<LessonController>(() => LessonController());
  }
}

// Binding for QuestionScreen to ensure fresh controller every time
class QuestionBinding extends Bindings {
  @override
  void dependencies() {
    // Delete old instance if exists and create fresh one
    Get.delete<QuestionController>();
    Get.lazyPut<QuestionController>(() => QuestionController());
  }
}

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(
      name: AppRoutes.subjectScreen, 
      page: () => SubjectScreen(),
      binding: SubjectBinding(), // Add binding to ensure fresh controller
    ),
    GetPage(
      name: AppRoutes.lessonScreen, 
      page: () => LessonScreen(),
      binding: LessonBinding(), // Add binding to ensure fresh controller
    ),
    GetPage(
      name: AppRoutes.questionScreen, 
      page: () => QuestionScreen(),
      binding: QuestionBinding(), // Add binding to ensure fresh controller
    ),
    GetPage(name: AppRoutes.scoreScreen, page: () => ScoreScreen()),
    GetPage(name: AppRoutes.historyScreen, page: () => HistoryScreen()),
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.settingScreen, page: () => SettingScreen()),
  ];
}
