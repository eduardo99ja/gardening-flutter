import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gardening/src/models/jardin.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:flutter/rendering.dart';
import 'package:gardening/src/pages/plant/bluetooht.dart';
import 'package:gardening/src/pages/plant/plant_info_real_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Details extends StatefulWidget {
  final Plant plant;
  final jardin garden;
  const Details({required this.plant, required this.garden});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _dbRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
            child: FadeInImage(
              fit: BoxFit.cover,
              image: NetworkImage("${widget.plant.img!.split('name')[0]}"),
              placeholder: AssetImage("assets/img/loading.jpg"),
            ),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration()),
        CustomScrollView(
          anchor: 0.4,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.plant.nomComm!,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              padding: new EdgeInsets.all(0.0),
                                              onPressed: () => {_openModal()},
                                              icon: Icon(
                                                  Icons.restore_from_trash,
                                                  color: Colors.green)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              padding: new EdgeInsets.all(0.0),
                                              onPressed: () {
                                                _showDialog(
                                                    context, widget.garden);
                                              },
                                              icon: Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.green)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              padding: new EdgeInsets.all(0.0),
                                              onPressed: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          BluetoothPage(
                                                            plant: widget.plant,
                                                            garden:
                                                                widget.garden,
                                                          ))),
                                              icon: Icon(Icons.bar_chart,
                                                  color: Colors.green)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Genero:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(width: size.width * 0.2),
                              Text(
                                widget.plant.genero!,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Nombre bot??nico:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(width: size.width * 0.04),
                              Text(
                                widget.plant.nomBot!,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Nombre com??n:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(width: size.width * 0.07),
                              Text(
                                widget.plant.nomComm!,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: [
                              Text(
                                'Galer??a de fotos',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          _swiper(
                              img1: widget.plant.img1!,
                              img2: widget.plant.img2!,
                              img3: widget.plant.img3!),
                          SizedBox(height: 20),
                          Container(
                            height: 0.22 * size.height,
                            child: ListView(
                              padding: EdgeInsets.all(15.0),
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildUsageItem(Icons.opacity, 'Riego',
                                    size.width, widget.plant.riego!),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                _buildUsageItem(Icons.wb_sunny_outlined, ' Sol',
                                    size.width, widget.plant.sol!),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                _buildUsageItem(Icons.water, 'Humedad',
                                    size.width, widget.plant.humedad!),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                _buildUsageItem(Icons.thermostat, 'Temperatura',
                                    size.width, widget.plant.temperatura!),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
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
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.green,
                                      child: IconButton(
                                          padding: new EdgeInsets.all(0.0),
                                          onPressed: () => print("button"),
                                          icon: Icon(MdiIcons.flower),
                                          color: Colors.white)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _openModal() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "??Esta seguro de borrar?",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "${widget.plant.nomComm}",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FadeInImage(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage("${widget.plant.img!.split('name')[0]}"),
                    placeholder: AssetImage("assets/img/loading.jpg"),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _dbRef
                              .collection('MiJardin')
                              .doc(widget.garden.id)
                              .delete()
                              .then((value) =>
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, 'home', (route) => false));
                        },
                        child: Text(
                          "Borrar",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });

  }

  void _showDialog(BuildContext context, jardin garden) {
    Size size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: size.width,
            padding: new EdgeInsets.all(0.0),
            child: Expanded(
              child: Stack(
                children: [
                  mapaView(),
                  Container(
                    child: Icon(Icons.location_on_outlined),
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
            height: 200.0,
          ),
        );
      },
    );
  }

  Widget mapaView() {
    print(widget.garden.latitud!);
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(double.parse(widget.garden.latitud!),
            double.parse(widget.garden.longitud!)),
        zoom: 10.0,
      ),
      mapType: MapType.normal,
    );
  }
}

class SliverWidget extends SingleChildRenderObjectWidget {
  SliverWidget({Widget? child, Key? key}) : super(child: child, key: key);
  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return RenderSliverWidget();
  }
}

class RenderSliverWidget extends RenderSliverToBoxAdapter {
  RenderSliverWidget({
    RenderBox? child,
  }) : super(child: child);

  @override
  void performResize() {}

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    child!.layout(
        constraints.asBoxConstraints(/* crossAxisExtent: double.infinity */),
        parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }
    assert(childExtent != null);
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: 100,
      paintOrigin: constraints.scrollOffset,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
    );
    setChildParentData(child!, constraints, geometry!);
  }
}

Widget _swiper(
    {required String img1, required String img2, required String img3}) {
  List<String> images = [img1, img2, img3];
  return Container(
    width: double.infinity,
    height: 180.0,
    child: Swiper(
      viewportFraction: 0.6,
      scale: 0.6,
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: new FadeInImage(
            fit: BoxFit.cover,
            image: NetworkImage(images[index].split("name")[0]),
            placeholder: AssetImage("assets/img/loading.jpg"),
          ),
        );
      },
      itemCount: 3,
      /*pagination: new SwiperPagination(),
      control: new SwiperControl(),*/
    ),
  );
}

_buildUsageItem(IconData icon, String title, double w, String medida) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: Container(
      width: 0.24 * w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: EdgeInsets.all(0.025 * w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50.0,
                color: Colors.green,
              ),
            ],
          ),
          Spacer(),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(2.0), // here is it
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: double.infinity,
              height: 20,
              child: Text(
                '$title',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green[900], fontSize: 12),
              ),
            ),
          ),
          Spacer(),
          Text(
            medida,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.green),
          ),
        ],
      ),
    ),
  );
}
