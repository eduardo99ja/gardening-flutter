import 'package:flutter/material.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:gardening/src/pages/plantasAdmin/components/view_plantBody.dart';

class viewPlantScreen extends StatelessWidget {
  final Plant plant;
  viewPlantScreen(this.plant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: viewPlant(plant),
    );
  }
}
