import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleController> {
  const ArticleView({super.key});

  String _formatDate(DateTime? date) {
    if (date == null) return "Unknown date";
    return DateFormat('EEEE, MMM d, yyyy • h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final article = controller.article;
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            actions: [
              Obx(
                () => IconButton(
                  tooltip: "Bookmark",
                  onPressed: controller.toggleBookmark,
                  icon: Icon(
                    controller.isBookmarked.value
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: article.url,
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: theme.colorScheme.surfaceVariant),
                  errorWidget: (context, url, error) => Container(
                    color: theme.colorScheme.surfaceVariant,
                    child: const Icon(
                      Icons.image_not_supported_rounded,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      _MetaChip(
                        icon: Icons.source_rounded,
                        label: article.source.name,
                      ),
                      if (article.author != null && article.author!.isNotEmpty)
                        _MetaChip(
                          icon: Icons.person_rounded,
                          label: article.author!,
                        ),
                      _MetaChip(
                        icon: Icons.schedule_rounded,
                        label: _formatDate(article.publishedAt),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  if (article.description != null &&
                      article.description!.isNotEmpty) ...[
                    Text(
                      article.description!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    article.content ??
                        "Full content is not available. Tap below to read the complete article.",
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: controller.openOriginalUrl,
                      icon: const Icon(Icons.open_in_new_rounded),
                      label: const Text("Read Full Article"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      visualDensity: VisualDensity.compact,
    );
  }
}
