import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:gardening/src/models/jardin.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:gardening/src/pages/plantasAdmin/create.dart';
import 'package:gardening/src/painters/radial_painter.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gardening/src/helper/hex_color.dart';
import 'package:gardening/src/layout/back_layout.dart';

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: fillDuration);

    _progressAnimation = Tween(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeIn),
    );
    _animationController?.forward();

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
        Text("Historico"),
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
        print(datos.toString());
        temp =
            datos.split("%")[1].trim().split("Sens")[0].trim().split(":")[1].trim().substring(0, 5);
        hum = datos.split("Humedad:")[1].trimLeft().substring(0, 7);
        lluvia =
            datos.contains("Lluvia") ? datos.split("Lluvia: ")[1].trim().split("Hum")[0] : "...";
        riego =
            datos.contains("Riego") ? datos.split("Riego: ")[1].trim().split("Lluvia")[0] : "...";
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }
}
