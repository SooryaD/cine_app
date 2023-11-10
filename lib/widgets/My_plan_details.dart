import 'package:flutter/material.dart';

class SubscriptionDetailsPage extends StatelessWidget {
  final String planName;
  final int planPrice;
  final int planScreen;
  final String planQuality;

  SubscriptionDetailsPage({
    required this.planName,
    required this.planPrice,
    required this.planScreen,
    required this.planQuality,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 00,
        title: Center(child: Text('Subscription Details')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Plan Name: $planName',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Price: \$${planPrice.toString()}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Number of Screens: ${planScreen.toString()}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Video Quality: $planQuality',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
