// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class Api extends StatefulWidget {
//   const Api({Key? key}) : super(key: key);
//
//   @override
//   State<Api> createState() => _ApiState();
// }
//
// class _ApiState extends State<Api> {
//   var stingResponse;
//   var mapResponse;
//   var listResponse;
//
//   List<bool> likedItems = [];
//   bool isLoading = true;
//
//   Future<void> apiCall() async {
//     http.Response response = await http.get(Uri.parse(
//         'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1dfb1d0aab6f438186d77ff77788a8bb'));
//     if (response.statusCode == 200) {
//       setState(() {
//         stingResponse = response.body;
//         mapResponse = json.decode(response.body);
//         listResponse = mapResponse['articles'];
//         likedItems = List.generate(listResponse.length, (index) => false);
//       });
//     }
//   }
//
//   // Loading bar
//   Future<void> loadData() async {
//     // Simulating an asynchronous operation
//     await Future.delayed(Duration(seconds: 3));
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     apiCall();
//     loadData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'StepUp',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//             Text(
//               'News',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue),
//             ),
//           ],
//         ),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: listResponse == null ? 0 : listResponse.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailScreen(
//                           newsData: listResponse[index],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       listResponse[index]['urlToImage'] != null
//                           ? Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Container(
//                                 height: 350,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: NetworkImage(
//                                           listResponse[index]['urlToImage']),
//                                       fit: BoxFit.fill),
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                               ),
//                             )
//                           : Image.asset(
//                               'assets/images/white.png',
//                               fit: BoxFit.fill,
//                               height: 350,
//                               width: double.infinity,
//                             ),
//                       SizedBox(height: 20),
//                       Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Text(
//                           listResponse[index]['title'].toString(),
//                           maxLines: 3,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           likedItems[index]
//                               ? Icons.favorite
//                               : Icons.favorite_border,
//                           color: likedItems[index] ? Colors.red : null,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             likedItems[index] = !likedItems[index];
//                             if (likedItems[index]) {
//                               SavedData.savedItems.add(listResponse[index]);
//                             } else {
//                               SavedData.savedItems.remove(listResponse[index]);
//                             }
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class SavedData {
  static List<dynamic> savedItems = [];
}

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  var stingResponse;
  var mapResponse;
  var listResponse;

  List<bool> likedItems = [];
  bool isLoading = true;

  Future<void> apiCall() async {
    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1dfb1d0aab6f438186d77ff77788a8bb'));
    if (response.statusCode == 200) {
      setState(() {
        stingResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['articles'];
        likedItems = List.generate(listResponse.length, (index) => false);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'StepUp',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              'News',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ],
        ),
      ),
      body: isLoading
          ? _buildShimmerList()
          : ListView.builder(
              itemCount: listResponse == null ? 0 : listResponse.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          newsData: listResponse[index],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      listResponse[index]['urlToImage'] != null
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 350,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          listResponse[index]['urlToImage']),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            )
                          : Image.asset(
                              'assets/images/white.png',
                              fit: BoxFit.fill,
                              height: 350,
                              width: double.infinity,
                            ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          listResponse[index]['title'].toString(),
                          maxLines: 3,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          likedItems[index]
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: likedItems[index] ? Colors.red : null,
                        ),
                        onPressed: () {
                          setState(() {
                            likedItems[index] = !likedItems[index];
                            if (likedItems[index]) {
                              SavedData.savedItems.add(listResponse[index]);
                            } else {
                              SavedData.savedItems.remove(listResponse[index]);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 18,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.grey[300],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class SavedItemsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved Items'),
//       ),
//       body: ListView.builder(
//         itemCount: SavedData.savedItems.length,
//         itemBuilder: (context, index) {
//           final savedItem = SavedData.savedItems[index];
//
//           return ListTile(
//             leading: CircleAvatar(
//               child: Image.network(savedItem['urlToImage']),
//             ),
//             title: Text(savedItem['title']),
//             subtitle: Text(savedItem['description']),
//             // Add more UI elements to display the saved data as needed
//           );
//         },
//       ),
//     );
//   }
// }

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> newsData;

  const DetailScreen({required this.newsData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              newsData['urlToImage'] != null
                  ? Container(
                      height: 450.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                NetworkImage(newsData['urlToImage'].toString()),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      // child: Image.network(newsData['urlToImage'].toString())
                    )
                  : Container(
                      child: Image.asset(
                        'assets/images/image.png',
                        height: 500,
                      ),
                    ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Auther: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    newsData['author'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        letterSpacing: 1,
                        wordSpacing: 1),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text('Title:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text(
                newsData['title'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    letterSpacing: 1,
                    wordSpacing: 1),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                newsData['description'].toString(),
                style:
                    TextStyle(fontSize: 15, letterSpacing: 1, wordSpacing: 1),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                newsData['publishedAt'].toString(),
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(newsData['url'].toString(),
                  style: TextStyle(decoration: TextDecoration.underline)),
            ],
          ),
        ),
      ),
    );
  }
}
