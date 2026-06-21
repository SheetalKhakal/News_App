import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/article_model.dart';
import '../../../data/services/bookmark_service.dart';

class ArticleController extends GetxController {
  final BookmarkService _bookmarkService = Get.find<BookmarkService>();

  late Article article;
  final isBookmarked = false.obs;

  @override
  void onInit() {
    super.onInit();
    article = Get.arguments as Article;
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    isBookmarked.value = await _bookmarkService.isBookmarked(article.url);
  }

  Future<void> toggleBookmark() async {
    if (isBookmarked.value) {
      await _bookmarkService.removeBookmark(article.url);
      isBookmarked.value = false;
      Get.snackbar(
        "Removed",
        "Article removed from bookmarks",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      await _bookmarkService.addBookmark(article);
      isBookmarked.value = true;
      Get.snackbar(
        "Saved",
        "Article added to bookmarks",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> openOriginalUrl() async {
    final uri = Uri.tryParse(article.url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        "Error",
        "Could not open the article link",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
