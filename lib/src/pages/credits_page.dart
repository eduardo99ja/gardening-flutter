import 'package:gardening/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: MyColors.primaryColorDark,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gómez Garcia Alex',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Jimenez Apodaca Eduardo',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Serrano Vences Carlos Jesús',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'v1.0.0',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                color: Colors.white70,
                fontSize: 20.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.teal.shade100,
              ),
            ),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.book,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'Programacion Avanzada de Aplicaciones Móviles',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                )),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.teal,
                ),
                title: Text(
                  'Profesora:\nRocio Elizabeth Pulido Alba',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.teal.shade900, fontFamily: 'Source Sans Pro'),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.school,
                  color: Colors.teal,
                ),
                title: Text(
                  'Instituto Técnologico de Toluca',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.teal.shade900, fontFamily: 'Source Sans Pro'),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
