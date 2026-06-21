import 'package:get/get.dart';
import 'package:news_app/app/data/services/bookmark_service.dart';

import '../../../data/models/article_model.dart';
import '../../../routes/app_routes.dart';

class BookmarkController extends GetxController {
  final BookmarkService _bookmarkService = Get.find<BookmarkService>();

  final bookmarks = <Article>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    isLoading.value = true;
    final result = await _bookmarkService.getBookmarks();
    bookmarks.assignAll(result.reversed);
    isLoading.value = false;
  }

  Future<void> removeBookmark(Article article) async {
    await _bookmarkService.removeBookmark(article.url);
    bookmarks.removeWhere((a) => a.url == article.url);
  }

  void openArticle(Article article) {
    Get.toNamed(
      Routes.ARTICLE,
      arguments: article,
    )?.then((_) => loadBookmarks());
  }
}
