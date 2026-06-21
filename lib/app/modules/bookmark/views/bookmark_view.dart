import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_app/app/widgets/empty_widget.dart';

import '../../../widgets/article_card.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarked Articles")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bookmarks.isEmpty) {
          return const EmptyWidget(
            icon: Icons.bookmark_border_rounded,
            message: "You haven't bookmarked any articles yet.",
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.bookmarks.length,
          itemBuilder: (context, index) {
            final article = controller.bookmarks[index];
            return Dismissible(
              key: Key(article.url),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => controller.removeBookmark(article),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.delete_rounded, color: Colors.white),
              ),
              child: ArticleCard(
                article: article,
                onTap: () => controller.openArticle(article),
              ),
            );
          },
        );
      }),
    );
  }
}
