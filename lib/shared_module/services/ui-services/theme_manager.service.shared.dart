import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemeManager with ChangeNotifier{

  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark){
    _themeMode = isDark?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }

}