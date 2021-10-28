import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gardening/src/helper/hex_color.dart';
import 'package:gardening/src/layout/back_layout.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchPlant extends StatefulWidget {
  static const String route = "/SearchPlant";
  @override
  _SearchPlantState createState() => _SearchPlantState();
}

Color color1 = HexColor("#59fb12");
Color color2 = HexColor("#4ed810");

List<String> images = [
  "https://newses.cgtn.com/n/BfJAA-CAA-FcA/BHCACAA.jpg",
  "https://blog.gardencenterejea.com/wp-content/uploads/2016/10/Cuidado-lirio-flamingo.jpg",
  "https://www.conflores.cl/wp-content/uploads/2019/09/flor-flamingo-flower-800x450.jpg"
];

class _SearchPlantState extends State<SearchPlant>
    with SingleTickerProviderStateMixin {
  double? height, width;
  late TextEditingController _controller;

  final Duration fillDuration = Duration(milliseconds: 500);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Theme(
        data: ThemeData(
          iconTheme: IconThemeData(color: Colors.white),
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          ),
        ),
        child: Scaffold(
          appBar: PreferredSize(
              child: Expanded(child: campoBusqueda()),
              preferredSize: Size.fromHeight(78)),
          body: _buildBody(),
        ),
      );
    });
  }

  _buildBody() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.clarin.com/2020/09/08/las-suculentas-son-plantas-muy___NwExXM3p3_640x361__1.jpg"),
                  fit: BoxFit.fitWidth,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  alignment: Alignment.center),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('Suculentas y cactus',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () => print("Aiuda, estoy muriendo"),
                      icon: Icon(Icons.input_outlined),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )),
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://www.hogarmania.com/archivos/202006/plantas-flores-llamativas-1280x720x80xX.jpg"),
                  fit: BoxFit.fitWidth,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  alignment: Alignment.center),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('Florales    ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () => print("Aiuda, estoy muriendo"),
                      icon: Icon(Icons.input_outlined),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )),
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://www.guiadejardineria.com/wp-content/uploads/2020/01/planta-con-follaje-rojo-1.jpg"),
                  fit: BoxFit.fitWidth,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  alignment: Alignment.center),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('Follaje       ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () => print("Aiuda, estoy muriendo"),
                      icon: Icon(Icons.input_outlined),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )),
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://www.hogarmania.com/archivos/201701/12-plantas-interior-hoja-grande-1280x720x80xX.jpg"),
                  fit: BoxFit.fitWidth,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  alignment: Alignment.center),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('Plantas de hoja verde',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () => print("Aiuda, estoy muriendo"),
                      icon: Icon(Icons.input_outlined),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )),
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://previews.123rf.com/images/prinprince/prinprince1709/prinprince170900164/86754131-bush-de-hojas-rojas-planta-en-jard%C3%ADn-en-fresco-y-relajarse-emoci%C3%B3n-hermosa-textura-en-el-patio-trase.jpg"),
                  fit: BoxFit.fitWidth,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  alignment: Alignment.center),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('Plantas de hoja roja',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () => print("Aiuda, estoy muriendo"),
                      icon: Icon(Icons.input_outlined),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )),
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://www.ecoterrazas.com/blog/wp-content/uploads/orquideas-ecoterrazas-3-660x330.jpg"),
                  fit: BoxFit.fitWidth,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  alignment: Alignment.center),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('Orquídeas',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () => print("Aiuda, estoy muriendo"),
                      icon: Icon(Icons.input_outlined),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }

  Widget campoBusqueda() {
    return Container(
        color: Theme.of(context).primaryColor,
        child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
                child: new ListTile(
              leading:
                  new IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              title: new TextField(
                decoration: new InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                // onChanged: onSearchTextChanged,
              ),
              trailing: new IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () {
                  // onSearchTextChanged('');
                },
              ),
            ))));
  }
}
