import 'package:flutter/material.dart';
import 'package:gardening/src/pages/credits_page.dart';
import 'package:gardening/src/pages/plantasAdmin/create.dart';
import 'package:gardening/src/pages/plantasAdmin/searchPlant.dart';
import 'package:gardening/src/pages/account/details_admin.dart';
import 'package:gardening/src/pages/account/details_user.dart';
import 'package:gardening/src/pages/home/home_page.dart';
import 'package:gardening/src/pages/login/login_page.dart';
import 'package:gardening/src/pages/plant/plant_info_history.dart';
import 'package:gardening/src/pages/register/register_page.dart';
import 'package:gardening/src/utils/my_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gardening/src/pages/plantasAdmin/listPlants.dart';

import 'src/pages/plantasAdmin/edit.dart';

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
      initialRoute: 'login',
      routes: {
        'register': (BuildContext context) => RegisterPage(),
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'plants/create': (BuildContext context) => CreatePlant(),
        'plants/search': (BuildContext context) => SearchPlant(),
        // 'details': (BuildContext context) => DetailsScreen(),
        'listPlants': (BuildContext context) => listPlants(),
        // 'plant/info/real': (BuildContext context) => PlantInfoRealPage(),
        // 'plant/info/history': (BuildContext context) => PlantInfoHistory(),
        'account/admin': (BuildContext context) => AccountAdminPage(),
        'account/user': (BuildContext context) => AccountUserPage(),
        'credits': (BuildContext context) => CreditsPage(),
      },
      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
        appBarTheme: AppBarTheme(elevation: 0),
      ),
    );
  }
}
