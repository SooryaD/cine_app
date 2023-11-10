import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cine_app/widgets/My_plan_details.dart';

class Payment_Gateway extends StatefulWidget {
  final String planname;
  final int planprice;
  final int planscreen;
  final String planquality;

  const Payment_Gateway({
    Key? key,
    required this.planname,
    required this.planprice,
    required this.planscreen,
    required this.planquality,
  }) : super(key: key);

  @override
  State<Payment_Gateway> createState() => _Payment_GatewayState();
}

class _Payment_GatewayState extends State<Payment_Gateway> {
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F111D),
        elevation: 0,
        title: Center(
          child: Text(
            "Payment Gateway",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Plan Name: ${widget.planname}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text('Price: \$${widget.planprice}',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            Text('Number of Screens: ${widget.planscreen}',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            Text('Video Quality: ${widget.planquality}',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                var options = {
                  'key': 'rzp_test_6V0rDCWlEYINPW',
                  'amount': widget.planprice * 100,
                  'name': 'CineApp',
                  'description': 'Subscription - ${widget.planname}',
                  'prefill': {
                    'contact': '7708721878',
                    'email': 'soorya@gmail.com'
                  }
                };
                _razorpay.open(options);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                "Proceed to Payment",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.paymentId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubscriptionDetailsPage(
          planName: widget.planname,
          planPrice: widget.planprice,
          planScreen: widget.planscreen,
          planQuality: widget.planquality,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Payment Success",
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Payment failed",
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Payment Success",
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }
}
