import 'package:flutter/material.dart';
import 'package:gardening/src/models/jardin.dart';
import 'package:gardening/src/models/plant.dart';
import 'package:gardening/src/pages/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Plant plant;
  final jardin garden;

  const DetailsScreen({required this.plant, required this.garden});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Details(
        plant: plant,
        garden: garden,
      ),
    );
  }
}
