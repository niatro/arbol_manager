import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';

class LectorNfcPage extends StatefulWidget {
  @override
  _LectorNfcPageState createState() => _LectorNfcPageState();
}

class _LectorNfcPageState extends State<LectorNfcPage> {
  String _nfcStatus;
  String _nfcID;
  String _nfcContent;

  void leer() {
    setState(() {
      this._nfcStatus = 'Activo';
    });
  }

  Future<String> _leerIdNfc() async {
    final NfcData response = await FlutterNfcReader.read();
    if (response != null) {
      return response.id;
    } else {
      throw NfcException();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Lector NFC')),
          body: Container(
            child: RaisedButton(
              onPressed: () async {
                String respuesta = await _leerIdNfc();
                print(respuesta);
              },
              child: const Text(
                'LECTOR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              color: Colors.lightBlue,
            ),
          )),
    );
  }
}

// leerIdNfcUseCase = LeerIdNfcUseCase(repositorio);

//   FlutterNfcReader.read().then((onData) {
//     setState(() {
//       this._nfcID = onData.id;
//       this._nfcContent = onData.content;

//       ///el id indicar que el arbol ingresado ya existe y permitir desplegar su ficha.
//       _connMySql.ExisteIdChipNfcEnBD(idEscaneado: onData.id).then((onData) {
//         print('Valor onData es: $onData');
//         if (onData.length != 0) {
//           setState(() {
//             _existeChip = true;
//             showDialog(
//               context: context,
//               builder: (_) => AlertDialog(
//                 title: Text('ID Chip ya registrado'),
//                 content: Text('Prueba otro chip'),
//                 elevation: 24,
//               ),
//             );
//           });
//           print('Existe chip valor: $_existeChip');
//         }
//         if (onData.length == 0) {
//           setState(() {
//             _existeChip = false;
//           });
//           print('No existe chip valor: $_existeChip');
//         }
//       });
//       this._nfcStatus = 'Almacenado Chip ID ';
//     });
//   });
