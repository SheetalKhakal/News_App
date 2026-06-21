import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/data/services/theme_service.dart';

class SettingsController extends GetxController {
  final ThemeService _themeService = Get.find<ThemeService>();

  final isDarkMode = false.obs;
  final fontScale = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    isDarkMode.value = await _themeService.isDarkMode();
    fontScale.value = await _themeService.getFontScale();
  }

  Future<void> toggleTheme(bool isDark) async {
    isDarkMode.value = isDark;
    await _themeService.setDarkMode(isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> updateFontScale(double scale) async {
    fontScale.value = scale;
    await _themeService.setFontScale(scale);
  }
}
