class NewsItem {
  const NewsItem({
    required this.id,
    required this.source,
    required this.timeAgo,
    required this.title,
    required this.actionLabel,
  });

  final String id;
  final String source;
  final String timeAgo;
  final String title;
  final String actionLabel;
}
