import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:cine_app/pages/signIn_page.dart';
import 'package:cine_app/utils/config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    final secureStorage = FlutterSecureStorage();

    return GraphQLProvider(
      client: Config.getLink(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Cine_App",
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF0F111D),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        ),
        home: SignIn(),
      ),
    );
  }
}
