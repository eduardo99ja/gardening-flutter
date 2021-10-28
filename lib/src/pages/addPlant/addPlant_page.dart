import 'package:flutter/material.dart';
import 'package:gardening/src/pages/addPlant/components/body.dart';

class addPlantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: addPlant(),
    );
  }
}
