import 'package:flutter/material.dart';
import 'package:gardening/src/pages/home/home_controller.dart';
import 'package:gardening/src/pages/home/home_page.dart';
import 'package:gardening/src/pages/login/login_page.dart';
import 'package:gardening/src/pages/register/register_page.dart';
import 'package:gardening/src/utils/my_colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gardening',
      initialRoute: 'home',
      routes: {
        'register': (BuildContext context) => RegisterPage(),
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
        appBarTheme: AppBarTheme(elevation: 0),
      ),
    );
  }
}
