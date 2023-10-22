import 'package:apifetch/Models/article.dart';
import 'package:apifetch/Screen/Share_item.dart';
import 'package:apifetch/Screen/liked_articles.dart';
import 'package:flutter/material.dart';

class LikedArticlesScreen extends StatefulWidget {
  LikedArticlesScreen({super.key});


  @override
  State<LikedArticlesScreen> createState() => _LikedArticlesScreenState();
}

class _LikedArticlesScreenState extends State<LikedArticlesScreen> {

//delete funtion
  List<Article> likedArticles = LikedArticles.getLikedArticles();
  void removeLikedArticle(Article article) {
    setState(() {
      likedArticles.remove(article);
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Articles'),
      ),
      body: ListView.builder(
        itemCount: LikedArticles.likedArticles.length,
        itemBuilder: (context, index) {
          Article article = LikedArticles.likedArticles[index];
          return ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(article.imageUrl),
              ),
              title: Text(article.title),
              subtitle: Divider(
                color: Colors.grey.shade300,
                thickness: 2,
              ),
              trailing: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'share',
                    child: Text('Share'),
                  ),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                onSelected: (String value){
                  if(value=='share'){
                    shareArticle(article);
                  }
                  else if(value=='delete'){
                 //   LikedArticles.removeLikedArticle(article);
                    removeLikedArticle(article);
                  }
                },
              ));
        },
      ),
    );
  }

}



