import 'package:cine_app/common/movie_details_page.dart';
import 'package:cine_app/pages/Video_player_page.dart';
import 'package:cine_app/utils/query.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MainBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(getBanner),
      ),
      builder: (
        QueryResult result, {
        Refetch? refetch,
        FetchMore? fetchMore,
      }) {
        if (result.hasException) {
          return Text('Error: ${result.exception.toString()}');
        }

        if (result.isLoading) {
          return CircularProgressIndicator();
        }

        final data = result.data?['streamify_mst_banners'];

        if (data == null || data.isEmpty) {
          return Text('No data available.');
        }

        final banner = data[0];

        return Stack(
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
                child: Image.network(banner['banner_image']),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  _navigateToMovieDetails(context, banner);
                },
                child: Image.asset(
                  "images/info.png",
                  width: 32,
                  height: 32,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              child: Column(
                children: [
                  Text(
                    banner['banner_name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                children: [
                  Text(
                    banner['banner_sub_name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: () {
                  _playMovieVideo(context, banner['banner_video']);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 230, 17, 2),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(120, 45),
                  ),
                ),
                child: Text(
                  "Watch Now",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _playMovieVideo(BuildContext context, String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommonVideoPlayer(
          videoUrl: videoUrl,
          videoTitle: "Your Video Title",
        ),
      ),
    );
  }

  void _navigateToMovieDetails(
      BuildContext context, Map<String, dynamic> bannerData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(
          movieName: bannerData['banner_name'],
          movieImage: bannerData['banner_image'],
          movieDescription: bannerData['banner_description'],
          movieVideo: bannerData['banner_video'],
        ),
      ),
    );
  }
}
