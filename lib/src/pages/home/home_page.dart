import 'package:flutter/scheduler.dart';
import 'package:gardening/src/pages/home/home_controller.dart';
import 'package:gardening/src/providers/auth_provider.dart';
import 'package:gardening/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:gardening/src/pages/home/components/vertical_card_pager.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
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
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: VerticalCardPager(
                  textStyle: TextStyle(
                      fontFamily: "Bevan",
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  titles: titles,
                  images: images,
                  initialPage: 0,
                  onPageChanged: (page) {
                    // print(page);
                  },
                  onSelectedItem: (index) {},
                ),
              ),
            ),
          ],
        ),
      ),
      /* bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.0),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.white,
              gap: 8,
              activeColor: Colors.grey[600],
              iconSize: 40,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              tabBackgroundColor: Colors.white!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: MdiIcons.leaf,
                  onPressed: _con.goToCreate,
                ),
                GButton(
                  icon: MdiIcons.plusBoxOutline,
                ),
                GButton(
                  icon: MdiIcons.accountCircleOutline,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),*/
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
              onTap: _con.goToDetailsCreate,
              title: Text('Vista plantas'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: _con.goToListPlants,
              title: Text('Plantas en base'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: _con.goToPlantInfoReal,
              title: Text('Estadisticas planta'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: _con.goToPlantInfoHistory,
              title: Text('Historico planta'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: _con.goToUserAccount,
              title: Text('Cuenta usuario'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: _con.goToAdminAccount,
              title: Text('Cuenta admin'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: _con.goToLogin,
              title: Text('login'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: _con.goToRegister,
              title: Text('Registro'),
              trailing: Icon(Icons.add),
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
}
