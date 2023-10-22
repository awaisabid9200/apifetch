// import 'package:flutter/material.dart';
// import 'api_data.dart';
// import 'api_service.dart';
//
// class TabbedScreen2 extends StatefulWidget {
//   @override
//   _TabbedScreenState createState() => _TabbedScreenState();
// }
//
// class _TabbedScreenState extends State<TabbedScreen2> {
//   List<ApiData> techCrunchDataList = [];
//   List<ApiData> teslaDataList = [];
//   List<ApiData> likedData = [];
//   bool isLoadingTechCrunch = true;
//   bool isLoadingTesla = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataForTechCrunch();
//     fetchDataForTesla();
//   }
//
//   Future<void> fetchDataForTechCrunch() async {
//     try {
//       final url =
//           'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1dfb1d0aab6f438186d77ff77788a8bb';
//       final newData = await ApiService.fetchData(url);
//       setState(() {
//         techCrunchDataList = newData;
//         isLoadingTechCrunch = false; // Set isLoadingTechCrunch to false when data is loaded
//       });
//     } catch (e) {
//       print('Error fetching TechCrunch data: $e');
//     }
//   }
//
//   Future<void> fetchDataForTesla() async {
//     try {
//       final url =
//           'https://newsapi.org/v2/everything?q=tesla&from=2023-05-04&sortBy=publishedAt&apiKey=1dfb1d0aab6f438186d77ff77788a8bb';
//       final newData = await ApiService.fetchData(url);
//       setState(() {
//         teslaDataList = newData;
//         isLoadingTesla = false; // Set isLoadingTesla to false when data is loaded
//       });
//     } catch (e) {
//       print('Error fetching Tesla data: $e');
//     }
//   }
//
//   void toggleLike(ApiData item) {
//     setState(() {
//       item.isLiked = !item.isLiked;
//       if (item.isLiked) {
//         likedData.add(item);
//       } else {
//         likedData.remove(item);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tabbed Screen'),
//       ),
//       body: DefaultTabController(
//         length: 3,
//         child: Column(
//           children: [
//             TabBar(
//               tabs: [
//                 Tab(text: 'TechCrunch'),
//                 Tab(text: 'Tesla'),
//                 Tab(text: 'Liked Items'),
//               ],
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   isLoadingTechCrunch
//                       ? Center(child: CircularProgressIndicator())
//                       : buildApiDataList(techCrunchDataList),
//                   isLoadingTesla
//                       ? Center(child: CircularProgressIndicator())
//                       : buildApiDataList(teslaDataList),
//                   buildLikedItemsList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildApiDataList(List<ApiData> dataList) {
//     return ListView.builder(
//       itemCount: dataList.length,
//       itemBuilder: (BuildContext context, int index) {
//         final item = dataList[index];
//         return ListTile(
//           leading: item.imageUrl != null
//               ? Image.network(item.imageUrl)
//               : Icon(Icons.image),
//           title: Text(item.title),
//           trailing: IconButton(
//             icon: Icon(
//               item.isLiked ? Icons.favorite : Icons.favorite_border,
//               color: item.isLiked ? Colors.red : null,
//             ),
//             onPressed: () => toggleLike(item),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget buildLikedItemsList() {
//     return ListView.builder(
//       itemCount: likedData.length,
//       itemBuilder: (BuildContext context, int index) {
//         final item = likedData[index];
//         return ListTile(
//           leading: item.imageUrl != null
//               ? Image.network(item.imageUrl)
//               : Icon(Icons.image),
//           title: Text(item.title),
//           trailing: IconButton(
//             icon: Icon(
//               Icons.favorite,
//               color: Colors.red,
//             ),
//             onPressed: () => toggleLike(item),
//           ),
//         );
//       },
//     );
//   }
// }