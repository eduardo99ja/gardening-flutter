import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:gardening/src/widgets/button_app.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gardening/src/helper/hex_color.dart';
import 'package:gardening/src/layout/back_layout.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreatePlant extends StatefulWidget {
  static const String route = "/CreatePlant";
  @override
  _CreatePlantState createState() => _CreatePlantState();
}

Color color1 = HexColor("#59fb12");
Color color2 = HexColor("#4ed810");
PickedFile? pickFileAux;
PickedFile? pickFile;
PickedFile? pickFile1;
PickedFile? pickFile2;
PickedFile? pickFile3;
File? imageFile;
List<File?>? imagesFiles = List.filled(3, null);
String? imgName;
String? imgName1;
String? imgName2;
String? imgName3;
List<String> images = [
  "assets/img/plumaRosa.jpg",
  "assets/img/plumaRosa.jpg",
  "assets/img/plumaRosa.jpg"
];
File? img1, img2, img3;

TextEditingController? nomComm = TextEditingController();
TextEditingController? nomBot = TextEditingController();
TextEditingController? genero = TextEditingController();
String? riego = '';
String? sol = '';
String? humedad = '';
String? temperatura = '';

late CollectionReference _ref;

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
    _ref = FirebaseFirestore.instance.collection('Plantas');
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
          child: SafeArea(
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Center(child: imagecard(imageFile)),
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
                              controller: nomComm,
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
                                  icon:
                                      Icon(MdiIcons.book, color: Colors.white)),
                            ),
                          )),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: nomBot,
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
                                  icon: Icon(MdiIcons.label,
                                      color: Colors.white)),
                            ),
                          )),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: genero,
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
                                  icon: Icon(MdiIcons.water,
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
                                labelText: 'Riego cada...',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10),
                              ),
                              isExpanded: true,
                              onChanged: (String? valor) {
                                setState(() {
                                  riego = valor!;
                                });
                              },
                              style: const TextStyle(color: Color(0xFF000000)),
                              items: <String>[
                                '6-8 hrs',
                                '8-12 hrs'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                labelText: 'Nivel de Sol',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10),
                              ),
                              isExpanded: true,
                              onChanged: (String? valor) {
                                setState(() {
                                  sol = valor!;
                                });
                              },
                              style: const TextStyle(color: Color(0xFF000000)),
                              items: <String>[
                                'Bajo',
                                'Medio',
                                'Alto'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                  icon: Icon(MdiIcons.cloud,
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
                                labelText: 'Humedad',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10),
                              ),
                              isExpanded: true,
                              onChanged: (String? valor) {
                                setState(() {
                                  humedad = valor!;
                                });
                              },
                              style: const TextStyle(color: Color(0xFF000000)),
                              items: <String>[
                                'Baja',
                                'Alta'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                labelText: 'Rango de Temperatura',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10),
                              ),
                              isExpanded: true,
                              onChanged: (String? valor) {
                                setState(() {
                                  temperatura = valor!;
                                });
                              },
                              style: const TextStyle(color: Color(0xFF000000)),
                              items: <String>[
                                '< 30 °C',
                                '> 30 °C < 40 °C',
                                '> 40 °C'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                      _swiper(),
                      _buttonRegister()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _swiper() {
    return Container(
      width: double.infinity,
      height: 180.0,
      child: Swiper(
        viewportFraction: 0.6,
        scale: 0.6,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                  showAlert(index);
                },
                child: (imagesFiles?[index] != null)
                    ? Card(
                        child: Container(
                          height: 150.0,
                          child: Image.file(imagesFiles![index]!),
                        ),
                      )
                    : Card(
                        child: Container(
                          height: 150.0,
                          child: Image.asset(
                            "assets/img/camera.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
              ));
        },
        itemCount: images.length,
        /*pagination: new SwiperPagination(),
      control: new SwiperControl(),*/
      ),
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

  Widget imagecard(File? imageFile) {
    return GestureDetector(
      onTap: () => showAlert(-1),
      child: (imageFile != null)
          ? Card(
              child: Container(
                height: 150.0,
                child: Image.file(imageFile),
              ),
            )
          : Card(
              child: Container(
                height: 150.0,
                child: Image.asset(
                  "assets/img/camera.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
    );
  }

  void showAlert(int numImg) {
//[cameraButton, galleryButton],
    AlertDialog alerta = AlertDialog(
      title: Text('¿Desde donde subir imagen?'),
      actions: <Widget>[
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage("assets/img/gallery.png"),
                              fit: BoxFit.fitWidth,
                              colorFilter: new ColorFilter.mode(
                                  Colors.white.withOpacity(0.3),
                                  BlendMode.dstATop),
                              alignment: Alignment.center)),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.black,
                    ),
                    onPressed: () =>
                        seleccionarImagen(ImageSource.gallery, numImg),
                    child: const Text('Galeria',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 80,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage("assets/img/camera.png"),
                              fit: BoxFit.fitWidth,
                              colorFilter: new ColorFilter.mode(
                                  Colors.white.withOpacity(0.3),
                                  BlendMode.dstATop),
                              alignment: Alignment.center)),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.black,
                    ),
                    onPressed: () =>
                        seleccionarImagen(ImageSource.camera, numImg),
                    child: const Text('Cámara',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        });
  }

  Future seleccionarImagen(ImageSource imgSrc, int ops) async {
    pickFileAux = await ImagePicker().getImage(source: imgSrc);
    if (pickFileAux != null) {
      switch (ops) {
        case -1:
          pickFile = pickFileAux;
          imageFile = File(pickFile!.path);
          break;
        case 0:
          pickFile1 = pickFileAux;
          imagesFiles?[ops] = File(pickFile!.path);
          break;
        case 1:
          pickFile2 = pickFileAux;
          imagesFiles?[ops] = File(pickFile!.path);
          break;
        case 2:
          pickFile3 = pickFileAux;
          imagesFiles?[ops] = File(pickFile!.path);
          break;
      }
    }

    Navigator.of(context).pop();

    setState(() {});
  }

  Widget _buttonRegister() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: ButtonApp(
          onPressed: () async {
            //validacion

            TaskSnapshot snapshot = await subirArchivo(pickFile!, -1);
            TaskSnapshot snapshot1 = await subirArchivo(pickFile1!, 0);
            TaskSnapshot snapshot2 = await subirArchivo(pickFile2!, 1);
            TaskSnapshot snapshot3 = await subirArchivo(pickFile3!, 2);
            String imageUrl = await snapshot.ref.getDownloadURL();
            String imageUrl1 = await snapshot1.ref.getDownloadURL();
            String imageUrl2 = await snapshot2.ref.getDownloadURL();
            String imageUrl3 = await snapshot3.ref.getDownloadURL();

            Plant model = Plant(
                img: imageUrl + 'name' + imgName!,
                img1: imageUrl1 + 'name' + imgName1!,
                img2: imageUrl2 + 'name' + imgName2!,
                img3: imageUrl3 + 'name' + imgName3!,
                nomComm: nomComm!.text,
                nomBot: nomBot!.text,
                genero: genero!.text,
                riego: riego,
                sol: sol,
                humedad: humedad,
                temperatura: temperatura);
            await saveList(model);
            Navigator.pushNamed(context, "listPlants");
          },
          text: 'Registrar planta',
          color: color2,
          textColor: Colors.white,
        ),
      );

  Future? saveList(Plant model) {
    return _ref
        .add(model.toJson())
        .then((value) => print('Se agrego la planta'))
        .catchError((error) => print(error));
  }

  Future<TaskSnapshot> subirArchivo(PickedFile file, int ops) async {
    String nombre = '${UniqueKey().toString()}.jpg';
    switch (ops) {
      case -1:
        imgName = nombre;
        break;
      case 0:
        imgName1 = nombre;
        break;
      case 1:
        imgName2 = nombre;
        break;
      case 2:
        imgName3 = nombre;
        break;
    }
    Reference ref =
        FirebaseStorage.instance.ref().child('plantas').child('/$nombre');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    UploadTask uploadTask = ref.putFile(File(file.path), metadata);
    return uploadTask;
  }
}
