import 'package:cine_app/widgets/main_bannner_widget.dart';
import 'package:flutter/material.dart';
import 'package:cine_app/widgets/banner_widget.dart';
import 'package:cine_app/widgets/categories_widget.dart';
import 'package:cine_app/widgets/movie_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainBannerWidget(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 18, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Genres",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CategoriesWidget(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Series",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: BannerWidget(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My List",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: MyList(),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Favorites",
              //         style: TextStyle(fontSize: 24, color: Colors.white),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: FavoritesWidgets(),
              // ),
            ],
          );
        },
      ),
    );
  }
}
