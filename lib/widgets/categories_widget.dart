import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_app/utils/main_controller.dart';

import '../pages/Categories_List.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());

    mainController.GetGenersCategory(context);

    return Obx(() {
      return Container(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mainController.categ.length,
          itemBuilder: (context, index) {
            final categList = mainController.categ[index];
            return Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieList(category: categList)),
                  );
                },
                child: CategCard(
                  categname: categList["Category_Name"],
                  categimage: categList["Category_Image"],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class CategCard extends StatelessWidget {
  final String categname;
  final String categimage;
  final double overlayOpacity;
  const CategCard({
    required this.categname,
    required this.categimage,
    this.overlayOpacity = 0.5,
    Key? key,
  }) : super(key: key);
  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      overlayOpacity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
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
                  categimage,
                  fit: BoxFit.cover,
                  width: 140,
                  height: 70,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 7,
              right: 0,
              child: Text(
                categname,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
