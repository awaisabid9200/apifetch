import 'dart:convert';
import 'package:apifetch/Models/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '1dfb1d0aab6f438186d77ff77788a8bb';

  // Headlines

  Future<List<Article>> getTopHeadlines() async {
    final String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> articlesData = jsonData['articles'];

        List<Article> articles = articlesData
            .map((article) => Article.fromJson(article))
            .toList();

        return articles;
      } else {
        throw Exception('Failed to load top headlines');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Tesla

  Future<List<Article>> getTopTesla() async {
    final String url =
        'https://newsapi.org/v2/everything?q=tesla&from=2023-09-22&sortBy=publishedAt&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> articlesData = jsonData['articles'];

        List<Article> articles = articlesData
            .map((article) => Article.fromJson(article))
            .toList();

        return articles;
      } else {
        throw Exception('Failed to load top headlines');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Apple

  Future<List<Article>> getTopApple() async {
    final String url =
        'https://newsapi.org/v2/everything?q=apple&from=2023-10-21&to=2023-10-21&sortBy=popularity&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> articlesData = jsonData['articles'];

        List<Article> articles = articlesData
            .map((article) => Article.fromJson(article))
            .toList();

        return articles;
      } else {
        throw Exception('Failed to load top headlines');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Tech

  Future<List<Article>> getTopTech() async {
    final String url =
        'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> articlesData = jsonData['articles'];

        List<Article> articles = articlesData
            .map((article) => Article.fromJson(article))
            .toList();

        return articles;
      } else {
        throw Exception('Failed to load top headlines');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
