import 'package:gardening/src/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:gardening/src/providers/auth_provider.dart';

import 'package:gardening/src/utils/my_colors.dart' as utils;
import 'package:gardening/src/widgets/button_app.dart';
import 'package:ndialog/ndialog.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late AuthProvider _authProvider;
  late TextEditingController _conPass;
  late TextEditingController _conPassNew;
  @override
  void initState() {
    _authProvider = new AuthProvider();
    _conPass = TextEditingController();
    _conPassNew = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _textLogin(),
            SizedBox(
              height: 30,
            ),
            _textFieldEmail(),
            _textFieldPassword(),
            _buttonLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: () async {
          if (_conPass.text.isNotEmpty && _conPassNew.text.isNotEmpty) {
            ProgressDialog _progressDialog = ProgressDialog(context,
                message: Text("Por favor, espere un momento"), title: Text("Cargando"));
            _progressDialog.show();
            try {
              bool hasChanged =
                  await _authProvider.changePassword(_conPass.text, _conPassNew.text, context);
            } catch (error) {
              _progressDialog.dismiss();
              final snackBar = SnackBar(content: Text('Error: $error'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            _progressDialog.dismiss();
          } else {
            final snackBar = SnackBar(content: Text('Favor de ingresar todos los campos'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        text: 'Iniciar sesion',
        color: utils.MyColors.primaryColor,
        textColor: Colors.white,
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _conPass,
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Contraseña actual',
            suffixIcon: Icon(
              Icons.lock_open_outlined,
              color: utils.MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        obscureText: true,
        controller: _conPassNew,
        decoration: InputDecoration(
            labelText: 'Nueva contraseña',
            suffixIcon: Icon(
              Icons.lock_open_outlined,
              color: utils.MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Cambiar contraseña',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
      ),
    );
  }
}
