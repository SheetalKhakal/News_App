import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article_model.dart';
import '../../utils/app_constants.dart';

class BookmarkService {
  Future<List<Article>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(AppConstants.prefBookmarksKey) ?? [];
    return raw
        .map((e) => Article.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future<bool> isBookmarked(String url) async {
    final bookmarks = await getBookmarks();
    return bookmarks.any((a) => a.url == url);
  }

  Future<void> addBookmark(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(AppConstants.prefBookmarksKey) ?? [];

    final alreadyExists = raw.any((e) {
      final decoded = jsonDecode(e) as Map<String, dynamic>;
      return decoded['url'] == article.url;
    });

    if (!alreadyExists) {
      raw.add(jsonEncode(article.toJson()));
      await prefs.setStringList(AppConstants.prefBookmarksKey, raw);
    }
  }

  Future<void> removeBookmark(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(AppConstants.prefBookmarksKey) ?? [];

    raw.removeWhere((e) {
      final decoded = jsonDecode(e) as Map<String, dynamic>;
      return decoded['url'] == url;
    });

    await prefs.setStringList(AppConstants.prefBookmarksKey, raw);
  }
}
