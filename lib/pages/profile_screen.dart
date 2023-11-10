import 'package:cine_app/common/Curve_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:cine_app/pages/Subscription_Page.dart';
import 'package:cine_app/pages/signIn_page.dart';

class AccountPage extends StatefulWidget {
  final Map<String, dynamic> userDetails;
  // final FlutterSecureStorage secureStorage;
  const AccountPage({
    Key? key,
    required this.userDetails,
  }) : super(key: key);
  @override
  State<AccountPage> createState() => _AccountPageState(userDetails);
}

class _AccountPageState extends State<AccountPage> {
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  ImageProvider _backgroundImage = AssetImage('images/image 2.jpg');
  Map<String, dynamic> userDetails = {};

  _AccountPageState(Map<String, dynamic> userDetails);
  @override
  void initState() {
    super.initState();

    // Retrieve user details from secure storage
    getUserDetails().then((retrievedUserDetails) {
      if (retrievedUserDetails != null) {
        setState(() {
          userDetails = retrievedUserDetails;
        });
      }
    });
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    // final secureStorage = secureStorage;
    final username = await secureStorage!.read(key: 'username');
    final email = await secureStorage!.read(key: 'email');

    if (username != null && email != null) {
      return {
        'Username': username,
        'Email': email,
      };
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<Options> account = [
      Options('images/wallet.png', 'Subscription'),
      Options('images/terms&condition.png', 'Terms & Conditions'),
      Options('images/support.png', 'Support'),
      Options('images/settings.png', 'Settings'),
      Options('images/logout.png', 'Logout'),
    ];

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _backgroundImage,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Profile & More",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CurveBar()));
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: ClipRRect(
                child: Container(
                  width: 392,
                  height: 140,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          ' ${userDetails['Username'] ?? "N/A"}',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(
                          ' ${userDetails['Email'] ?? "N/A"}',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: account.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      if (account[index].title == "Logout") {
                        _showLogoutConfirmationDialog(
                            context); // Show confirmation dialog
                      }
                      if (account[index].title == "Subscription") {
                        _navigate_To_Subscription_Screen(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: ListTile(
                      leading: Image.asset(account[index].imageAsset,
                          width: 24, height: 24),
                      title: Text(
                        account[index].title,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _navigateToLoginScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignIn()),
  );
}

void _navigate_To_Subscription_Screen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SubscriptionPage()),
  );
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Logout Confirmation"),
        content: Text("Are you sure you want to log out?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              "No",
              style: TextStyle(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _performLogout(context); // Log out here
            },
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

void _performLogout(BuildContext context) {
  _navigateToLoginScreen(context);
}

class Options {
  final String imageAsset;
  final String title;

  Options(this.imageAsset, this.title);

  String get optionsName => title;

  get Price => null;

  String get imagePath => imageAsset;
}
