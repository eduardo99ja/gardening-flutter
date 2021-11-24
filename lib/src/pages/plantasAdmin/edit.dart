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

class EditPlant extends StatefulWidget {
  final Plant planta;
  EditPlant(this.planta);

  static const String route = "/EditPlant";
  @override
  _EditPlantState createState() => _EditPlantState();
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
List<String?> images = [
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

class _EditPlantState extends State<EditPlant>
    with SingleTickerProviderStateMixin {
  double? height, width;
  late TextEditingController _controller;

  final Duration fillDuration = Duration(milliseconds: 500);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();

    nomComm = TextEditingController(text: widget.planta.nomComm);
    nomBot = TextEditingController(text: widget.planta.nomBot);
    genero = TextEditingController(text: widget.planta.genero);
    riego = widget.planta.riego;
    sol = widget.planta.sol;
    humedad = widget.planta.humedad;
    temperatura = widget.planta.temperatura;

    images = [
      widget.planta.img1!.split('name')[0],
      widget.planta.img2!.split('name')[0],
      widget.planta.img3!.split('name')[0]
    ];

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
                              value: widget.planta.riego,
                              style: const TextStyle(color: Color(0xFF000000)),
                              items: <String>[
                                '6-8 hrs',
                                '8-12 hrs',
                                '12-24 hrs',
                                '24-48 hrs'
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
                              value: widget.planta.sol,
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
                              value: widget.planta.humedad,
                              style: const TextStyle(color: Color(0xFF000000)),
                              items: <String>[
                                '20% - 40%',
                                '40% - 60%',
                                '60% - 80%',
                                '80% - 100%'
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
                              value: widget.planta.temperatura,
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
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(images[index]!),
                            placeholder: AssetImage("assets/img/loading.jpg"),
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
              child: FadeInImage(
                height: 150,
                fit: BoxFit.cover,
                image: NetworkImage("${widget.planta.img!.split('name')[0]}"),
                placeholder: AssetImage("assets/img/loading.jpg"),
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
          imageFile = File(pickFileAux!.path);
          break;
        case 0:
          pickFile1 = pickFileAux;
          imagesFiles?[ops] = File(pickFileAux!.path);
          break;
        case 1:
          pickFile2 = pickFileAux;
          imagesFiles?[ops] = File(pickFileAux!.path);
          break;
        case 2:
          pickFile3 = pickFileAux;
          imagesFiles?[ops] = File(pickFileAux!.path);
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

            String? plantimg = widget.planta.img;
            String? plantimg1 = widget.planta.img1;
            String? plantimg2 = widget.planta.img2;
            String? plantimg3 = widget.planta.img3;

            if (pickFile != null) {
              TaskSnapshot snapshot = await subirArchivo(
                  pickFile!, -1, widget.planta.img!.split("name")[1]);
              String imageUrl = await snapshot.ref.getDownloadURL();
              plantimg =
                  imageUrl + 'name' + widget.planta.img!.split("name")[1];
            }
            if (pickFile1 != null) {
              print("---> ${widget.planta.img1}");
              TaskSnapshot snapshot = await subirArchivo(
                  pickFile1!, 0, widget.planta.img1!.split("name")[1]);
              String imageUrl = await snapshot.ref.getDownloadURL();
              plantimg1 =
                  imageUrl + 'name' + widget.planta.img1!.split("name")[1];
            }
            if (pickFile2 != null) {
              TaskSnapshot snapshot = await subirArchivo(
                  pickFile2!, 1, widget.planta.img2!.split("name")[1]);
              String imageUrl = await snapshot.ref.getDownloadURL();
              plantimg2 =
                  imageUrl + 'name' + widget.planta.img2!.split("name")[1];
            }
            if (pickFile3 != null) {
              TaskSnapshot snapshot = await subirArchivo(
                  pickFile3!, 2, widget.planta.img3!.split("name")[1]);
              String imageUrl = await snapshot.ref.getDownloadURL();
              plantimg3 =
                  imageUrl + 'name' + widget.planta.img3!.split("name")[1];
            }

            Plant model = Plant(
                img: plantimg,
                img1: plantimg1,
                img2: plantimg2,
                img3: plantimg3,
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
        .doc(widget.planta.id)
        .update(model.toJson())
        .then((value) => print('Se actualizo la planta'))
        .catchError((error) => print(error));
  }

  Future<TaskSnapshot> subirArchivo(
      PickedFile file, int ops, String nombre) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('plantas').child('/$nombre');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    UploadTask uploadTask = ref.putFile(File(file.path), metadata);
    return uploadTask;
  }
}
