import 'package:apifetch/Models/article.dart';
import 'package:flutter/material.dart';

class LikedArticles {
  static List<Article> likedArticles = [];

  static void addLikedArticle(Article article) {
    likedArticles.add(article);
  }

  static void removeLikedArticle(Article article) {
    likedArticles.remove(article);
  }

  static bool isArticleLiked(Article article) {
    return likedArticles.contains(article);
  }

  static List<Article> getLikedArticles() {
    return likedArticles;
  }
}

