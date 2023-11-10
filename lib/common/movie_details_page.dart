import 'package:flutter/material.dart';
import 'package:cine_app/pages/Video_player_page.dart';

class MovieDetailsPage extends StatefulWidget {
  final String movieName;
  final String movieImage;
  final String movieDescription;
  final String movieVideo;

  MovieDetailsPage({
    required this.movieName,
    required this.movieImage,
    required this.movieDescription,
    required this.movieVideo,
  });

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool isLiked = false;

  void _playMovieVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommonVideoPlayer(
          videoUrl: widget.movieVideo,
          videoTitle: widget.movieName,
        ),
      ),
    );
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("movieName...................${movieName}");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    widget.movieImage,
                    fit: BoxFit.cover,
                    width: 400,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            "images/leftArrow.png",
                            width: 32,
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.favorite, color: Colors.white),
                      Text('Favorite', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Column(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: isLiked ? Colors.red : Colors.white,
                            ),
                            Text('Like', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.share, color: Colors.white),
                      Text('Share', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.movieName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.movieDescription,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "More like this.....",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ],
              // ),
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
        ),
      ),
    );
  }
}
