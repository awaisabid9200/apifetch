//
// import 'package:apifetch/floatbuttonsave.dart';
// import 'package:share/share.dart';
// import 'package:apifetch/apidata.dart';
// import 'package:apifetch/apisplash.dart';
// import 'package:apifetch/randam.dart';
// import 'package:flutter/material.dart';
//
// class WhatsAPP extends StatelessWidget {
//   const WhatsAPP({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.teal,
//           title: Text('WhatsApp',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: Icon(Icons.search),
//             ),
//             PopupMenuButton(
//               enabled: true,
//                 icon: Icon(Icons.more_vert_outlined),
//                 itemBuilder: (context)=>[
//               PopupMenuItem(child: Text('Logout')),
//             ]),
//
//           ],
//           bottom: TabBar(
//              indicatorColor: Colors.white ,
//             tabs: [
//               Tab(
//                 child: Icon(Icons.camera_alt),
//               ),
//               Tab(
//                 child: Text('Chats',style: TextStyle(fontWeight: FontWeight.bold),),
//               ),
//               Tab(
//                 child: Text('Status',style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//               Tab(
//                 child: Text('Calls',style: TextStyle(fontWeight: FontWeight.bold))
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Api(),
//             Apirandam(),
//             SplashScreen(),
//           ],
//         ),
//         // floatingActionButton: FloatingActionButton.extended(
//         //   onPressed: () {
//         //     Navigator.push(
//         //       context,
//         //       MaterialPageRoute(
//         //         builder: (context) => SavedItemsScreen(),
//         //       ),
//         //     );
//         //   },
//         //   label: Text('View Saved Items'),
//         //   icon: Icon(Icons.bookmark),
//         // ),
//       ),
//     );
//   }
// }
//
//
// // class SavedItemsScreen extends StatefulWidget {
// //   @override
// //   _SavedItemsScreenState createState() => _SavedItemsScreenState();
// // }
// //
// // class _SavedItemsScreenState extends State<SavedItemsScreen> {
// //   void _deleteItem(int index) {
// //     setState(() {
// //       SavedData.savedItems.removeAt(index);
// //     });
// //   }
// //
// //   void _shareItem(BuildContext context, int index) {
// //     final sharedItem = SavedData.savedItems[index];
// //     // Implement the sharing functionality here
// //     // e.g., share the item's title and description using the Share package
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Saved Items'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: SavedData.savedItems.length,
// //         itemBuilder: (context, index) {
// //           final savedItem = SavedData.savedItems[index];
// //
// //           return ListTile(
// //             title: Text(savedItem['title']),
// //             subtitle: Text(savedItem['description']),
// //             trailing: PopupMenuButton(
// //               itemBuilder: (context) => [
// //                 PopupMenuItem(
// //                   value: 'delete',
// //                   child: Text('Delete'),
// //                 ),
// //                 PopupMenuItem(
// //                   value: 'share',
// //                   child: Text('Share'),
// //                 ),
// //               ],
// //               onSelected: (value) {
// //                 if (value == 'delete') {
// //                   _deleteItem(index);
// //                 } else if (value == 'share') {
// //                   _shareItem(context, index);
// //                 }
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
// // class SavedItemsScreen extends StatefulWidget {
// //   @override
// //   _SavedItemsScreenState createState() => _SavedItemsScreenState();
// // }
// //
// // class _SavedItemsScreenState extends State<SavedItemsScreen> {
// //   void _deleteItem(int index) {
// //     setState(() {
// //       SavedData.savedItems.removeAt(index);
// //     });
// //   }
// //
// //   void _shareItem(BuildContext context, int index) {
// //     final sharedItem = SavedData.savedItems[index];
// //     final title = sharedItem['title'];
// //     final description = sharedItem['description'];
// //
// //     Share.share('$title\n\n$description');
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Saved Items'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: SavedData.savedItems.length,
// //         itemBuilder: (context, index) {
// //           final savedItem = SavedData.savedItems[index];
// //
// //           return ListTile(
// //             title: Text(savedItem['title']),
// //             subtitle: Text(savedItem['description']),
// //             trailing: PopupMenuButton(
// //               itemBuilder: (context) => [
// //                 PopupMenuItem(
// //                   value: 'delete',
// //                   child: Text('Delete'),
// //                 ),
// //                 PopupMenuItem(
// //                   value: 'share',
// //                   child: Text('Share'),
// //                 ),
// //               ],
// //               onSelected: (value) {
// //                 if (value == 'delete') {
// //                   _deleteItem(index);
// //                 } else if (value == 'share') {
// //                   _shareItem(context, index);
// //                 }
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
