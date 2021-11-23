import 'package:flutter/material.dart';
import 'package:gardening/src/helper/hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class PlantInfoHistory extends StatefulWidget {
  const PlantInfoHistory({Key? key}) : super(key: key);

  @override
  _PlantInfoHistoryState createState() => _PlantInfoHistoryState();
}

Color color1 = HexColor("#59fb12");
Color color2 = HexColor("#4ed810");

class _PlantInfoHistoryState extends State<PlantInfoHistory> {
  double? height, width;

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
                  Center(
                    child: Image.network(
                      'https://www.florespedia.com/Imagenes/petunias-2.jpg',
                      width: 200,
                      height: 150,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Petunia",
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
                    _buildTemperaturaHistory(title: 'Humedad del suelo'),
                    _buildTemperaturaHistory(title: 'Humedad del ambiente'),
                    _buildTemperaturaHistory(title: 'Temperatura '),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
              SalesData('Lun', 35),
              SalesData('Mar', 28),
              SalesData('Mie', 34),
              SalesData('Jue', 32),
              SalesData('Vie', 40),
              SalesData('Sab', 40),
              SalesData('Dom', 40),
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
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
