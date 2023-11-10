import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/main_controller.dart';
import '../utils/query.dart';
import 'Video_player_page.dart';

class Myseries extends StatefulWidget {
  final Map seasons;
  final String seriesimage;
  final String seriesname;
  final String seriesdescription;
  final String seriesTitlePoster;

  Myseries(
      {required this.seasons,
      required this.seriesimage,
      required this.seriesname,
      required this.seriesdescription,
      required this.seriesTitlePoster,
      Key? key})
      : super(key: key);

  @override
  _MyseriesState createState() => _MyseriesState();
}

class _MyseriesState extends State<Myseries> {
  bool isLiked = false;
  final mainController = Get.put(MainController);
  String? selectedSeason;
  List<Map<String, dynamic>> episodes = [];
  List<Map<String, dynamic>> seasonList = [];

  @override
  void initState() {
    super.initState();

    if (seasonList.isNotEmpty) {
      setState(() {
        selectedSeason = seasonList[0]["season_id"];
      });
      fetchEpisodes();
    }
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Query(
          options: QueryOptions(
            document: gql(getSeasons),
            variables: {"series_id": widget.seasons["Series_ID"]},
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
              seasonList = (result.data?["mst_seasons"] as List)
                  .cast<Map<String, dynamic>>();

              return SingleChildScrollView(
                  child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.network(
                        widget.seriesimage,
                        fit: BoxFit.cover,
                        width: 400,
                      ),
                      // Positioned(
                      //   top: 10,
                      //   right: 10,
                      //   child: Row(
                      //     children: [
                      //       Image.asset(
                      //         "images/add.png",
                      //         width: 32,
                      //         height: 32,
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.network(
                          widget.seriesTitlePoster,
                          width: 140,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text('Add', style: TextStyle(color: Colors.white)),
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
                                Text('Like',
                                    style: TextStyle(color: Colors.white)),
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          // color: Colors.red,
                          child: DropdownButton<String>(
                            dropdownColor: Colors.red,
                            value: selectedSeason,
                            items: seasonList.map((season) {
                              return DropdownMenuItem<String>(
                                value: season["season_id"],
                                child: Text(
                                  "Season ${season["season_number"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSeason = value;
                                episodes.clear();
                              });

                              fetchEpisodes();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Episodes",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  if (selectedSeason != null)
                    for (var episode in episodes)
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommonVideoPlayer(
                                videoUrl: episode['link'],
                                videoTitle: episode['Title'],
                              ),
                            ),
                          );
                        },
                        title: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text(
                            episode["Title"],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Image.network(
                                episode["Episode_Poster"],
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        trailing: Icon(
                          Icons.play_circle_outline,
                          size: 30,
                          color: Colors.red,
                        ),
                      )
                  else
                    Container(),
                ],
              ));
            }
          },
        ),
      ),
    );
  }

  void fetchEpisodes() async {
    final QueryResult episodeResult =
        await GraphQLProvider.of(context).value.query(
              QueryOptions(
                document: gql(getEpisode),
                variables: {"season_id": selectedSeason},
              ),
            );

    if (episodeResult.hasException) {
      print('Error fetching episodes: ${episodeResult.exception.toString()}');
      return;
    }

    setState(() {
      episodes = (episodeResult.data?["streamify_mst_episodes"] as List)
          .cast<Map<String, dynamic>>();
    });
  }
}
