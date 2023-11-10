import 'package:cine_app/common/Curve_navigation_bar.dart';
import 'package:cine_app/common/checkBox_button.dart';
import 'package:cine_app/utils/config.dart';
import 'package:cine_app/utils/query.dart';
import 'package:cine_app/widgets/movie_GRID.dart';
import 'package:cine_app/widgets/series_GRID.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredMovies = [];
  List<dynamic> filteredSeries = [];
  bool showMovies = true;
  bool showSeries = false;

  void toggleMovies() {
    setState(() {
      showMovies = true;
      showSeries = false;
    });
  }

  void toggleSeries() {
    setState(() {
      showMovies = false;
      showSeries = true;
    });
  }

  void onSearchMovies(String query) async {
    final client = Config.getLink();
    final result = await client.value.query(
      QueryOptions(
        document: gql(searchMoviesByName),
        variables: {'name': '%$query%'},
      ),
    );

    if (!result.hasException) {
      setState(() {
        filteredMovies = result.data?['streamify_mst_movies'] ?? [];
      });
    }
  }

  void onSearchSeries(String query) async {
    final client = Config.getLink();
    final result = await client.value.query(
      QueryOptions(
        document: gql(searchSeriesByName),
        variables: {'title': '%$query%'},
      ),
    );

    if (!result.hasException) {
      setState(() {
        filteredSeries = result.data?['streamify_mst_series'] ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Search")),
        backgroundColor: const Color(0xFF0F111D),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CurveBar(),
              ),
            );
          },
        ),
      ),

      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: showMovies ? onSearchMovies : onSearchSeries,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color.fromARGB(255, 81, 0, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RectangularCheckboxButton(
                    checkedText: 'Movies',
                    uncheckedText: 'Movies',
                    onToggle: toggleMovies,
                    isChecked: showMovies,
                  ),
                  SizedBox(width: 16),
                  RectangularCheckboxButton(
                    checkedText: 'Series',
                    uncheckedText: 'Series',
                    onToggle: toggleSeries,
                    isChecked: showSeries,
                  ),
                ],
              ),
              if (showMovies) Expanded(child: MoviesGrid(filteredMovies)),
              if (showSeries) Expanded(child: SeriesGrid(filteredSeries)),
            ],
          ),
        );
      }),

      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      //   child: GNav(
      //     tabBackgroundColor: Colors.white24,
      //     padding: EdgeInsets.all(5.5),
      //     gap: 8,
      //     tabs: [
      //       GButton(
      //         icon: Icons.home_outlined,
      //         text: ("Home"),
      //         iconColor: Color.fromARGB(255, 230, 17, 2),
      //         textColor: Color.fromARGB(255, 230, 17, 2),
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => HomePage()));
      //         },
      //       ),
      //       GButton(
      //         icon: Icons.search_outlined,
      //         text: ("Search"),
      //         iconColor: Color.fromARGB(255, 230, 17, 2),
      //         textColor: Color.fromARGB(255, 230, 17, 2),
      //         // onPressed: () {
      //         //   // Navigator.push(context,
      //         //   //     MaterialPageRoute(builder: (context) => SearchPage()));
      //         // },
      //       ),
      //       GButton(
      //         icon: Icons.person,
      //         text: ("Profile"),
      //         iconColor: Color.fromARGB(255, 230, 17, 2),
      //         textColor: Color.fromARGB(255, 230, 17, 2),
      //         onPressed: () {
      //           // Navigator.push(
      //           //     context,
      //           //     MaterialPageRoute(
      //           //         builder: (context) => AccountPage(
      //           //               userDetails: {},
      //           //             )));
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
