import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:gardening/src/models/jardin.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:gardening/src/models/plantaSemana.dart';
import 'package:gardening/src/pages/plant/plant_info_history.dart';
import 'package:gardening/src/pages/plantasAdmin/create.dart';
import 'package:gardening/src/painters/radial_painter.dart';
import 'package:flutter/material.dart';
import 'package:gardening/src/providers/db_provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gardening/src/helper/hex_color.dart';
import 'package:gardening/src/layout/back_layout.dart';

import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as Path;

import 'dart:typed_data';

import 'dart:math';

class PlantInfoRealPage extends StatefulWidget {
  static const String route = "/PlantInfoRealPage";
  final BluetoothDevice server;

  final Plant plant;
  final jardin garden;

  PlantInfoRealPage({required this.plant, required this.garden, required this.server});
  @override
  _PlantInfoRealPageState createState() => _PlantInfoRealPageState();
}

Color color1 = HexColor("#59fb12");
Color color2 = HexColor("#4ed810");
String? temp;
String? hum;
String? lluvia;
String? riego;

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _PlantInfoRealPageState extends State<PlantInfoRealPage> with SingleTickerProviderStateMixin {
  double? height, width;

  AnimationController? _animationController;
  Animation<double>? _progressAnimation;

  final Duration fillDuration = Duration(milliseconds: 500);

  double progressDegrees = 0;
  var count = 0;

  //Bluetooth
  static final clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = [];
  String _messageBuffer = '';
  bool isConnecting = true;
  bool get isConnected => connection != null && connection!.isConnected;

  bool isDisconnecting = false;

  CollectionReference jardin = FirebaseFirestore.instance.collection('MiJardin');

  //SQLite

  late SqliteProvider plantProvider;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: fillDuration);

    _progressAnimation = Tween(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeIn),
    );
    _animationController?.forward();

    WidgetsFlutterBinding.ensureInitialized();
    _initDB();

    //bluetooth
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection?.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Desconectando...')));
          print('desconectando');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Desconectado del dispositivo')));
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se puede conectar , favor de intentarlo en otro momento')));
      print(error);
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();

    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }
    plantProvider.close();
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
    // final List<Row> list = messages.map((_message) {
    //   return Row(
    //     children: <Widget>[
    //       Container(
    //         child: Text(
    //             (text) {
    //               // print(text == '/shrug' ? '¯\\_(ツ)_/¯' : text);
    //               temp = text;
    //               // print(text);
    //               return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
    //             }(_message.text.trim()),
    //             style: TextStyle(color: Colors.white)),
    //         padding: EdgeInsets.all(12.0),
    //         margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
    //         width: 222.0,
    //         decoration: BoxDecoration(
    //             color: _message.whom == clientID ? Colors.blueAccent : Colors.grey,
    //             borderRadius: BorderRadius.circular(7.0)),
    //       ),
    //     ],
    //     mainAxisAlignment:
    //         _message.whom == clientID ? MainAxisAlignment.end : MainAxisAlignment.start,
    //   );
    // }).toList();

    return BackLayout(
      size: Size(width!, height!),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [color1, color2]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.05 * height!),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 2.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      child: Center(
                        child: FadeInImage(
                          fit: BoxFit.fill,
                          image: NetworkImage("${widget.plant.img!.split('name')[0]}"),
                          placeholder: AssetImage("assets/img/loading.jpg"),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.plant.nomComm!,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              _buildDevicesRow(isConnecting),
              SizedBox(height: 0.1 * height!),
              _buildAnimatedBuilder(),
              SizedBox(height: 0.05 * height!),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("Más estadisticas"),
              ),
              Container(
                height: 0.25 * height!,
                child: ListView(
                  padding: EdgeInsets.all(15.0),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildUsageItem(
                        Icons.opacity, true, 'Humedad atmosferica', (hum == null) ? "..." : hum!),
                    _buildUsageItem(
                        Icons.cloud_queue, true, 'Luvia', (lluvia == null) ? "..." : lluvia!),
                    _buildUsageItem(
                        Icons.invert_colors, true, 'Riego', (riego == null) ? "..." : riego!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildUsageItem(IconData icon, bool isOn, String title, String measure) {
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
              isOn
                  ? Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.highlight_off_outlined,
                      color: Colors.red,
                    )
            ],
          ),
          // Spacer(),
          Text(
            '$title',
            style: TextStyle(color: isOn ? Colors.black : Colors.white),
          ),
          SizedBox(
            height: 15,
          ),

          Expanded(
            child: Center(
              child: Text(
                measure,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: isOn ? Colors.black : Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _initDB() async {
    final path = await initDeleteDb('plantas.db');
    // print("patgh....");
    // print(path);
    plantProvider = SqliteProvider();
    await plantProvider.open(path);
  }

  _buildDevicesRow(bool isconnecting) {
    return Row(
      children: [
        SizedBox(width: 15),
        Icon(Icons.wifi),
        SizedBox(width: 5),
        (isConnecting
            ? Text('Conectando ' + widget.server.name + '...')
            : isConnected
                ? Text('Conectado con ' + widget.server.name)
                : Text('Desconectado ' + widget.server.name)),
        Spacer(),
        Icon(Icons.pie_chart),
        SizedBox(width: 5),
        GestureDetector(
            child: Text("Historico"),
            onTap: () async {
              if (isConnected) {
                isDisconnecting = true;
                connection?.dispose();
                connection = null;
              }
              await plantProvider.close();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PlantInfoHistory(
                          garden: widget.garden,
                          plant: widget.plant,
                        )),
              );
            }),
        SizedBox(width: 15),
      ],
    );
  }

  _buildAnimatedBuilder() {
    return AnimatedBuilder(
      animation: _progressAnimation!,
      builder: (context, child) {
        return Center(
          child: CustomPaint(
            child: Container(
              height: 0.275 * height!,
              width: 0.275 * height!,
              decoration: BoxDecoration(
                color: Colors.white10,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(style: Theme.of(context).textTheme.bodyText1, children: [
                      TextSpan(text: temp, style: TextStyle(color: Colors.black, fontSize: 40)),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(2, -20),
                          child: Text(
                            '°C',
                            //superscript is usually smaller in size
                            textScaleFactor: 0.7,

                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            painter: RadialPainter(_progressAnimation!.value * 360.0),
          ),
        );
      },
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        String datos = backspacesCounter > 0
            ? _messageBuffer.substring(0, _messageBuffer.length - backspacesCounter)
            : _messageBuffer + dataString.substring(0, index);
        //Obtener datos de temperatura:
        // print(datos.toString());
        temp =
            datos.split("%")[1].trim().split("Sens")[0].trim().split(":")[1].trim().substring(0, 5);
        hum = datos.split("Humedad:")[1].trimLeft().substring(0, 7);
        lluvia =
            datos.contains("Lluvia") ? datos.split("Lluvia: ")[1].trim().split("Hum")[0] : "...";
        riego =
            datos.contains("Riego") ? datos.split("Riego: ")[1].trim().split("Lluvia")[0] : "...";
        // print(widget.garden.id);
        // todo
        _fillDatabse();

        jardin
            .doc(widget.garden.id)
            .update({'temperatura': temp, 'lluvia': lluvia, 'humedadA': hum, 'humedadS': riego})
            .then((value) => print("Datos firebase Updated"))
            .catchError((error) => print("Failed to update plant: $error"));
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  _fillDatabse() async {
    PlantaSemanal? getPlanta = await plantProvider.getPlantaSemanalById(widget.garden.id!);

    if (getPlanta == null) {
      // Insertar nuevo registro

      PlantaSemanal plantaSem = PlantaSemanal();
      plantaSem.plantaId = widget.garden.id;
      plantaSem.plantaLunes = "temp:" + "0" + "hum" + "0";
      plantaSem.plantaMartes = "temp:" + "0" + "hum" + "0";
      plantaSem.plantaMiercoles = "temp:" + "0" + "hum" + "0";
      plantaSem.plantaJueves = "temp:" + "0" + "hum" + "0";
      plantaSem.plantaViernes = "temp:" + "0" + "hum" + "0";
      plantaSem.plantaSabado = "temp:" + "0" + "hum" + "0";
      plantaSem.plantaDomingo = "temp:" + "0" + "hum" + "0";

      plantaSem = await plantProvider.insert(plantaSem);
      // print("Lunesssss-----" + plantaSem.lunes!);
      // print("Lunesssss-----");
    } else {
      // await plantProvider.delete(getPlanta.id!);
      var now = DateTime.now();
      String? datosDB;

      print(getPlanta.lunes! + "diaa----lunes");
      print(getPlanta.martes! + "diaa----martes");
      print(getPlanta.miercoles! + "diaa----miercoles");
      print(getPlanta.jueves! + "diaa----jueves");
      print(getPlanta.viernes! + "diaa----viernes");
      print(getPlanta.sabado! + "diaa----sabado");

      switch (now.weekday) {
        case 0:
          print("Es lunes");
          break;
        case 1:
          datosDB = getPlanta.lunes;
          break;
        case 2:
          datosDB = getPlanta.martes;
          break;
        case 3:
          datosDB = getPlanta.miercoles;
          break;
        case 4:
          datosDB = getPlanta.jueves;
          break;
        case 5:
          datosDB = getPlanta.viernes;
          break;
        case 6:
          datosDB = getPlanta.sabado;
          break;
        case 7:
          datosDB = getPlanta.domingo;
          break;
      }
      String? datosReal = "temp:" + temp! + "hum" + hum!.trim().split("%")[0];

      double tempReal = double.parse(datosReal.split("hum")[0].split("temp:")[1]);
      double tempBD = double.parse(datosDB!.split("hum")[0].split("temp:")[1]);
      // print(datosReal + "Datos real");
      double humReal = double.parse(datosReal.split("hum")[1].trim());
      double humBD = double.parse(datosDB.split("hum")[1].trim());

      if ((tempReal > tempBD) || (humReal > humBD)) {
        String stringUpdate = "";
        if (tempReal > tempBD) {
          if (humReal > humBD) {
            //La temperatura y la humedad se actualizan
            stringUpdate = "temp:" + tempReal.toString() + "hum" + humReal.toString();
          } else {
            //Solo se actualiza la temperatura
            stringUpdate = "temp:" + tempReal.toString() + "hum" + humBD.toString();
          }
        } else if (humReal > humBD) {
          //solo se actualiza la humedad
          stringUpdate = "temp:" + tempBD.toString() + "hum" + humReal.toString();
        }

        // "temp:" + "0" + "hum" + "0"

        //Actualizar temperatura

        // print(stringUpdate + "-----------------------Toupdate -------------------");
        PlantaSemanal plantaToUpdate = PlantaSemanal();
        plantaToUpdate.detId = getPlanta.id!;
        plantaToUpdate.plantaId = getPlanta.idPlanta;
        switch (now.weekday) {
          case 1:
            plantaToUpdate.plantaLunes = stringUpdate;
            plantaToUpdate.plantaMartes = getPlanta.martes;
            plantaToUpdate.plantaMiercoles = getPlanta.miercoles;
            plantaToUpdate.plantaJueves = getPlanta.jueves;
            plantaToUpdate.plantaViernes = getPlanta.viernes;
            plantaToUpdate.plantaSabado = getPlanta.sabado;
            plantaToUpdate.plantaDomingo = getPlanta.domingo;
            break;
          case 2:
            plantaToUpdate.plantaLunes = getPlanta.lunes;
            plantaToUpdate.plantaMartes = stringUpdate;
            plantaToUpdate.plantaMiercoles = getPlanta.miercoles;
            plantaToUpdate.plantaJueves = getPlanta.jueves;
            plantaToUpdate.plantaViernes = getPlanta.viernes;
            plantaToUpdate.plantaSabado = getPlanta.sabado;
            plantaToUpdate.plantaDomingo = getPlanta.domingo;
            break;
          case 3:
            plantaToUpdate.plantaLunes = getPlanta.lunes;
            plantaToUpdate.plantaMartes = getPlanta.martes;
            plantaToUpdate.plantaMiercoles = stringUpdate;
            plantaToUpdate.plantaJueves = getPlanta.jueves;
            plantaToUpdate.plantaViernes = getPlanta.viernes;
            plantaToUpdate.plantaSabado = getPlanta.sabado;
            plantaToUpdate.plantaDomingo = getPlanta.domingo;

            break;
          case 4:
            plantaToUpdate.plantaLunes = getPlanta.lunes;
            plantaToUpdate.plantaMartes = getPlanta.martes;
            plantaToUpdate.plantaMiercoles = getPlanta.miercoles;
            plantaToUpdate.plantaJueves = stringUpdate;
            plantaToUpdate.plantaViernes = getPlanta.viernes;
            plantaToUpdate.plantaSabado = getPlanta.sabado;
            plantaToUpdate.plantaDomingo = getPlanta.domingo;
            break;
          case 5:
            plantaToUpdate.plantaLunes = getPlanta.lunes;
            plantaToUpdate.plantaMartes = getPlanta.martes;
            plantaToUpdate.plantaMiercoles = getPlanta.miercoles;
            plantaToUpdate.plantaJueves = getPlanta.jueves;
            plantaToUpdate.plantaViernes = stringUpdate;
            plantaToUpdate.plantaSabado = getPlanta.sabado;
            plantaToUpdate.plantaDomingo = getPlanta.domingo;
            break;
          case 6:
            plantaToUpdate.plantaLunes = getPlanta.lunes;
            plantaToUpdate.plantaMartes = getPlanta.martes;
            plantaToUpdate.plantaMiercoles = getPlanta.miercoles;
            plantaToUpdate.plantaJueves = getPlanta.jueves;
            plantaToUpdate.plantaViernes = getPlanta.viernes;
            plantaToUpdate.plantaSabado = stringUpdate;
            plantaToUpdate.plantaDomingo = getPlanta.domingo;
            break;
          case 7:
            plantaToUpdate.plantaLunes = getPlanta.lunes;
            plantaToUpdate.plantaMartes = getPlanta.martes;
            plantaToUpdate.plantaMiercoles = getPlanta.miercoles;
            plantaToUpdate.plantaJueves = getPlanta.jueves;
            plantaToUpdate.plantaViernes = getPlanta.viernes;
            plantaToUpdate.plantaSabado = getPlanta.sabado;
            plantaToUpdate.plantaDomingo = stringUpdate;
            break;
        }

        await plantProvider.update(plantaToUpdate);
      }
    }

    // await plantProvider.deleteDB(1);
  }
}

/// delete the db, create the folder and returnes its path
Future<String> initDeleteDb(String dbName) async {
  final databasePath = await getDatabasesPath();
  // print(databasePath);
  final path = Path.join(databasePath, dbName);

  // make sure the folder exists
  // ignore: avoid_slow_async_io
  // if (await Directory(Path.dirname(path)).exists()) {
  //   await deleteDatabase(path);
  // } else {
  //   try {
  //     await Directory(Path.dirname(path)).create(recursive: true);
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e);
  //   }
  // }
  return path;
}
