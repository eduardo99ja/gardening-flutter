import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:gardening/src/pages/home/home_controller.dart';

import 'package:gardening/src/pages/plantasAdmin/edit.dart';

import 'package:gardening/src/pages/plantasAdmin/components/view_plantBody.dart';

import 'package:gardening/src/pages/plantasAdmin/listPlants_controller.dart';
import 'package:gardening/src/pages/plantasAdmin/view_plant.dart';
import 'dart:async';

import 'package:gardening/src/providers/auth_provider.dart';
import 'package:gardening/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:gardening/src/models/plant.dart';

import 'package:google_fonts/google_fonts.dart';

class listPlants extends StatefulWidget {
  const listPlants({Key? key}) : super(key: key);

  @override
  _listPlantsState createState() => _listPlantsState();
}

class _listPlantsState extends State<listPlants> {
  TextEditingController _searchController = TextEditingController();

  Future? resultsLoaded;
  List<Plant>? _resultsList = [];

  final _dbRef = FirebaseFirestore.instance;

  late CollectionReference _ref;
  List<Plant>? plant;
  StreamSubscription<QuerySnapshot>? addPlant;

  listPlantsController _con = listPlantsController();

  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();

    _authProvider = new AuthProvider();
    _con.init(context, refresh);
    plant = [];
    addPlant = _dbRef.collection('Plantas').snapshots().listen(agregarPlanta);
    _ref = FirebaseFirestore.instance.collection('Plantas');
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    addPlant!.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    List<Plant> showResults = [];
    if (_searchController.text != "" && _searchController.text != null) {
      for (var tripSnapshot in plant!) {
        var title = tripSnapshot.nomComm!.toLowerCase();
        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      plant!.clear();
      addPlant = _dbRef.collection('Plantas').snapshots().listen(agregarPlanta);
      showResults = List.from(plant!);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersPastTripsStreamSnapshots() async {
    searchResultsList();
    return "complete";
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
                Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
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
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 40.0, 10.0),
                    hintText: 'Busqueda',
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _resultsList!.length,
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                            onTap: () => viewPlantM(_resultsList![index]),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                              height: 180,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: FadeInImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "${_resultsList![index].img!.split('name')[0]}"),
                                        placeholder: AssetImage("assets/img/loading.jpg"),
                                      ),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          IconButton(
                                              tooltip: 'Editar',
                                              padding: new EdgeInsets.all(0.0),
                                              onPressed: () => _editaPlanta(_resultsList![index]),
                                              icon: Icon(MdiIcons.pencilBoxMultiple,
                                                  size: 30, color: Color(0xff59fb12))),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "\t${_resultsList![index].nomComm}",
                                            style: GoogleFonts.leckerliOne(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  letterSpacing: .5),
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(MdiIcons.delete),
                                              iconSize: 25,
                                              color: Colors.red[500],
                                              tooltip: 'Borrar',
                                              onPressed: () {
                                                _openModal(_resultsList![index]);
                                              }),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))),
            ],
          ),
        ));
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
                    "Bienvenido",
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
                    _authProvider.getUser().email!,
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
              title: Text('Mi cuenta'),
              trailing: Icon(Icons.person),
              onTap: _con.goToCuenta,
            ),
            ListTile(
              title: Text('Créditos'),
              trailing: Icon(Icons.info),
              onTap: _con.goToCredits,
            ),
          ],
        ),
      );
  refresh() {
    setState(() {});
  }

  agregarPlanta(QuerySnapshot evento) {
    plant = [];
    evento.docs.forEach((element) {
      setState(() {
        plant!.add(new Plant.fromElement(element));
        _resultsList = plant;
      });
    });
  }

  _editaPlanta(Plant planta) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditPlant(planta)));
  }

  _openModal(Plant plant) {
    Widget btnAceptar = new TextButton(
      onPressed: () => _borrarPlanta(plant),
      child: Text('Aceptar'),
    );

    Widget btnCancelar = new TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('Cancelar'),
    );

    AlertDialog alerta = new AlertDialog(
      title: Text('Esta seguro que desea borrar al registro?'),
      actions: [btnAceptar, btnCancelar],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        });
  }

  _borrarPlanta(Plant plant) async {
    print(plant.img!.split("name")[0]);
    await _ref.doc(plant.id!).delete().then((value) {
      print('Se borro la planta');
      Navigator.of(context).pop();
      Reference ref =
          FirebaseStorage.instance.ref().child('plantas').child('${plant.img!.split("name")[1]}');
      ref
          .delete()
          .then((value) => print("Se borro la imagen principal"))
          .catchError((error) => print(error));
      ref =
          FirebaseStorage.instance.ref().child('plantas').child('${plant.img1!.split("name")[1]}');
      ref
          .delete()
          .then((value) => print("Se borro la imagen principal"))
          .catchError((error) => print(error));
      ref =
          FirebaseStorage.instance.ref().child('plantas').child('${plant.img2!.split("name")[1]}');
      ref
          .delete()
          .then((value) => print("Se borro la imagen principal"))
          .catchError((error) => print(error));
      ref =
          FirebaseStorage.instance.ref().child('plantas').child('${plant.img3!.split("name")[1]}');
      ref
          .delete()
          .then((value) => print("Se borro la imagen principal"))
          .catchError((error) => print(error));
      setState(() {});
    }).catchError((error) => print(error));
  }

  viewPlantM(Plant plant) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => viewPlantScreen(plant)));
  }
}
