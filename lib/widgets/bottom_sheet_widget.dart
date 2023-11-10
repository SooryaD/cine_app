import 'dart:ui';

import 'package:cine_app/pages/Video_player_page.dart';
import 'package:flutter/material.dart';

class MovieDetailsBottomSheet extends StatelessWidget {
  final Map<String, dynamic> movieData;
  final String movieVideo;

  MovieDetailsBottomSheet({
    required this.movieData,
    required this.movieVideo,
  });

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
    return Container(
      color: Colors.transparent,
      height: 300,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        movieData['image'],
                        fit: BoxFit.cover,
                        height: 180,
                        width: 220,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            movieData['Name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            movieData['description'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _playMovieVideo(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 230, 17, 2),
                            minimumSize: Size(130, 59),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Play',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite, color: Colors.white),
                        ),
                        Text('Favorite', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.movie, color: Colors.white),
                        ),
                        Text('Trailer', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
