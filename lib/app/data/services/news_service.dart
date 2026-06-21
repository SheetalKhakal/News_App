import '../models/article_model.dart';
import '../providers/api_provider.dart';

class NewsService {
  final ApiProvider _provider = ApiProvider();

  Future<NewsResponse> fetchTopHeadlines({
    required String category,
    int page = 1,
  }) async {
    final json = await _provider.getTopHeadlines(
      category: category,
      page: page,
    );
    return NewsResponse.fromJson(json);
  }

  Future<NewsResponse> searchArticles({
    required String query,
    int page = 1,
  }) async {
    final json = await _provider.searchNews(query: query, page: page);
    return NewsResponse.fromJson(json);
  }
}
