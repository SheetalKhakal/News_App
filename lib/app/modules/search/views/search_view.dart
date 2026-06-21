import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_app/app/widgets/article_card.dart';
import 'package:news_app/app/widgets/empty_widget.dart';
import 'package:news_app/app/widgets/error_widget.dart';
import 'package:news_app/app/widgets/loading_widget.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<NewsSearchController> {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: controller.onQueryChanged,
          decoration: const InputDecoration(
            hintText: "Search news...",
            border: InputBorder.none,
          ),
        ),
      ),
      body: Obx(() {
        switch (controller.state.value) {
          case SearchState.idle:
            return const EmptyWidget(
              icon: Icons.search_rounded,
              message: "Start typing to search for news articles.",
            );

          case SearchState.loading:
            return const LoadingWidget();

          case SearchState.error:
            return AppErrorWidget(
              message: controller.errorMessage.value,
              onRetry: controller.retry,
            );

          case SearchState.empty:
            return const EmptyWidget(message: "No articles match your search.");

          case SearchState.loaded:
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.articles.length,
              itemBuilder: (context, index) {
                final article = controller.articles[index];
                return ArticleCard(
                  article: article,
                  onTap: () => controller.openArticle(article),
                );
              },
            );
        }
      }),
    );
  }
}
