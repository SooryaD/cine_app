import 'package:flutter/material.dart';

import '../common/movie_details_page.dart';
import 'Video_player_page.dart';

class MovieItem extends StatelessWidget {
  final String movieName;
  final String movieImage;
  final String movieId;
  final String movieDescription;
  final String movieVideo;
  final String movieTitlePosters;

  const MovieItem({
    required this.movieName,
    required this.movieId,
    required this.movieDescription,
    required this.movieImage,
    required this.movieVideo,
    required this.movieTitlePosters,
    Key? key,
  }) : super(key: key);

  void _playMovieVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommonVideoPlayer(
          videoUrl: movieVideo,
          videoTitle: 'Movie Title',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: MovieDetailsPage(
                  movieName: movieName,
                  movieImage: movieImage,
                  movieDescription: movieDescription,
                  movieVideo: movieVideo,
                ),
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                movieImage,
                fit: BoxFit.cover,
                height: 140,
                width: 200,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    movieDescription,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
