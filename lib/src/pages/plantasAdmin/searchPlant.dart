import 'package:flutter/material.dart';
import 'package:gardening/src/pages/addPlant/addPlant_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:gardening/src/models/plant.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardening/src/pages/home/home_controller.dart';
import 'package:gardening/src/providers/auth_provider.dart';
import 'package:gardening/src/utils/my_colors.dart';

class SearchPlant extends StatefulWidget {
  static const String route = "/SearchPlant";
  @override
  _SearchPlantState createState() => _SearchPlantState();
}

class _SearchPlantState extends State<SearchPlant> {
  TextEditingController _searchController = TextEditingController();

  Future? resultsLoaded;
  List<Plant>? _resultsList = [];

  final _dbRef = FirebaseFirestore.instance;
  List<Plant>? plant;
  StreamSubscription<QuerySnapshot>? addPlant;

  HomeController _con = HomeController();
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();

    _authProvider = new AuthProvider();

    plant = [];
    addPlant = _dbRef.collection('Plantas').snapshots().listen(agregarPlanta);
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
            ],
          ),
          centerTitle: true,
          title: Text(
            "\tPlantas",
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
                            onTap: () => addPlanta(_resultsList![index]),
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
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
                                          )
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

  addPlanta(Plant plant) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => addPlantScreen(plant)));
  }
}
