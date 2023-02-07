import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:stream_e_cart/constants/app_colors.dart';
import 'auth_screens/ui/first_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: appColor,
        backgroundColor: colorWhite,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 12.0),
        ),
      ),
      home: FirstScreen()));
}
