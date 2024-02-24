import 'package:flutter/material.dart';
import 'package:todo_app_new/features/settings/pages/settings_view.dart';
import 'package:todo_app_new/features/tasks/pages/tasks_view.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = "en";
  void changeLanguage(String langCode) {
    languageCode = langCode;
    notifyListeners();
  }
  int currentIndex =0;
  List<Widget> tabs = [
    const TasksView(),
    const SettingsView(),
  ];

  void changeThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  String changeSplashScreen() {
    if (themeMode == ThemeMode.light) {
      return "assets/images/splash_bg.png";
    } else {
      return "assets/images/dark_theme/splash_dark_bg.png";
    }
  }
   void changeCurrentIndex (int index){
    currentIndex =index ;
    notifyListeners();
   }
}