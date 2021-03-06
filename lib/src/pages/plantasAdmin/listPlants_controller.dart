import 'package:flutter/material.dart';

import 'package:gardening/src/models/user.dart';

class listPlantsController {
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
    Navigator.pushNamed(context, 'plants/create');
  }

  void goToCuenta() {
    Navigator.pushNamed(context, 'account/admin');
  }

  void goToCredits() {
    Navigator.pushNamed(context, 'credits');
  }
}
