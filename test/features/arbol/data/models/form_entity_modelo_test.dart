import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/constants/form_entity_test.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';

void main() {
  test(
    'CUANDO inicializo un ArbolesEntityModelo DEBERIA generar un objeto ArbolesModeloEntity',
    () async {
      expect(tFormTestModelo, isA<FormEntity>());
      expect(tFormTestModelo, isA<FormEntityModelo>());
    },
  );
  test('CUANDO llamamos al metodo to Entity DEBERIA retornar un Entity',
      () async {
    // arrange

    // act
    final result = tFormTestModelo.toEntity();
    // assert
    expect(result, isA<FormEntity>());
  });
}
