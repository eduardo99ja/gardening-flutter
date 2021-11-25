import 'package:flutter/material.dart';

import 'package:gardening/src/models/user.dart';
import 'package:gardening/src/pages/plantasAdmin/create.dart';
import 'package:gardening/src/providers/auth_provider.dart';

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
    Navigator.pushNamed(context, 'addPlantScreen');
  }

  void goToDetailsCreate() {
    Navigator.pushNamed(context, 'details');
  }

  void goToListPlants() {
    Navigator.pushNamed(context, 'listPlants');
  }

  void goToAdminAccount() {
    Navigator.pushNamed(context, 'account/admin');
  }

  void goToUserAccount() {
    Navigator.pushNamed(context, 'account/user');
  }

  void goToPlantInfoReal() {
    Navigator.pushNamed(context, 'plant/info/real');
  }

  void goToPlantInfoHistory() {
    Navigator.pushNamed(context, 'plant/info/history');
  }

  void goToLogin() {
    Navigator.pushNamed(context, 'login');
  }

  void goToRegister() {
    Navigator.pushNamed(context, 'register');
  }

  void goToCredits() {
    Navigator.pushNamed(context, 'credits');
  }

  void goToCreatePlantAdmin() {
    Navigator.pushNamed(context, 'plants/create');
  }

  void goToSearch() {
    Navigator.pushNamed(context, 'plants/search');
  }
}
