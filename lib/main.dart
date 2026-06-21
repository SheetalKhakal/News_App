import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_binding.dart';
import 'app/data/services/theme_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/utils/app_constants.dart';
import 'app/utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = ThemeService();
  final isDark = await themeService.isDarkMode();
  final fontScale = await themeService.getFontScale();

  runApp(MyApp(isDark: isDark, fontScale: fontScale));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final double fontScale;

  const MyApp({super.key, required this.isDark, required this.fontScale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: AppTheme.lightTheme(fontScale),
      darkTheme: AppTheme.darkTheme(fontScale),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: Routes.HOME,
      getPages: AppPages.pages,
    );
  }
}
