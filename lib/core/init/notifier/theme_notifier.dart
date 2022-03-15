import 'package:bookapp/core/constants/enums/app_theme_enum.dart';
import 'package:bookapp/core/init/services/storage_service.dart';
import 'package:bookapp/core/init/theme/app_theme_light.dart';
import 'package:bookapp/locator.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData? _currentTheme = AppThemeLight.instance!.theme;
  ThemeData? get currentTheme => _currentTheme;
  final StorageService? _storageService = locator<StorageService>();

  bool _isSended = false;

  bool get getIsSended => _isSended;

  void changeValue(AppThemes theme) {
    if (theme == AppThemes.LIGHT) {
      _currentTheme = ThemeData.light();
      _storageService!.setThemeAsync('light');
    } else {
      _currentTheme = ThemeData.dark();
      _storageService!.setThemeAsync('dark');
    }
    notifyListeners();
  }

  bool isLightTheme() {
    if (_currentTheme == ThemeData.light()) {
      return true;
    } else {
      return false;
    }
  }

  void setIsSended(bool value) {
    _isSended = value;
    notifyListeners();
  }
}
