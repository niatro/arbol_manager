import 'dart:convert';

import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/idnfc_entity.dart';

import '../models/arboles_entity_modelo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class ArbolesLocalDataSource {
  /// Va al cache  del dispositivo para obtener [ArbolesEntityModelo] si no
  ///  lo consigue arroja una excepción [CacheExeption] para todos los errores
  Future<ArbolesEntityModelo> getCacheArboles();

  Future<void> cacheArbolesEntityModelo(ArbolesEntityModelo arbolesToCache);
  Future<IdNFCEntity> getIdNFC();
}

const CACHED_ARBOLES_ENTITY_MODEL = 'CACHED_ARBOLES_ENTITY_MODEL';

class ArbolesLocalDataSourceImpl implements ArbolesLocalDataSource {
  final SharedPreferences sharedPreferences;

  ArbolesLocalDataSourceImpl({@required this.sharedPreferences});
  @override
  Future<ArbolesEntityModelo> getCacheArboles() {
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
  Future<void> cacheArbolesEntityModelo(ArbolesEntityModelo arbolesToCache) {
    final stringArboles = arbolesToCache.toJsonFromArbolesEntityModelo();

    return sharedPreferences.setString(
        CACHED_ARBOLES_ENTITY_MODEL, json.encode(stringArboles));
  }

  @override
  Future<IdNFCEntity> getIdNFC() {
    // TODO: implement getIdNFC
    throw UnimplementedError();
  }
}
