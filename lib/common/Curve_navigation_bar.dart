import 'package:cine_app/pages/HomePage.dart';
import 'package:cine_app/pages/profile_screen.dart';
import 'package:cine_app/pages/search_Page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CurveBar extends StatefulWidget {
  final String? popUpMessage;
  const CurveBar({Key? key, this.popUpMessage}) : super(key: key);

  @override
  State<CurveBar> createState() => _CurveBarState();
}

class _CurveBarState extends State<CurveBar> {
  @override
  void initState() {
    super.initState();
    if (widget.popUpMessage != null) {
      _showPopUpMessage(widget.popUpMessage!);
    }
  }

  int index = 0;

  final screens = [
    HomePage(),
    SearchPage(),
    AccountPage(
      userDetails: {},
    )
  ];
  void _showPopUpMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        Icons.search,
        size: 30,
        color: Colors.white,
      ),
      Icon(
        Icons.person,
        size: 30,
        color: Colors.white,
      )
    ];
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
          color: Colors.black,
          buttonBackgroundColor: Colors.red,
          backgroundColor: Colors.transparent,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 400),
          index: index,
          items: items,
          onTap: (index) => setState(() => this.index = index)),
    );
  }
}
