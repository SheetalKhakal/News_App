import 'package:get/get.dart';
import 'package:news_app/app/data/services/news_service.dart';
import 'package:news_app/app/utils/app_constants.dart';

import '../../../data/models/article_model.dart';
import '../../../routes/app_routes.dart';

/// Represents the four possible UI states for the Category screen.
enum ViewState { loading, loaded, error, empty }

class CategoryController extends GetxController {
  final NewsService _newsService = Get.find<NewsService>();

  late NewsCategory category;

  final articles = <Article>[].obs;
  final state = ViewState.loading.obs;
  final errorMessage = ''.obs;
  final isLoadingMore = false.obs;

  int _page = 1;
  bool _hasMore = true;

  @override
  void onInit() {
    super.onInit();
    category = Get.arguments as NewsCategory;
    fetchArticles();
  }

  Future<void> fetchArticles({bool isRefresh = false}) async {
    _page = 1;
    _hasMore = true;

    if (!isRefresh) {
      state.value = ViewState.loading;
    }

    try {
      final response = await _newsService.fetchTopHeadlines(
        category: category.apiValue,
        page: _page,
      );

      if (response.articles.isEmpty) {
        articles.clear();
        state.value = ViewState.empty;
      } else {
        articles.assignAll(response.articles);
        _hasMore = response.articles.length >= 20;
        state.value = ViewState.loaded;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      state.value = ViewState.error;
    }
  }

  /// Called when the user scrolls near the bottom of the list.
  Future<void> loadMore() async {
    if (isLoadingMore.value || !_hasMore || state.value != ViewState.loaded) {
      return;
    }

    isLoadingMore.value = true;
    final nextPage = _page + 1;

    try {
      final response = await _newsService.fetchTopHeadlines(
        category: category.apiValue,
        page: nextPage,
      );

      if (response.articles.isEmpty) {
        _hasMore = false;
      } else {
        articles.addAll(response.articles);
        _page = nextPage;
        _hasMore = response.articles.length >= 20;
      }
    } catch (_) {
      // Silently ignore "load more" failures; the user can keep scrolling
      // or pull-to-refresh, the existing list stays intact either way.
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> onRefresh() => fetchArticles(isRefresh: true);

  void openArticle(Article article) {
    Get.toNamed(Routes.ARTICLE, arguments: article);
  }
}
