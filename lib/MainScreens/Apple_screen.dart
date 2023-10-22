import 'package:apifetch/MainScreens/article_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:apifetch/Models/article.dart';
import 'package:apifetch/MainScreens/liked_articles_screen.dart';
import 'package:apifetch/Services/api_sevices.dart';
import 'package:badges/badges.dart' as badges;
import '../Controllers/Share_item.dart';
import '../Controllers/SpinKit.dart';
import '../Controllers/liked_articles.dart';

class AppleScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AppleScreen> {
  final ApiService apiService = ApiService();
  Future<List<Article>>? _articlesFuture;

  @override
  void initState() {
    _articlesFuture = apiService.getTopApple();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Article>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 10, // Number of shimmer placeholders
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 350,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 18,
                          width: 250,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 18,
                          width: 200,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              height: 24,
                              width: 24,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasData) {
            List<Article> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                Article article = articles[index];
                Article save = articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticleScreen(
                                  article: articles[index],
                                )));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 350,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: articles[index].imageUrl,
                              fit: BoxFit.fill,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  Container(child: CustomSpinner()),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/blank_img.jpeg',
                                fit: BoxFit.fill,
                                height: 350,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          articles[index].title,
                          maxLines: 3,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              save.isSave
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                save.isSave = !save.isSave;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              article.isLiked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                article.isLiked = !article.isLiked;
                                if (article.isLiked) {
                                  LikedArticles.addLikedArticle(article);
                                } else {
                                  LikedArticles.removeLikedArticle(article);
                                }
                              });
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                shareArticle(article);
                              },
                              icon: Icon(
                                Icons.share,
                                color: Colors.green,
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return Center(
            child: Text('No articles found'),
          );
        },
      ),
      floatingActionButton: badges.Badge(
        badgeContent: Text(
          LikedArticles.getLikedArticles().length.toString(),
          style: TextStyle(color: Colors.white),
        ),
        badgeColor: Colors.red,
        child: FloatingActionButton(
          child: Icon(Icons.bookmark),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LikedArticlesScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
