import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/features/arbol/data/models/user_entity_modelo.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  UserEntityModel tUserSinInicializar;
  final UserEntityModel tUserEntityModelo = UserEntityModel(
      idUsuario: '6',
      nombreUsuario: 'Nicolas',
      rutUsuario: '10647342',
      apellidoUsuario: 'Sanhueza',
      activoUsuario: 'si',
      detallePerfilUser: 'Admin',
      cliente: 'Vitacura');
  test(
    'CUANDO inicializo un UserEntityModelo DEBERIA generar un objeto UserModeloEntity',
    () async {
      expect(tUserEntityModelo, isA<UserEntityModel>());
    },
  );
  group('fromJson y toJson From UserEntityModelo', () {
    final Map mapaPropiedadesUsuario = {
      'id_usuario': '6',
      'nombre_usuario': 'Nicolas',
      'rut_usuario': '10647342',
      'apellido_usuario': 'Sanhueza',
      'activo_usuario': 'si',
      'detalle_perfil_user': 'Admin',
      'detalle_entidad': 'Vitacura'
    };
    test(
        'DEBE retornar un <UserEntityModel> CUANDO entra un List<Map> parseado de un JSON ',
        () async {
      // arrange
      // estos json tengo que ponerlos en una lista
      final List<Map> jsonMaped =
          List<Map<String, dynamic>>.from(json.decode(fixture('user.json')));
      // act
      final result = UserEntityModel.fromJson(jsonMaped[0]);
//      print(jsonMaped);
      // assert
      expect(result.hashCode, equals(tUserEntityModelo.hashCode));

//      expect(result, tListaDeArbolesEntityModel);
    });

    test(
      'DEBE retornar un List<Map<String, dynamic>> CUANDO ingresamos List<ArbolEntityModelo>',
      () async {
        //arrange
        final result = tUserEntityModelo.toJson();
        //act
//
//        //assert [comparar]
        expect(result, mapaPropiedadesUsuario);
      },
    );
  });
}
