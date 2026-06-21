import 'package:get/get.dart';
import '../data/services/bookmark_service.dart';
import '../data/services/news_service.dart';
import '../data/services/theme_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NewsService(), permanent: true);
    Get.put(BookmarkService(), permanent: true);
    Get.put(ThemeService(), permanent: true);
  }
}
