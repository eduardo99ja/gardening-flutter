import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gardening/src/helper/hex_color.dart';
import 'package:gardening/src/layout/back_layout.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreatePlant extends StatefulWidget {
  static const String route = "/CreatePlant";
  @override
  _CreatePlantState createState() => _CreatePlantState();
}

Color color1 = HexColor("#59fb12");
Color color2 = HexColor("#4ed810");

List<String> images = [
  "https://newses.cgtn.com/n/BfJAA-CAA-FcA/BHCACAA.jpg",
  "https://blog.gardencenterejea.com/wp-content/uploads/2016/10/Cuidado-lirio-flamingo.jpg",
  "https://www.conflores.cl/wp-content/uploads/2019/09/flor-flamingo-flower-800x450.jpg"
];

class _CreatePlantState extends State<CreatePlant>
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
          body: _buildBody(),
        ),
      );
    });
  }

  _buildBody() {
    return Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [color1, color2]),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Image.network(
                            'https://www.conflores.cl/wp-content/uploads/2019/09/flor-flamingo-flower-800x450.jpg',
                            width: 250,
                            height: 150,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: color2,
                            child: IconButton(
                                padding: new EdgeInsets.all(0.0),
                                onPressed: () => print("button"),
                                icon: Icon(MdiIcons.flowerPollen,
                                    color: Colors.white)),
                          ),
                        )),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Nombre común',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: color2,
                            child: IconButton(
                                padding: new EdgeInsets.all(0.0),
                                onPressed: () => print("button"),
                                icon: Icon(MdiIcons.book, color: Colors.white)),
                          ),
                        )),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Nombre Botánico',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: color2,
                            child: IconButton(
                                padding: new EdgeInsets.all(0.0),
                                onPressed: () => print("button"),
                                icon:
                                    Icon(MdiIcons.label, color: Colors.white)),
                          ),
                        )),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Género',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: color2,
                            child: IconButton(
                                padding: new EdgeInsets.all(0.0),
                                onPressed: () => print("button"),
                                icon:
                                    Icon(MdiIcons.water, color: Colors.white)),
                          ),
                        )),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Riego cada...',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                            ),
                            isExpanded: true,
                            style: const TextStyle(color: Color(0xFF000000)),
                            items: <String>['Vendedor', 'Comprador']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: color2,
                            child: IconButton(
                                padding: new EdgeInsets.all(0.0),
                                onPressed: () => print("button"),
                                icon: Icon(MdiIcons.sunWireless,
                                    color: Colors.white)),
                          ),
                        )),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Sol',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                            ),
                            isExpanded: true,
                            style: const TextStyle(color: Color(0xFF000000)),
                            items: <String>['Vendedor', 'Comprador']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: color2,
                            child: IconButton(
                                padding: new EdgeInsets.all(0.0),
                                onPressed: () => print("button"),
                                icon:
                                    Icon(MdiIcons.cloud, color: Colors.white)),
                          ),
                        )),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Humedad',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                            ),
                            isExpanded: true,
                            style: const TextStyle(color: Color(0xFF000000)),
                            items: <String>['Vendedor', 'Comprador']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: color2,
                            child: IconButton(
                                padding: new EdgeInsets.all(0.0),
                                onPressed: () => print("button"),
                                icon: Icon(MdiIcons.thermometer,
                                    color: Colors.white)),
                          ),
                        )),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: 'Temperatura',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                            ),
                            isExpanded: true,
                            style: const TextStyle(color: Color(0xFF000000)),
                            items: <String>['Vendedor', 'Comprador']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Galería de fotos',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            'https://www.conflores.cl/wp-content/uploads/2019/09/flor-flamingo-flower-800x450.jpg',
                            width: 100,
                            height: 60,
                          ),
                        ),
                        Expanded(
                          child: Image.network(
                            'https://www.conflores.cl/wp-content/uploads/2019/09/flor-flamingo-flower-800x450.jpg',
                            width: 100,
                            height: 60,
                          ),
                        ),
                        Expanded(
                          child: Image.network(
                            'https://www.conflores.cl/wp-content/uploads/2019/09/flor-flamingo-flower-800x450.jpg',
                            width: 100,
                            height: 60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
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
}
