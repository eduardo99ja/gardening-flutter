import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gardening/src/helper/hex_color.dart';
import 'package:gardening/src/layout/back_layout.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'dart:math';

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

  final Duration fillDuration = Duration(milliseconds: 500);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
    return BackLayout(
      size: Size(width!, height!),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [color1, color2]),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.05 * height!),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 2.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        'https://www.conflores.cl/wp-content/uploads/2019/09/flor-flamingo-flower-800x450.jpg',
                        width: 200,
                        height: 150,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 0.9 * height!,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Lirio Flamingo',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: color2,
                                child: IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () => print("button"),
                                    icon: Icon(Icons.add, color: Colors.white)),
                              ),
                            ))
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'Genero:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Expanded(
                              child: Text(
                                'Anthurium',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Nombre botánico:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Expanded(
                              child: Text(
                                'Anthurium andraemun',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Nombre común:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Expanded(
                              child: Text(
                                'Lirio Flamingo',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Galería de fotos',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 15),
                        _swiper(),
                        SizedBox(height: 20),
                        Container(
                          height: 0.22 * height!,
                          child: ListView(
                            padding: EdgeInsets.all(15.0),
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildUsageItem(
                                  Icons.opacity, false, 'Humedad del suelo'),
                              _buildUsageItem(
                                  Icons.cloud_queue, true, ' LLuvia'),
                              _buildUsageItem(Icons.invert_colors, true,
                                  'Humedad atmosferica'),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Realidad Aumentada',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: color2,
                                child: IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () => print("button"),
                                    icon: Icon(MdiIcons.flower,
                                        color: Colors.white)),
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        )),
      ),
    );
  }

  Widget _swiper() {
    return Container(
      width: double.infinity,
      height: 180.0,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.8,
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            images[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: images.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }

  _buildUsageItem(IconData icon, bool isOn, String title) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      width: 0.35 * width!,
      decoration: BoxDecoration(
        color: isOn ? Colors.white : color1,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.all(0.025 * width!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isOn ? Colors.black : Colors.white,
              ),
              Spacer(),
              !isOn
                  ? Icon(Icons.check_circle_outline)
                  : Icon(
                      Icons.highlight_off_outlined,
                      color: Colors.red,
                    )
            ],
          ),
          Spacer(),
          Text(
            '$title',
            style: TextStyle(color: isOn ? Colors.black : Colors.white),
          ),
          Spacer(),
          Text(
            "${Random().nextInt(100)} %",
            style: TextStyle(
                fontSize: 30, color: isOn ? Colors.black : Colors.white),
          ),
        ],
      ),
    );
  }

  _buildDevicesRow() {
    return Row(
      children: [
        SizedBox(width: 15),
        Icon(Icons.wifi),
        SizedBox(width: 5),
        Text("Conectado: GD1023"),
        Spacer(),
        Icon(Icons.pie_chart),
        SizedBox(width: 5),
        Text("Historico"),
        SizedBox(width: 15),
      ],
    );
  }
}
