import 'dart:convert';

import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';

import '../models/arboles_entity_modelo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';

abstract class ArbolesLocalDataSource {
  /// Va al cache  del dispositivo para obtener [ArbolesEntityModelo] si no
  ///  lo consigue arroja una excepción [CacheExeption] para todos los errores
  Future<ArbolesEntityModelo> getCacheArbolesLocalData();

  Future<void> cacheArbEntDeArbEntModLocalData(
      ArbolesEntityModelo arbolesToCache);
  Future<String> leerIdNFCLocalData({String idUsuario});
  Future<Position> getCoordenadasLocalData();
}

const CACHED_ARBOLES_ENTITY_MODEL = 'CACHED_ARBOLES_ENTITY_MODEL';

//OJO: Implementacion abajo 👀
class ArbolesLocalDataSourceImpl implements ArbolesLocalDataSource {
  final SharedPreferences sharedPreferences;

  ArbolesLocalDataSourceImpl({
    @required this.sharedPreferences,
  });

  @override
  Future<String> leerIdNFCLocalData({String idUsuario}) async {
    final NfcData response = await FlutterNfcReader.read();
    if (response != null) {
      return response.id;
    } else {
      throw NfcException();
    }
  }

  @override
  Future<ArbolesEntityModelo> getCacheArbolesLocalData() {
    final jsonString = sharedPreferences.getString(CACHED_ARBOLES_ENTITY_MODEL);
    // Pero el valor de arriba no es futuro asi que tenemos que convertirlo
    // TODO: Deberia implementar un try catch en caso que no se pueda convertir
    if (jsonString != null) {
      return Future.value(ArbolesEntityModelo.fromJson(
          parsedListMapFromJson:
              List<Map<String, dynamic>>.from(json.decode(jsonString))));
    } else {
      throw CacheException();
    }

    // El cache da un valor inmediato pero necesitamos un futuro, usamos el
    // método Future.value()
  }

  @override
  Future<void> cacheArbEntDeArbEntModLocalData(
      ArbolesEntityModelo arbolesToCache) {
    final stringArboles = arbolesToCache.toMapFromArbolesEntityModelo();

    return sharedPreferences.setString(
        CACHED_ARBOLES_ENTITY_MODEL, json.encode(stringArboles));
  }

  @override
  Future<Position> getCoordenadasLocalData() async {
    bool locationEnable = await isLocationServiceEnabled();
    if (locationEnable == true) {
      Position position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    } else {
      throw LocationException();
    }
  }
}
