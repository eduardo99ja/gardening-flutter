import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gardening/src/helper/hex_color.dart';
import 'package:gardening/src/layout/back_layout.dart';
import 'package:gardening/src/models/jardin.dart';
import 'package:gardening/src/models/user.dart';
import 'package:gardening/src/pages/account/changePassword.dart';
import 'package:gardening/src/pages/login/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardening/src/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'package:ndialog/ndialog.dart';

class AccountUserPage extends StatefulWidget {
  const AccountUserPage({Key? key}) : super(key: key);

  @override
  _AccountUserPageState createState() => _AccountUserPageState();
}

Color color1 = HexColor("#59fb12");
Color color2 = HexColor("#4ed810");

PickedFile? pickFile;
File? imageFile;
String? nombreImg;

class _AccountUserPageState extends State<AccountUserPage> {
  double? height, width;
  final _dbRef = FirebaseFirestore.instance;
  List<User>? user;
  StreamSubscription<QuerySnapshot>? addUser;
  late AuthProvider _authProvider;

  List<jardin>? LJardin;
  StreamSubscription<QuerySnapshot>? addjardin;

  @override
  void initState() {
    super.initState();

    _authProvider = new AuthProvider();

    user = [];
    print(_authProvider.getUser().uid);
    addUser = _dbRef
        .collection('Users')
        .where("id", isEqualTo: _authProvider.getUser().uid)
        .snapshots()
        .listen(agregarUsuario);

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
    addUser!.cancel();
    addjardin!.cancel();
    addjardin!.pause();
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      width = constraints.maxWidth;
      height = constraints.maxHeight;
      return Theme(
        data: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Mi cuenta",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 0.275 * height!,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  HexColor("#59fb12"),
                                  HexColor("#4ed810"),
                                  // HexColor("#d1cdca")
                                  Colors.white10,
                                  HexColor("#4ed810"),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3.0, 3.0),
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 4.0,
                                ),
                              ]),
                          height: 0.175 * height!,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => showAlert(),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: (user![0].image == null)
                                    ? NetworkImage(
                                        "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80")
                                    : NetworkImage(
                                        user![0].image!.split("name")[0]),
                              ),
                            ),
                            Text(
                                "${user!.length != 0 ? "${user![0].name}" "${user![0].lastname}" : ""}"),
                            Text(
                              "@${user!.length != 0 ? user![0].username : ""}",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Detalles de la cuenta",
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ),
              Divider(),
              _buildItem(
                "Email",
                "${user!.length != 0 ? user![0].email : ""}",
                Icons.email,
                HexColor("#75abb5"),
              ),
              SizedBox(height: 10),
              _buildItem(
                "Cambiar contrase??a",
                "",
                Icons.lock,
                HexColor("#927ae4"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Detalles de la aplicaci??n",
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ),
              Divider(),
              _buildItem(
                "No. de plantas",
                "${LJardin!.length}",
                Icons.format_list_numbered_rounded,
                HexColor("#c77099"),
              ),
              Divider(),
            ],
          ),
        ),
      );
    });
  }

  _buildItem(String text, String text2, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: GestureDetector(
        onTap: () async {
          if (text.contains("Cambiar")) {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return ChangePasswordPage();
                });
          }
        },
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 10),
            Text(text),
            Spacer(),
            Text(
              text2,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Icon(
              Icons.arrow_right_sharp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  agregarUsuario(QuerySnapshot evento) {
    user = [];
    evento.docs.forEach((element) {
      setState(() {
        user!.add(new User.fromElement(element));
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
  }

  void showAlert() {
//[cameraButton, galleryButton],
    AlertDialog alerta = AlertDialog(
      title: Text('??Desde donde subir imagen?'),
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
                    onPressed: () => seleccionarImagen(ImageSource.gallery),
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
                    onPressed: () => seleccionarImagen(ImageSource.camera),
                    child: const Text('C??mara',
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

  Future seleccionarImagen(ImageSource imgSrc) async {
    pickFile = await ImagePicker().getImage(source: imgSrc);
    imageFile = File(pickFile!.path);

    Navigator.of(context).pop();

    TaskSnapshot snapshot = await subirArchivo(pickFile!);
    String imageUrl = await snapshot.ref.getDownloadURL();

    String? docId;
    CollectionReference userData = _dbRef.collection('Users');
    await userData
        .where("id", isEqualTo: _authProvider.getUser().uid)
        .get()
        .then((QuerySnapshot query) {
      query.docs.forEach((element) {
        docId = element.reference.id;
      });
    });

    print(docId);
    await userData
        .doc(docId)
        .update({"image": imageUrl + "name" + nombreImg!})
        .then((value) => print("Datos firebase Updated"))
        .catchError((error) => print("Failed to update user: $error"));

    setState(() {});
  }

  Future<TaskSnapshot> subirArchivo(PickedFile file) async {
    nombreImg = (user![0].image == null)
        ? '${UniqueKey().toString()}.jpg'
        : user![0].image!.split("name")[1];

    Reference ref =
        FirebaseStorage.instance.ref().child('usuarios').child('/$nombreImg');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    UploadTask uploadTask = ref.putFile(File(file.path), metadata);
    return uploadTask;
  }
}
