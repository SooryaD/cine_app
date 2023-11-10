import 'package:cine_app/common/movie_details_page.dart';
import 'package:flutter/material.dart';

class MoviesGrid extends StatelessWidget {
  final List<dynamic> filteredMovies;

  MoviesGrid(this.filteredMovies);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      ),
      itemCount: filteredMovies.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = filteredMovies[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsPage(
                  movieName: movie['Name'],
                  movieDescription: movie['description'],
                  movieImage: movie['image'],
                  movieVideo: movie['video'],
                ),
              ),
            );
          },
          // onTap: () {

          //     context: context,
          //     builder: (context) => MovieDetailsPage(
          //       movieName: movie['Name'],
          //       movieDescription: movie['description'],
          //       movieImage: movie['image'],
          //       movieVideo: movie['video'],
          //       // movieId: movie['id'],
          //     ),

          // },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Color(0xFF0F111D),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
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
                      movie['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Color(0xFF0F111D).withOpacity(0.1),
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      movie['Name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
