import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';

class ThemeService {
  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.prefThemeKey) ?? false;
  }

  Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefThemeKey, isDark);
  }

  Future<double> getFontScale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(AppConstants.prefFontSizeKey) ?? 1.0;
  }

  Future<void> setFontScale(double scale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(AppConstants.prefFontSizeKey, scale);
  }
}
