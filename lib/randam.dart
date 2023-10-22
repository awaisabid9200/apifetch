import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share_plus/share_plus.dart';

var stingResponce;
var mapResponce;
var dataResponce, dataSupport;
var listResponce;
List<dynamic> favorites = []; //save
// share
void shareContent(String imageUrl, String title, String url) {
  Share.share(
    '$title\n\n$url',
    subject: title,
    sharePositionOrigin: Rect.fromLTWH(0, 0, 100, 100),
  );
}

class Apirandam extends StatefulWidget {
  const Apirandam({Key? key}) : super(key: key);

  @override
  State<Apirandam> createState() => _ApiState();
}

class _ApiState extends State<Apirandam> {
  bool isLoading = true;

  Future apiCall() async {
    http.Response Responce;
    Responce = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=1dfb1d0aab6f438186d77ff77788a8bb'));
    if (Responce.statusCode == 200) {
      setState(() {
        stingResponce = Responce.body;
      });
      mapResponce = json.decode(Responce.body);
      listResponce = mapResponce['articles'].map((article) {
        article['liked'] = false; //save
        return article;
      }).toList();
    }
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
      favorites.clear();
    });
    await apiCall();
    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    apiCall();
    loadData();
  }

//save
  bool isInFavorites(dynamic item) {
    return favorites.contains(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoritesScreen(favorites: favorites), //
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellow.shade100,
                    ),
                    child: Column(
                      children: [
                        listResponce != null
                            ? Image.network(
                                listResponce[index]['urlToImage'].toString(),
                                fit: BoxFit.fill,
                                height: 200,
                              )
                            : Text('error'),
                        SizedBox(height: 10),
                        Text(
                          listResponce[index]['title'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                shareContent(
                                  listResponce[index]['urlToImage'].toString(),
                                  listResponce[index]['title'].toString(),
                                  listResponce[index]['url'].toString(),
                                );
                              },
                            ),
                            //save
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    listResponce[index]['liked'] =
                                        !listResponce[index]['liked'];
                                    if (listResponce[index]['liked']) {
                                      favorites.add(listResponce[index]);
                                    } else {
                                      favorites.remove(listResponce[index]);
                                    }
                                  });
                                },
                                icon: Icon(
                                  listResponce[index]['liked']
                                      ? Icons.save_rounded
                                      : Icons.save_outlined,
                                  color: listResponce[index]['liked']
                                      ? Colors.blue
                                      : null,
                                ))
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: listResponce == null ? 0 : listResponce.length,
              ),
      ),
    );
  }
}

//save
class FavoritesScreen extends StatefulWidget {
  final List<dynamic> favorites;

  const FavoritesScreen({required this.favorites});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  GlobalKey _popupMenuKey = GlobalKey();

  void removeFavorite(dynamic item) {
    setState(() {
      final index = widget.favorites.indexOf(item);
      if (index != -1) {
        widget.favorites.removeAt(index);
        Navigator.pop(context);
      }
    });
    dismissPopupMenu();
  }

  void dismissPopupMenu() {
    final dynamic popupMenuState = _popupMenuKey.currentState;
    popupMenuState?.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final favoriteItem = widget.favorites[index];

          return Column(
            children: [
              ListTile(
                leading: ClipOval(
                  child: Image.network(
                    favoriteItem['urlToImage'].toString(),
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                ),
                title: Text(favoriteItem['title'].toString()),
                trailing: PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        key: _popupMenuKey,
                        child: ListTile(
                          leading: Icon(Icons.share),
                          title: Text('Share'),
                          onTap: () {
                            shareContent(
                              favoriteItem['urlToImage'].toString(),
                              favoriteItem['title'].toString(),
                              favoriteItem['url'].toString(),
                            );
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete'),
                          onTap: () {
                            removeFavorite(favoriteItem);
                          },
                        ),
                      ),
                    ];
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ),
              Divider(height: 0),
            ],
          );
        },
        itemCount: widget.favorites.length,
      ),
    );
  }
}
