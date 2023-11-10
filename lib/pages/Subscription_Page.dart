import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/main_controller.dart';
import 'Payment_screen.dart';

class SubscriptionPage extends StatelessWidget {
  SubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());

    mainController.GetPlans(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 00,
        title: Text('Subscription Plans'),
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: mainController.plan.length,
          itemBuilder: (context, index) {
            final planList = mainController.plan[index];

            return Padding(
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {},
                child: planCard(
                  planname: planList["Plan_Name"],
                  planprice: planList["Price"],
                  planscreen: planList["Number_of_Screens"],
                  planquality: planList["Video_Quality"],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class planCard extends StatelessWidget {
  final String planname;
  final int planprice;
  final int planscreen;
  final String planquality;

  const planCard({
    required this.planname,
    required this.planprice,
    required this.planscreen,
    required this.planquality,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Color.fromARGB(255, 230, 17, 2)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Payment_Gateway(
                      planname: planname,
                      planprice: planprice,
                      planscreen: planscreen,
                      planquality: planquality,
                    )),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$planname   /  1 month",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Amount: $planprice',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'VideoQuality: $planquality',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Screen: $planscreen',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Payment_Gateway(
                            planname: planname,
                            planprice: planprice,
                            planscreen: planscreen,
                            planquality: planquality,
                          )),
                );
              },
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 230, 17, 2),
                shape: CircleBorder(),
                padding: EdgeInsets.all(12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
