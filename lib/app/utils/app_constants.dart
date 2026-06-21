import 'package:flutter/material.dart';

class NewsCategory {
  final String title;
  final String apiValue;
  final IconData icon;

  const NewsCategory({
    required this.title,
    required this.apiValue,
    required this.icon,
  });
}

class AppConstants {
  AppConstants._();

  static const String appName = "DailyPulse News";

  static const List<NewsCategory> categories = [
    NewsCategory(
      title: "Top Headlines",
      apiValue: "general",
      icon: Icons.whatshot_rounded,
    ),
    NewsCategory(
      title: "Technology",
      apiValue: "technology",
      icon: Icons.memory_rounded,
    ),
    NewsCategory(
      title: "Sports",
      apiValue: "sports",
      icon: Icons.sports_soccer_rounded,
    ),
    NewsCategory(
      title: "Entertainment",
      apiValue: "entertainment",
      icon: Icons.movie_rounded,
    ),
    NewsCategory(
      title: "Business",
      apiValue: "business",
      icon: Icons.business_center_rounded,
    ),
    NewsCategory(
      title: "Health",
      apiValue: "health",
      icon: Icons.health_and_safety_rounded,
    ),
    NewsCategory(
      title: "Science",
      apiValue: "science",
      icon: Icons.science_rounded,
    ),
  ];

  static const String prefThemeKey = "is_dark_theme";
  static const String prefFontSizeKey = "font_size_scale";
  static const String prefBookmarksKey = "bookmarked_articles";
}
