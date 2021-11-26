import 'package:flutter/material.dart';
import 'package:gardening/src/helper/hex_color.dart';
import 'package:gardening/src/models/jardin.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:gardening/src/models/plantaSemana.dart';
// import 'package:gardening/src/pages/plant/plant_info_real_page.dart';
import 'package:gardening/src/providers/db_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'dart:typed_data';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class PlantInfoHistory extends StatefulWidget {
  final jardin garden;
  final Plant plant;
  const PlantInfoHistory({Key? key, required this.garden, required this.plant}) : super(key: key);

  @override
  _PlantInfoHistoryState createState() => _PlantInfoHistoryState();
}

Color color1 = HexColor("#59fb12");
Color color2 = HexColor("#4ed810");

class _PlantInfoHistoryState extends State<PlantInfoHistory> {
  double? height, width;
  late SqliteProvider _plantProvider;

  double? lunesTem, lunesHum;
  double? martesTemp, martesHum;
  double? miercolesTemp, miercolesHum;
  double? juevesTemp, juevesHum;
  double? viernesTemp, viernesHum;
  double? sabadoTemp, sabadoHum;
  double? domingoTemp, domingoHum;

  @override
  void initState() {
    print("Entro a init state.......................");
    WidgetsFlutterBinding.ensureInitialized();
    _initDB();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _plantProvider.close();
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

  _initDB() async {
    final path = await initDeleteDb('plantas.db');
    // print("patgh....");
    // print(path);
    _plantProvider = SqliteProvider();
    await _plantProvider.open2(path);
  }

  _buildBody() {
    return Container(
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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [color1, color1]),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            _getData();
                            setState(() {});
                          },
                          child: Text('Graficar datos >'),
                        ),
                      ],
                    ),
                    _buildTemperaturaHistory(title: 'Temperatura'),
                    _buildHumHistory(title: 'Humedad'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getData() async {
    PlantaSemanal? plantas = await _plantProvider.getPlantaSemanalByIdHistory(widget.garden.id!);
    if (plantas != null) {
      lunesTem = double.parse(plantas.lunes!.split("hum")[0].split("temp:")[1]);
      martesTemp = double.parse(plantas.martes!.split("hum")[0].split("temp:")[1]);
      miercolesTemp = double.parse(plantas.miercoles!.split("hum")[0].split("temp:")[1]);
      juevesTemp = double.parse(plantas.jueves!.split("hum")[0].split("temp:")[1]);
      viernesTemp = double.parse(plantas.viernes!.split("hum")[0].split("temp:")[1]);
      sabadoTemp = double.parse(plantas.sabado!.split("hum")[0].split("temp:")[1]);
      domingoTemp = double.parse(plantas.domingo!.split("hum")[0].split("temp:")[1]);

      lunesHum = double.parse(plantas.lunes!.split("hum")[1]);
      martesHum = double.parse(plantas.martes!.split("hum")[1]);
      miercolesHum = double.parse(plantas.miercoles!.split("hum")[1]);
      juevesHum = double.parse(plantas.jueves!.split("hum")[1]);
      viernesHum = double.parse(plantas.viernes!.split("hum")[1]);
      sabadoHum = double.parse(plantas.sabado!.split("hum")[1]);
      domingoHum = double.parse(plantas.domingo!.split("hum")[1]);

      setState(() {});

      print("Temperatura________");
      print("Lunes:" + lunesTem.toString());
      print("Martes:" + martesTemp.toString());
      print("Miercoles:" + miercolesTemp.toString());
      print("Jueves:" + juevesTemp.toString());
      print("Viernes:" + viernesTemp.toString());
      print("Sabado:" + sabadoTemp.toString());
      print("Domingo:" + domingoTemp.toString());
      print("Humedad________");
      print("Lunes:" + lunesHum.toString());
      print("Martes:" + martesHum.toString());
      print("Miercoles:" + miercolesHum.toString());
      print("Jueves:" + juevesHum.toString());
      print("Viernes:" + viernesHum.toString());
      print("Sabado:" + sabadoHum.toString());
      print("Domingo:" + domingoHum.toString());
    }
  }

  _buildTemperaturaHistory({required String title}) {
    return Center(
        child: Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Semana')),
        title: ChartTitle(text: '${title}'),
        legend: Legend(isVisible: false),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            dataSource: <SalesData>[
              SalesData('Lun', lunesTem != null ? lunesTem! : 0),
              SalesData('Mar', martesTemp != null ? martesTemp! : 0),
              SalesData('Mie', miercolesTemp != null ? miercolesTemp! : 0),
              SalesData('Jue', juevesTemp != null ? juevesTemp! : 0),
              SalesData('Vie', viernesTemp != null ? viernesTemp! : 0),
              SalesData('Sab', sabadoTemp != null ? sabadoTemp! : 0),
              SalesData('Dom', domingoTemp != null ? domingoTemp! : 0),
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            name: "Temperatura",
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    ));
  }

  _buildHumHistory({required String title}) {
    return Center(
        child: Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Semana')),
        title: ChartTitle(text: '${title}'),
        legend: Legend(isVisible: false),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            dataSource: <SalesData>[
              SalesData('Lun', lunesHum != null ? lunesHum! : 0),
              SalesData('Mar', martesHum != null ? martesHum! : 0),
              SalesData('Mie', miercolesHum != null ? miercolesHum! : 0),
              SalesData('Jue', juevesHum != null ? juevesHum! : 0),
              SalesData('Vie', viernesHum != null ? viernesHum! : 0),
              SalesData('Sab', sabadoHum != null ? sabadoHum! : 0),
              SalesData('Dom', domingoHum != null ? domingoHum! : 0),
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            name: "Humedad",
            // Enable data label
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

Future<String> initDeleteDb(String dbName) async {
  final databasePath = await getDatabasesPath();

  final path = Path.join(databasePath, dbName);

  return path;
}
