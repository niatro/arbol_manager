import 'dart:convert';

import 'package:flutterapparbol/core/constants/server_prueba.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:meta/meta.dart';

abstract class ArbolesRemoteDataSource {
  /// Va al sector de pruebas y ejecuta un archivo mediante un método post
  ///   http://35.224.182.198 y si funciona obtiene [ArbolesEntityModelo] si no
  ///  Arroja una excepcion [ServiceException] para todos los errores
  ///  Finalmente en implementación debería ir a  http://35.225.91.186
  Future<ArbolesEntityModelo> getArbolesCercanosRemoteData(
      {LatLng coordenadas});

  // Esto esta mal porque no se necesita devolver una entidad de ListaDeArboles
  // Solo necesito que la operación se haya realizado correctamente
  Future<bool> grabarArbolesRemoteData(ArbolesEntityModelo arboles);
  Future<bool> verificarIdNFCRemoteData({String idNFC});
  Future<ArbolesEntityModelo> getArbolPorIdNFCRemoteData({String idNFC});

  // Este contrato no ha sido testeado pero me da la impresion que no deber
  //ia ser un UseCase, debería activarse a nivel de modelo cuando esta acce
  //diendo a una data específica

}

class ArbolesRemoteDataSourceImpl extends ArbolesRemoteDataSource {
  final http.Client client;
  ArbolesRemoteDataSourceImpl({@required this.client});
  final String _url = urlPruebas;

  @override
  Future<ArbolesEntityModelo> getArbolesCercanosRemoteData(
      {LatLng coordenadas}) async {
    final response = await client.post(
      _url + "/bd/getArbolPorCoordenadas.php",
      body: {
        "latitud": coordenadas.latitude.toString(),
        "longitud": coordenadas.longitude.toString(),
      },
    );
    return _getArbolesOrFailureDeAcuerdoToServerResponse(response);
  }

  @override
  Future<ArbolesEntityModelo> getArbolPorIdNFCRemoteData({String idNFC}) async {
    final response = await client.post(
      _url + "/bd/getArbolPorIdNFC.php",
      body: {
        "idNFC": idNFC,
      },
    );
    return _getArbolesOrFailureDeAcuerdoToServerResponse(response);
  }

  ArbolesEntityModelo _getArbolesOrFailureDeAcuerdoToServerResponse(
      http.Response response) {
    if (response.statusCode == 200) {
      final List<Map> jsonMaped =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      final ArbolesEntityModelo arbolesEntityModelo =
          ArbolesEntityModelo.fromJson(parsedListMapFromJson: jsonMaped);
      return arbolesEntityModelo;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> verificarIdNFCRemoteData({String idNFC}) async {
    // TODO: implement comprobarExistenciaIdNFC
    throw UnimplementedError();
  }

  @override
  Future<bool> grabarArbolesRemoteData(ArbolesEntityModelo arboles) {
    // TODO: implement grabarArbolesLevantadosOneByOne
    throw UnimplementedError();
  }
}

/*
class ServParaBaseDatosMySql {
  String direccion = "http://35.224.182.198/";

  Future<ArbolEntityModelo> getArbolFromArbolMaster(menor, mayor) async {
    try {
      final response =
      await http.post(direccion + "/bd/getArbolMaster.php", body: {
        "id_arbol_menor": menor.toString(),
        "id_arbol_mayor": mayor.toString(),
      });
      final result = json.decode(response.body);
      ListaDeArbolMasterMySql arbolMasterList =
      ListaDeArbolMasterMySql.fromJson(result);
      return arbolMasterList;
    } catch (e) {
      print('Error en el futuro del metodo getArbolFromArbolMasterMySql: ' +
          e.toString());
      return null;
    }
  }
}*/
