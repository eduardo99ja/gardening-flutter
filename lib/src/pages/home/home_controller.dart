import 'package:flutter/material.dart';

import 'package:gardening/src/models/user.dart';
import 'package:gardening/src/pages/plants/details.dart';

class HomeController {
  late BuildContext context;

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  late Function refresh;
  User? user;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    getCategories();
    refresh();
  }

  void getCategories() async {
    refresh();
  }

  void openDrawer() {
    key.currentState!.openDrawer();
  }

  goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToCreate() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new CreatePlant()));
  }

  void goToCredits() {
    Navigator.pushNamed(context, 'credits');
  }
}
