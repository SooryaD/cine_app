// // import 'package:cine_app/utils/query.dart';
// // import 'package:flutter/material.dart';
// // import 'package:graphql_flutter/graphql_flutter.dart';

// // class FavoritesWidgets extends StatefulWidget {
// //   const FavoritesWidgets({Key? key}) : super(key: key);

// //   @override
// //   State<FavoritesWidgets> createState() => _FavoritesWidgetsState();
// // }

// // class _FavoritesWidgetsState extends State<FavoritesWidgets> {
// //   List<Map<String, dynamic>> favoritesData = [];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 200,
// //       child: Query(
// //         options: QueryOptions(
// //           document: gql(getFavorites),
// //         ),
// //         builder: (QueryResult result,
// //             {Refetch? refetch, FetchMore? fetchMore}) {
// //           if (result.hasException) {
// //             return Text('Error: ${result.exception.toString()}');
// //           }

// //           if (result.isLoading) {
// //             return CircularProgressIndicator();
// //           }

// //           final fetchfavoritesData = result.data?["streamify_mst_favorites"];

// //           if (fetchfavoritesData != null) {
// //             favoritesData = List<Map<String, dynamic>>.from(fetchfavoritesData);
// //           }

// //           return ListView.builder(
// //             scrollDirection: Axis.horizontal,
// //             itemCount: favoritesData.length,
// //             itemBuilder: (BuildContext context, int index) {
// //               if (favoritesData[index] == null) {

// //                 return Container();
// //               }
// //               return Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: GestureDetector(
// //                   onTap: () {
// //                     // _showImageTab(index);
// //                   },
// //                   child: Container(
// //                     padding: EdgeInsets.all(2),
// //                     child: ClipRRect(
// //                       borderRadius: BorderRadius.circular(8),
// //                       child: Stack(
// //                         children: [
// //                           ClipRect(
// //                             child: ShaderMask(
// //                               shaderCallback: (Rect bounds) {
// //                                 return LinearGradient(
// //                                   begin: Alignment.topCenter,
// //                                   end: Alignment.bottomCenter,
// //                                   colors: [Colors.black, Colors.transparent],
// //                                 ).createShader(bounds);
// //                               },
// //                               blendMode: BlendMode.dstIn,
// //                               child: Image.network(
// //                                 favoritesData[index]['image'],
// //                                 width: 150,
// //                                 height: 250,
// //                                 fit: BoxFit.cover,
// //                               ),
// //                             ),
// //                           ),
// //                           Align(
// //                             alignment: Alignment.bottomCenter,
// //                             child: Image.network(
// //                               favoritesData[index]['Title_Poster'],
// //                               width: 100,
// //                               height: 30,
// //                               fit: BoxFit.cover,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../utils/main_controller.dart';

// class FavoritesWidgets extends StatelessWidget {
//   const FavoritesWidgets({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     MainController mainController = Get.put(MainController());

//     return FutureBuilder<void>(
//       future: mainController.GetFavorites(context),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error.toString()}');
//         } else {
//           return Obx(() {
//             return Container(
//               height: 200,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: mainController.favorites.length,
//                 itemBuilder: (context, index) {
//                   final favoritesList = mainController.favorites[index];

//                   return Padding(
//                     padding: EdgeInsets.only(right: 14.0),
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: FavoritesCard(
//                         favoritesName: favoritesList["Name"],
//                         favoritesImage: favoritesList["image"],
//                         favoritesDescription: favoritesList["description"],
//                         favoritesTitlePoster: favoritesList["Title_Poster"],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           });
//         }
//       },
//     );
//   }
// }

// class FavoritesCard extends StatelessWidget {
//   final String favoritesName;
//   final String favoritesImage;
//   final String favoritesDescription;
//   final String favoritesTitlePoster;
//   const FavoritesCard({
//     required this.favoritesName,
//     required this.favoritesImage,
//     required this.favoritesDescription,
//     required this.favoritesTitlePoster,
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     print(FavoritesCard);
//     return Container(
//       padding: EdgeInsets.all(4),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Stack(
//           children: [
//             ClipRect(
//               child: ShaderMask(
//                 shaderCallback: (Rect bounds) {
//                   return LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Colors.black, Colors.transparent],
//                   ).createShader(bounds);
//                 },
//                 blendMode: BlendMode.dstIn,
//                 child: Image.network(
//                   favoritesImage,
//                   width: 120,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 3,
//               right: 0,
//               child: Text(
//                 favoritesName,
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Poppins",
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
