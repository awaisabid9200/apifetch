import 'package:apifetch/Models/article.dart';
import 'package:share_plus/share_plus.dart';

void shareArticle(Article article) {
  // Implement the share functionality
  // You can use packages like 'share' to share the article content
  // Example using the 'share' package:
  Share.share('${article.title}\n${article.url}');
}