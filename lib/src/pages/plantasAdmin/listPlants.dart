import 'package:gardening/src/pages/home/home_controller.dart';

import 'package:gardening/src/providers/auth_provider.dart';
import 'package:gardening/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:gardening/src/pages/home/components/vertical_card_pager.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class listPlants extends StatefulWidget {
  const listPlants({Key? key}) : super(key: key);

  @override
  _listPlantsState createState() => _listPlantsState();
}

class _listPlantsState extends State<listPlants> {
  HomeController _con = HomeController();
  late AuthProvider _authProvider;

  final List<String> titles = [
    "Ceropegia",
    "Helecho",
    "Maranta",
    "Pluma Rosa",
    "Violeta Africana",
    "Crasas",
  ];

  final List<Widget> images = [
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/img/ceropegiaWoodii.jpg",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/img/helecho.jpg",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/img/marantaLeuconera.jpg",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/img/plumaRosa.jpg",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/img/violetaAfricana.jpg",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/img/crasas.jpg",
        fit: BoxFit.cover,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _authProvider = new AuthProvider();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          children: [
            SizedBox(height: 40),
            _menuDrawer(),
          ],
        ),
        centerTitle: true,
        title: Text(
          "\tPlantas en Base de Datos",
          style: TextStyle(fontSize: 20, fontFamily: 'RobotoMono'),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await _authProvider.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'roles', (route) => false);
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      drawer: _drawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 40.0, 10.0),
                  hintText: 'Busqueda',
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    await _authProvider.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'roles', (route) => false);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(left: 0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    height: 180,
                    width: size.width / 2,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/img/ceropegiaWoodii.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(1.0),
                                        Colors.transparent
                                      ]))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () => print("button"),
                                    icon: Icon(MdiIcons.pencilBoxMultiple,
                                        size: 30, color: Colors.green[500])),
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(MdiIcons.delete),
                                    iconSize: 25,
                                    color: Colors.red[700],
                                    tooltip: ' Carrito',
                                    onPressed: () {}),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    height: 180,
                    width: size.width / 2,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/img/crasas.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(1.0),
                                        Colors.transparent
                                      ]))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () => print("button"),
                                    icon: Icon(MdiIcons.pencilBoxMultiple,
                                        size: 30, color: Colors.green[500])),
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(MdiIcons.delete),
                                    iconSize: 25,
                                    color: Colors.red[700],
                                    tooltip: ' Carrito',
                                    onPressed: () {}),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    height: 180,
                    width: size.width / 2,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/img/helecho.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(1.0),
                                        Colors.transparent
                                      ]))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () => print("button"),
                                    icon: Icon(MdiIcons.pencilBoxMultiple,
                                        size: 30, color: Colors.green[500])),
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(MdiIcons.delete),
                                    iconSize: 25,
                                    color: Colors.red[700],
                                    tooltip: ' Carrito',
                                    onPressed: () {}),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    height: 180,
                    width: size.width / 2,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                                'assets/img/marantaLeuconera.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(1.0),
                                        Colors.transparent
                                      ]))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () => print("button"),
                                    icon: Icon(MdiIcons.pencilBoxMultiple,
                                        size: 30, color: Colors.green[500])),
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(MdiIcons.delete),
                                    iconSize: 25,
                                    color: Colors.red[700],
                                    tooltip: ' Carrito',
                                    onPressed: () {}),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    height: 180,
                    width: size.width / 2,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/img/plumaRosa.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(1.0),
                                        Colors.transparent
                                      ]))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () => print("button"),
                                    icon: Icon(MdiIcons.pencilBoxMultiple,
                                        size: 30, color: Colors.green[500])),
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(MdiIcons.delete),
                                    iconSize: 25,
                                    color: Colors.red[700],
                                    tooltip: ' Carrito',
                                    onPressed: () {}),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    height: 180,
                    width: size.width / 2,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/img/violetaAfricana.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(1.0),
                                        Colors.transparent
                                      ]))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () => print("button"),
                                    icon: Icon(MdiIcons.pencilBoxMultiple,
                                        size: 30, color: Colors.green[500])),
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(MdiIcons.delete),
                                    iconSize: 25,
                                    color: Colors.red[700],
                                    tooltip: ' Carrito',
                                    onPressed: () {}),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuDrawer() => GestureDetector(
        onTap: _con.openDrawer,
        child: Container(
          margin: EdgeInsets.only(left: 20.0),
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/img/menu.png',
            width: 20.0,
            height: 20.0,
          ),
        ),
      );

  Widget _drawer() => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_con.user?.name ?? 'Prueba'} ${_con.user?.lastname ?? 'Test'}',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    _con.user?.email ?? 'email@prueba.com',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: null,
              title: Text('Inicio'),
              trailing: Icon(Icons.home),
            ),
            ListTile(
              onTap: _con.goToCreate,
              title: Text('Agregar planta'),
              trailing: Icon(Icons.add),
            ),
            ListTile(
              title: Text('Creditos'),
              trailing: Icon(Icons.info),
              onTap: _con.goToCredits,
            ),
          ],
        ),
      );
  refresh() {
    setState(() {});
  }
}
