import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_app/app/utils/app_constants.dart';
import 'package:news_app/app/widgets/category_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App logo + quick actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.newspaper_rounded,
                        color: theme.colorScheme.primary,
                        size: 30,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppConstants.appName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        tooltip: "Bookmarks",
                        onPressed: controller.openBookmarks,
                        icon: const Icon(Icons.bookmark_rounded),
                      ),
                      IconButton(
                        tooltip: "Settings",
                        onPressed: controller.openSettings,
                        icon: const Icon(Icons.settings_rounded),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search bar (navigates to the dedicated Search screen)
              GestureDetector(
                onTap: controller.openSearch,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Search news...",
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                "Categories",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: GridView.builder(
                  itemCount: controller.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return CategoryCard(
                      category: category,
                      onTap: () => controller.openCategory(category),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
