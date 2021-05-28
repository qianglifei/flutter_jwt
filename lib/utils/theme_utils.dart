import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvide with ChangeNotifier {
  // _allpassTheme; // 管理主题资源

  ThemeData currentTheme;

//  init() {
//    //_allpassTheme = AllpassTheme();
//    currentTheme = getTheme(Config.theme);  // Config.theme保存之前设置的主题名
//  }

//  ThemeData getTheme(String themeName) {
//    // 根据String返回对应的主题，这里简单实现
//    return _allpassTheme.blueTheme();
//  }

//  void changeTheme(String themeName) {
//    currentTheme = getTheme(themeName);
//    notifyListeners();
//  }
}