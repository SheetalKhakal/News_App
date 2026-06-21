import 'dart:async';

import 'package:get/get.dart';
import 'package:news_app/app/data/models/article_model.dart';
import 'package:news_app/app/data/services/news_service.dart' show NewsService;
import 'package:news_app/app/routes/app_routes.dart';

/// Represents the possible UI states for the Search screen.
enum SearchState { idle, loading, loaded, error, empty }

class NewsSearchController extends GetxController {
  final NewsService _newsService = Get.find<NewsService>();

  final searchQuery = ''.obs;
  final articles = <Article>[].obs;
  final state = SearchState.idle.obs;
  final errorMessage = ''.obs;

  Timer? _debounce;

  void onQueryChanged(String value) {
    searchQuery.value = value;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final trimmed = value.trim();
      if (trimmed.isEmpty) {
        articles.clear();
        state.value = SearchState.idle;
      } else {
        _search(trimmed);
      }
    });
  }

  Future<void> _search(String query) async {
    state.value = SearchState.loading;

    try {
      final response = await _newsService.searchArticles(query: query, page: 1);

      if (response.articles.isEmpty) {
        articles.clear();
        state.value = SearchState.empty;
      } else {
        articles.assignAll(response.articles);
        state.value = SearchState.loaded;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      state.value = SearchState.error;
    }
  }

  void retry() {
    final trimmed = searchQuery.value.trim();
    if (trimmed.isNotEmpty) {
      _search(trimmed);
    }
  }

  void openArticle(Article article) {
    Get.toNamed(Routes.ARTICLE, arguments: article);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
