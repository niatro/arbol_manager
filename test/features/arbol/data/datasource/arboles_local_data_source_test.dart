import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_local_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../../lib/core/constants/lista_de_arboles_test.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  ArbolesLocalDataSourceImpl localDataSource;
  MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        ArbolesLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  group('Testea que arboles se puedan guardar en cache y que se puedan leer',
      () {
    final List<Map> jsonMaped = List<Map<String, dynamic>>.from(
        json.decode(fixture('arboles_cached.json')));
    // Hay que poner atención con el método List<>.from, este es el que me pasa
    // a listados
    final tArbolesEntityModel =
        ArbolesEntityModelo.fromJson(parsedListMapFromJson: jsonMaped);
    test(
        'DEBE retornar ArbolEntityModelo de sharedPreferences CUANDO hay un json en el cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('arboles_cached.json'));
      // act
      final result = await localDataSource.getCacheArboles();
      // assert
      verify(mockSharedPreferences.getString(CACHED_ARBOLES_ENTITY_MODEL));
      expect(result, equals(tArbolesEntityModel));
    });

    test('DEBE retornar una CacheExpetion cuando no hay nada ahi', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // esto finalmente me sirve para saber si un objeto contiene cierta info
      // act
      final call = localDataSource.getCacheArboles;
      // interesante porque almacenamos el método adentro de una variable

      // assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      //throwsA es lo que sale de un método y call es el resultado de un métodp
    });
  });
  group('Cache data', () {
    final ArbolesEntityModelo tArbolesEntityModelo =
        ArbolesEntityModelo(listaArbolesEntity: [arbolUno, arbolDos]);
    test('DEBERÍA llamar SharedPreferences para pasar información', () async {
      // arrange

      // act
      localDataSource.cacheArbolesEntityModelo(tArbolesEntityModelo);

      // assert
      final expectedJsonString =
          json.encode(tArbolesEntityModelo.toJsonFromArbolesEntityModelo());
      verify(
        mockSharedPreferences.setString(
            CACHED_ARBOLES_ENTITY_MODEL, expectedJsonString),
      );
    });
  });
}
