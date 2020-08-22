import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ArbolModulosPrueba extends StatefulWidget {
  @override
  _ArbolModulosPruebaState createState() => _ArbolModulosPruebaState();
}

void _getCurrentLocation() async {
  final position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position);
}

class _ArbolModulosPruebaState extends State<ArbolModulosPrueba> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moulos test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Servicios de testing'),
        ),
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(""),
              FlatButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                color: Colors.green,
                child: Text('Conseguir Coordenadas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
