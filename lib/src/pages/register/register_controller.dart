import 'package:gardening/src/models/user.dart';
import 'package:gardening/src/providers/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:gardening/src/providers/user_provider.dart';
import 'package:ndialog/ndialog.dart';

class RegisterController {
  late BuildContext context;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  late AuthProvider _authProvider;
  late UserProvider _userProvider;
  late final userRef;

  String? _typeUser;

  Future? init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
    _userProvider = new UserProvider();
  }

  void register() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Por favor, espere un momento"), title: Text("Cargando"));
    String username = usernameController.text;
    String name = nameController.text;
    String lastname = lastnameController.text;
    String email = emailController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty) {
      final snackBar = SnackBar(content: Text('Debes ingresar todos los campos'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    if (confirmPassword != password) {
      final snackBar = SnackBar(content: Text('Las contraseñas no coinciden'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (password.length < 6) {
      print('el password debe tener al menos 6 caracteres');
      final snackBar = SnackBar(content: Text('La contraseña debe tener al menos 6 caracteres'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    progressDialog.show();

    try {
      bool isRegister = await _authProvider.register(email, password);

      if (isRegister) {
        progressDialog.dismiss();
        User user = User(
            email: email,
            password: password,
            username: username,
            name: name,
            lastname: lastname,
            id: _authProvider.getUser().uid);
        await _userProvider.create(user);
        // print('usuario registrado');
        // _sharedPref.save('user', user.toJson());
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      } else {
        progressDialog.dismiss();

        final snackBar = SnackBar(content: Text('El usuario no se pudó registrar'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (error) {
      progressDialog.dismiss();

      final snackBar = SnackBar(content: Text('Error: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
