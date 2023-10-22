// import 'package:apifetch/apidata.dart';
// import 'package:flutter/material.dart';
// import 'package:share/share.dart';
//
// class SavedItemsScreen extends StatefulWidget {
//   @override
//   _SavedItemsScreenState createState() => _SavedItemsScreenState();
// }
//
// class _SavedItemsScreenState extends State<SavedItemsScreen> {
//   void _deleteItem(int index) {
//     setState(() {
//       SavedData.savedItems.removeAt(index);
//     });
//   }
//
//   void _shareItem(BuildContext context, int index) {
//     final sharedItem = SavedData.savedItems[index];
//     final title = sharedItem['title'];
//     final description = sharedItem['description'];
//
//     Share.share('$title\n\n$description');
//   }
//
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
//             title: Text(savedItem['title']),
//             subtitle: Text(savedItem['description']),
//             trailing: PopupMenuButton(
//               itemBuilder: (context) => [
//                 PopupMenuItem(
//                   value: 'delete',
//                   child: Text('Delete'),
//                 ),
//                 PopupMenuItem(
//                   value: 'share',
//                   child: Text('Share'),
//                 ),
//               ],
//               onSelected: (value) {
//                 if (value == 'delete') {
//                   _deleteItem(index);
//                 } else if (value == 'share') {
//                   _shareItem(context, index);
//                 }
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ApiData {
  final String id;
  final String title;
  bool liked;

  ApiData({required this.id, required this.title, this.liked = false});
}

class LikedData {
  List<ApiData> likedItems = [];
}

class TabbedScreen extends StatefulWidget {
  @override
  _TabbedScreenState createState() => _TabbedScreenState();
}

class _TabbedScreenState extends State<TabbedScreen> {
  List<ApiData> apiDataList1 = [];
  List<ApiData> apiDataList2 = [];
  LikedData likedData = LikedData();

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch API data on screen initialization
  }

  void fetchData() {
    // Simulating API data fetching
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        apiDataList1 = [
          ApiData(id: "1", title: "Item 1 (Tab 1)"),
          ApiData(id: "2", title: "Item 2 (Tab 1)"),
          ApiData(id: "3", title: "Item 3 (Tab 1)"),
        ];

        apiDataList2 = [
          ApiData(id: "4", title: "Item 4 (Tab 2)"),
          ApiData(id: "5", title: "Item 5 (Tab 2)"),
          ApiData(id: "6", title: "Item 6 (Tab 2)"),
        ];
      });
    });
  }

  void toggleLike(ApiData item) {
    setState(() {
      item.liked = !item.liked;
      if (item.liked) {
        likedData.likedItems.add(item);
      } else {
        likedData.likedItems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabbed Screen'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Liked Items'),
            ],
          ),
          body: TabBarView(
            children: [
              buildApiDataList(apiDataList1),
              buildApiDataList(apiDataList2),
              buildLikedItemsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildApiDataList(List<ApiData> dataList) {
    if (dataList.isEmpty) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          itemCount: 5, // Displaying 5 shimmering placeholders
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Container(
                width: double.infinity,
                height: 16,
                color: Colors.white,
              ),
              trailing: Container(
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            );
          },
        ),
      );
    }

    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        ApiData item = dataList[index];
        return ListTile(
          title: Text(item.title),
          trailing: IconButton(
            icon: Icon(item.liked ? Icons.favorite : Icons.favorite_border),
            color: item.liked ? Colors.red : null,
            onPressed: () {
              toggleLike(item);
            },
          ),
        );
      },
    );
  }

  Widget buildLikedItemsList() {
    List<ApiData> likedItems = likedData.likedItems;

    if (likedItems.isEmpty) {
      return Center(
        child: Text('No liked items.'),
      );
    }

    return ListView.builder(
      itemCount: likedItems.length,
      itemBuilder: (BuildContext context, int index) {
        ApiData item = likedItems[index];
        return ListTile(
          title: Text(item.title),
          trailing: IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () {
              toggleLike(item);
            },
          ),
        );
      },
    );
  }
}
