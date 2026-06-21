import 'package:get/get.dart';
import 'package:news_app/app/routes/app_routes.dart';
import 'package:news_app/app/utils/app_constants.dart';

class HomeController extends GetxController {
  final categories = AppConstants.categories;

  void openCategory(NewsCategory category) {
    Get.toNamed(Routes.CATEGORY, arguments: category);
  }

  void openSearch() {
    Get.toNamed(Routes.SEARCH);
  }

  void openBookmarks() {
    Get.toNamed(Routes.BOOKMARK);
  }

  void openSettings() {
    Get.toNamed(Routes.SETTINGS);
  }
}
