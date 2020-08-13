import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

import 'features/arbol/data/repositories/arboles_repositorio_impl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ArbolesRepositorioImpl repositorio;
  // This widget is the root of your application.
//  Future<NDEFMessage> lectura() async {
//    return await NFC.readNDEF(once: true).first;
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            FlutterNfcReader.read().then((response) {
              print(response.id);
            });
//            NDEFMessage _mensaje = await lectura();
//            print(_mensaje.id);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('NFC funcionalidad'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Data del NFC'),
            ],
          ),
        ),
      ),
    );
  }
}
