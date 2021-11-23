import 'package:flutter/scheduler.dart';
import 'package:gardening/src/models/jardin.dart';
import 'package:gardening/src/pages/addPlant/components/body.dart';
import 'package:gardening/src/pages/details/components/body.dart';
import 'package:gardening/src/pages/details/details-screen.dart';
import 'package:gardening/src/pages/home/home_controller.dart';
import 'package:gardening/src/providers/auth_provider.dart';
import 'package:gardening/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:gardening/src/pages/home/components/vertical_card_pager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:gardening/src/models/jardin.dart';

import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _con = HomeController();
  late AuthProvider _authProvider;

  final _dbRef = FirebaseFirestore.instance;
  List<Plant>? plant;
  StreamSubscription<QuerySnapshot>? addPlant;

  final _dbRefJ = FirebaseFirestore.instance;
  List<jardin>? LJardin;
  StreamSubscription<QuerySnapshot>? addjardin;

  List<String>? imagesP;
  List<String> tiP = [];

  final List<String> titles = [
    "Ceropegia",
    "Helecho",
    "Maranta",
    "Pluma Rosa",
    "Violeta Africana",
    "Crasas",
  ];
  final List<Widget> images = [];

  final List<Widget> imagesq = [
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

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    _authProvider = new AuthProvider();

    plant = [];
    addPlant = _dbRef
        .collection('Plantas')
        .where("idPlanta", whereIn: LJardin)
        .snapshots()
        .listen(agregarPlanta);
    LJardin = [];
    addjardin = _dbRef
        .collection('MiJardin')
        .where('idUsuario', isEqualTo: _authProvider.getUser().uid)
        .snapshots()
        .listen(agregarJardin);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "\tMi jardín",
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: VerticalCardPager(
                  textStyle: TextStyle(
                      fontFamily: "Bevan", color: Colors.white, fontWeight: FontWeight.bold),
                  titles: tiP,
                  images: images,
                  initialPage: 0,
                  onPageChanged: (page) {
                    // print(page);
                  },
                  onSelectedItem: (index) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          garden: LJardin![index],
                          plant: plant![index],
                        ),
                      ),
                    );
                  },
                ),
              ),
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
              onTap: _con.goToSearch,
              title: Text('Buscar planta '),
              trailing: Icon(Icons.add),
            ),
            ListTile(
              onTap: _con.goToUserAccount,
              title: Text('Cuenta usuario'),
              trailing: Icon(Icons.arrow_right),
            ),

            /* ListTile(
              title: Text('Creditos'),
              trailing: Icon(Icons.info),
              onTap: _con.goToCredits,
            ),*/
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
      });
    });
  }

  agregarJardin(QuerySnapshot evento) {
    LJardin = [];
    evento.docs.forEach((element) {
      setState(() {
        LJardin!.add(new jardin.fromElement(element));
      });
    });
    List<Plant> showResults = [];
    for (var tripSnapshotP in plant!) {
      var titleP = tripSnapshotP.id!.toLowerCase();
      String img = tripSnapshotP.img!.split("name")[0];
      String ti = tripSnapshotP.nomComm!;

      for (var tripSnapshot in LJardin!) {
        var title = tripSnapshot.idPlanta!.toLowerCase();
        if (title.contains(titleP)) {
          showResults.add(tripSnapshotP);
          images.add(ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              fit: BoxFit.cover,
              image: NetworkImage(img),
              placeholder: AssetImage("assets/img/loading.jpg"),
            ),
          ));

          tiP.add(ti);
        }
      }
    }
    print(showResults.length);
    plant = showResults;
    setState(() {});
  }
}
