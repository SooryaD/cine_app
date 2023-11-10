import 'package:cine_app/pages/seriespage.dart';
import 'package:flutter/material.dart';

class SeriesGrid extends StatelessWidget {
  final List<dynamic> filteredSeries;

  SeriesGrid(this.filteredSeries);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        itemCount: filteredSeries.length,
        itemBuilder: (BuildContext context, int index) {
          final series = filteredSeries[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Myseries(
                      seasons: series,
                      seriesimage: series["poster"],
                      seriesname: series["Series_Title"],
                      seriesdescription: series["descriptions"],
                      seriesTitlePoster: series["Title_Poster"]),
                ),
              );
            },
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
                        series['poster'],
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
                        series['Series_Title'],
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
        });
  }
}
