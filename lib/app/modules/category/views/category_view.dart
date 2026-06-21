import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_app/app/widgets/article_card.dart';
import 'package:news_app/app/widgets/empty_widget.dart';
import 'package:news_app/app/widgets/error_widget.dart';
import 'package:news_app/app/widgets/loading_widget.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(controller.category.title)),
      body: Obx(() {
        switch (controller.state.value) {
          case ViewState.loading:
            return const LoadingWidget();

          case ViewState.error:
            return AppErrorWidget(
              message: controller.errorMessage.value,
              onRetry: controller.fetchArticles,
            );

          case ViewState.empty:
            return RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: const EmptyWidget(
                message: "No articles found for this category.",
              ),
            );

          case ViewState.loaded:
            return RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.articles.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.articles.length) {
                    return Obx(
                      () => controller.isLoadingMore.value
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox.shrink(),
                    );
                  }

                  final article = controller.articles[index];
                  return ArticleCard(
                    article: article,
                    onTap: () => controller.openArticle(article),
                  );
                },
              ),
            );
        }
      }),
    );
  }
}
