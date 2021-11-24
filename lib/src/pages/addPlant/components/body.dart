import 'package:flutter/material.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/rendering.dart';
import 'package:gardening/src/models/jardin.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardening/src/providers/user_provider.dart';

class addPlant extends StatefulWidget {
  final Plant plant;
  addPlant(this.plant);

  @override
  _addPlantState createState() => _addPlantState(plant);
}

class _addPlantState extends State<addPlant> {
  final Plant plant;
  _addPlantState(this.plant);
  late CollectionReference _ref;
  late FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    this.localizacion();

    _ref = FirebaseFirestore.instance.collection('MiJardin');
  }

  Location _location = Location();
  late LocationData _locationData;
  String? latitud;
  String? longitud;
  Position? posicion;
  Completer<GoogleMapController> mapController = new Completer();

  Widget mapa() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(0, 0),
      ),
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) =>
          mapController.complete(controller),
    );
  }

  localizacion() async {
    posicion = await Geolocator.getCurrentPosition();
    GoogleMapController controller = await mapController.future;
    if (controller != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(posicion!.latitude, posicion!.longitude), zoom: 8.0)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
            child: FadeInImage(
              fit: BoxFit.cover,
              image: NetworkImage("${plant.img!.split('name')[0]}"),
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
                    child: Container(
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
                                  '${plant.nomComm}',
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
                                              onPressed: () async {
                                                //validacio

                                                jardin model;

                                                _location
                                                    .getLocation()
                                                    .then((value) async {
                                                  _locationData = value;
                                                  latitud = _locationData
                                                      .latitude
                                                      .toString();
                                                  longitud = _locationData
                                                      .longitude
                                                      .toString();

                                                  model = jardin(
                                                    idPlanta: plant.id,
                                                    idUsuario: _firebaseAuth
                                                        .currentUser!.uid,
                                                    latitud: latitud,
                                                    longitud: longitud,
                                                  );
                                                  await saveList(model);
                                                }).then((value) => value);
                                              },
                                              icon: Icon(Icons.add,
                                                  color: Colors.green)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
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
                                Expanded(
                                  child: Text(
                                    '${plant.genero}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
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
                                  'Nombre botánico:',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(width: size.width * 0.04),
                                Expanded(
                                  child: Text(
                                    '${plant.nomBot}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
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
                                  'Nombre común:',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(width: size.width * 0.07),
                                Expanded(
                                  child: Text(
                                    '${plant.nomComm}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Text(
                                  'Galería de fotos',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            _swiper(plant),
                            SizedBox(height: 20),
                            Container(
                              height: 0.22 * size.height,
                              child: ListView(
                                padding: EdgeInsets.all(15.0),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _buildUsageItem(Icons.opacity, 'Riego',
                                      size.width, plant.riego!),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  _buildUsageItem(Icons.wb_sunny_outlined,
                                      ' Sol', size.width, plant.sol!),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  _buildUsageItem(Icons.water, 'Humedad',
                                      size.width, plant.humedad!),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  _buildUsageItem(
                                      Icons.thermostat,
                                      'Temperatura',
                                      size.width,
                                      plant.temperatura!),
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
                                    alignment: Alignment.center,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future? saveList(jardin model) {
    return _ref
        .add(model.toJson())
        .then((value) => Navigator.pushNamedAndRemoveUntil(
            context, 'home', (route) => false))
        .catchError((error) => print(error));
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

List<String> images = [
  "assets/img/plumaRosa.jpg",
  "assets/img/crasas.jpg",
  "assets/img/violetaAfricana.jpg"
];
Widget _swiper(Plant plant) {
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
            image: NetworkImage("${plant.img!.split('name')[0]}"),
            placeholder: AssetImage("assets/img/loading.jpg"),
          ),
        );
      },
      itemCount: images.length,
      /*pagination: new SwiperPagination(),
      control: new SwiperControl(),*/
    ),
  );
}

_buildUsageItem(IconData icon, String title, double w, String data) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: Expanded(
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
              "${data}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.green),
            ),
          ],
        ),
      ),
    ),
  );
}
