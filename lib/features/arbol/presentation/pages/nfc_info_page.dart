import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/application/nfc/nfc_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class NfcInfo extends StatelessWidget {
  final NfcEntity nfcEntity;
  final NfcState state;
  const NfcInfo({
    @required this.nfcEntity,
    @required this.state,
    Key key,
  }) : super(key: key);

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
              title: Text('Datos NFC')),
          body: Container(
            child: Column(
              children: [
                Text(nfcEntity.idNfc),
                RaisedButton(
                  onPressed: () {},
                  child: const Text(
                    'VERIFICAR CHIP NUEVO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  color: Colors.lightBlue,
                ),
              ],
            ),
          )),
    );
  }
}
