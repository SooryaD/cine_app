import 'package:cine_app/common/movie_details_page.dart';
import 'package:cine_app/utils/query.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<Map<String, dynamic>> moviesData = [];

  void _showImageTab(int index) {
    final selectedMovie = moviesData[index];
    if (selectedMovie != null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: MovieDetailsPage(
                movieName: selectedMovie['Name'] ?? '',
                movieImage: selectedMovie['image'] ?? '',
                movieDescription: selectedMovie['description'] ?? '',
                movieVideo: selectedMovie['video'] ?? '',
              ),
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: Query(
        options: QueryOptions(
          document: gql(getMyList),
        ),
        builder: (QueryResult result,
            {Refetch? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text('Error: ${result.exception.toString()}');
          }

          if (result.isLoading) {
            return CircularProgressIndicator();
          }

          final fetchedMoviesData = result.data?['streamify_mst_movies'];

          if (fetchedMoviesData != null) {
            moviesData = List<Map<String, dynamic>>.from(fetchedMoviesData);
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: moviesData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _showImageTab(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: [
                          ClipRect(
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.black, Colors.transparent],
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.dstIn,
                              child: Image.network(
                                moviesData[index]['image'],
                                width: 150,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.network(
                              moviesData[index]['Title_Poster'],
                              width: 100,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
