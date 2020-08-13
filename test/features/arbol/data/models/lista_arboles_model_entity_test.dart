import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../../lib/core/constants/lista_de_arboles_test.dart';
import '../../../../../lib/core/constants/lista_de_maps_test.dart';

void main() {
  final tArbolesEntityModelo =
      ArbolesEntityModelo(listaArbolesEntity: [arbolUnoModel, arbolDosModel]);

  test(
    'CUANDO inicializo un ArbolesEntityModelo DEBERIA generar un objeto ArbolesModeloEntity',
    () async {
      expect(tArbolesEntityModelo, isA<ArbolesEntityModelo>());
    },
  );
  group('fromJson y toJsonFromArbolesEntityModelo', () {
    test(
        'DEBE retornar un <ArbolesEntityModel> CUANDO entra un List<Map> parseado de un JSON ',
        () async {
      // arrange
      // estos json tengo que ponerlos en una lista
      final List<Map> jsonMaped =
          List<Map<String, dynamic>>.from(json.decode(fixture('arboles.json')));
      // act
      final result =
          ArbolesEntityModelo.fromJson(parsedListMapFromJson: jsonMaped);
      // assert
      expect(result.hashCode, equals(tArbolesEntityModelo.hashCode));

//      expect(result, tListaDeArbolesEntityModel);
    });
    test(
      'DEBE retornar un List<Map<String, dynamic>> CUANDO ingresamos List<ArbolEntityModelo>',
      () async {
        //arrange
        final result = tArbolesEntityModelo.toJsonFromArbolesEntityModelo();
        //act
        final expectedListMap = listaMapDeArbolesSerializadosTest;
//
//        //assert [comparar]
        expect(result, expectedListMap);
      },
    );
  });
}
