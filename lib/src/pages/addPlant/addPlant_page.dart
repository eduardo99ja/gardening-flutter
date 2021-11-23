import 'package:flutter/material.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:gardening/src/pages/addPlant/components/body.dart';

class addPlantScreen extends StatelessWidget {
  final Plant plant;
  
  addPlantScreen(this.plant);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: addPlant(plant),
    );
  }
}
