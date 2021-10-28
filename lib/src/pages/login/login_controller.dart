import 'package:gardening/src/providers/auth_provider.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ndialog/ndialog.dart';

class LoginController {
  late BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  late AuthProvider _authProvider;

  late final userRef;

  Future init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();

    userRef = FirebaseDatabase.instance.reference();
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    ProgressDialog _progressDialog = ProgressDialog(context,
        message: Text("Por favor, espere un momento"), title: Text("Cargando"));
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      final snackBar =
          SnackBar(content: Text('Debes ingresar sus credenciales'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    _progressDialog.show();

    try {
      bool isLogin = await _authProvider.login(email, password);
      _progressDialog.dismiss();

      if (isLogin) {
        print('esta logueado');
        // Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
      }
    } catch (error) {
      _progressDialog.dismiss();
      final snackBar = SnackBar(content: Text('Error: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
