import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/main_controller.dart';
import '../utils/query.dart';
import 'movieList_btm_sheet.dart';

class MovieList extends StatelessWidget {
  final Map category;

  MovieList({required this.category, Key? key}) : super(key: key);
  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F111D),
        elevation: 0,
        title: Text(category["Category_Name"]),
      ),
      body: Query(
        options: QueryOptions(
          cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
          document: gql(get_mst_movies),
          variables: {'mst_categories': category['Category_ID']},
        ),
        builder: (
          QueryResult result, {
          VoidCallback? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (result.hasException) {
            return Center(child: Text('Error fetching data'));
          } else {
            // print(result.data);

            List<Map<String, dynamic>> movies =
                (result.data?['streamify_mst_movies'] as List)
                    .cast<Map<String, dynamic>>();
            // print(movies);
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieItem(
                    movieId: movies[index]["id"],
                    movieName: movies[index]['Name'],
                    movieDescription: movies[index]['description'],
                    movieImage: movies[index]['image'],
                    movieVideo: movies[index]['video'],
                    movieTitlePosters: movies[index]['Title_Poster']

                    // imageUrl: '',
                    );
              },
            );
          }
        },
      ),
    );
  }
}
