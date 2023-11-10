import 'package:cine_app/utils/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/seriespage.dart';

class BannerWidget extends StatelessWidget {
  BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());

    mainController.GetSeries(context);

    return Obx(() {
      return Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mainController.series.length,
          itemBuilder: (context, index) {
            final seriesList = mainController.series[index];

            return Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child: Myseries(
                            seasons: seriesList,
                            seriesimage: seriesList["poster"],
                            seriesname: seriesList["Series_Title"],
                            seriesdescription: seriesList["descriptions"],
                            seriesTitlePoster: seriesList["Title_Poster"],
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
                child: SeriesCard(
                  seriesname: seriesList["Series_Title"],
                  seriesimage: seriesList["poster"],
                  seriesdescription: seriesList["descriptions"],
                  seriesTitlePoster: seriesList["Title_Poster"],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class SeriesCard extends StatelessWidget {
  final String seriesname;
  final String seriesimage;
  final String seriesdescription;
  final String seriesTitlePoster;

  const SeriesCard({
    required this.seriesname,
    required this.seriesimage,
    required this.seriesdescription,
    required this.seriesTitlePoster,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
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
                  seriesimage,
                  width: 120,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 3,
              right: 0,
              child: Text(
                seriesname,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
