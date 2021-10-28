import 'package:gardening/src/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:gardening/src/pages/register/register_controller.dart';
import 'package:gardening/src/utils/my_colors.dart' as utils;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = new RegisterController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bannerApp(),
            _textRegister(),
            _textFieldUsername(),
            _textFieldName(),
            _textFieldLastname(),
            _textFieldEmail(),
            _textFieldPassword(),
            _textFieldConfirmPassword(),
            _buttonRegister(),
          ],
        ),
      ),
    );
  }

  Widget _buttonRegister() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: ButtonApp(
          onPressed: _con.register,
          text: 'Registrar ahora',
          color: utils.MyColors.primaryColor,
          textColor: Colors.white,
        ),
      );

  Widget _textFieldEmail() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          controller: _con.emailController,
          decoration: InputDecoration(
              hintText: 'correo@gmail.com',
              labelText: 'Correo electronico',
              suffixIcon: Icon(
                Icons.email_outlined,
                color: utils.MyColors.primaryColor,
              )),
        ),
      );

  Widget _textFieldUsername() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          controller: _con.usernameController,
          decoration: InputDecoration(
              hintText: 'Nombre de usuario',
              labelText: 'Nombre de usuario',
              suffixIcon: Icon(
                Icons.person_outline,
                color: utils.MyColors.primaryColor,
              )),
        ),
      );
  Widget _textFieldName() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          controller: _con.nameController,
          decoration: InputDecoration(
              hintText: 'Nombre completo',
              labelText: 'Nombre(s)',
              suffixIcon: Icon(
                Icons.person_outline,
                color: utils.MyColors.primaryColor,
              )),
        ),
      );
  Widget _textFieldLastname() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          controller: _con.lastnameController,
          decoration: InputDecoration(
              hintText: 'Apellidos',
              labelText: 'Apellidos',
              suffixIcon: Icon(
                Icons.person_outline,
                color: utils.MyColors.primaryColor,
              )),
        ),
      );

  Widget _textFieldPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: TextField(
          obscureText: true,
          controller: _con.passwordController,
          decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon: Icon(
                Icons.lock_open_outlined,
                color: utils.MyColors.primaryColor,
              )),
        ),
      );

  Widget _textFieldConfirmPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: TextField(
          obscureText: true,
          controller: _con.confirmPasswordController,
          decoration: InputDecoration(
              labelText: 'Confirmar Contraseña',
              suffixIcon: Icon(
                Icons.lock_open_outlined,
                color: utils.MyColors.primaryColor,
              )),
        ),
      );

  Widget _textRegister() => Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          'REGISTRO',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      );

  Widget _bannerApp() => ClipPath(
        clipper: WaveClipperTwo(),
        child: Container(
          color: utils.MyColors.primaryColor,
          height: MediaQuery.of(context).size.height * 0.22,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'El cuidado de tus plantas \na un solo click',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w200),
              )
            ],
          ),
        ),
      );
}
