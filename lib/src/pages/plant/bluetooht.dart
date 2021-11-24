import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:gardening/src/models/jardin.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:gardening/src/pages/plant/connection.dart';
import 'package:gardening/src/pages/plant/led.dart';
import 'package:gardening/src/pages/plant/plant_info_real_page.dart';

class BluetoothPage extends StatelessWidget {
  final Plant plant;
  final jardin garden;
  const BluetoothPage({required this.garden, required this.plant});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conexión',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          } else if (future.connectionState == ConnectionState.done) {
            // return MyHomePage(title: 'Flutter Demo Home Page');
            return Home(
              plant: plant,
              garden: garden,
            );
          } else {
            return Home(
              plant: plant,
              garden: garden,
            );
          }
        },
        // child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final Plant plant;
  final jardin garden;

  Home({required this.garden, required this.plant});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar un dispositivo'),
      ),
      body: SelectBondedDevicePage(
        onCahtPage: (device1) {
          BluetoothDevice device = device1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PlantInfoRealPage(
                  garden: garden,
                  plant: plant,
                  server: device,
                );
              },
            ),
          );
        },
      ),
    ));
  }
}
