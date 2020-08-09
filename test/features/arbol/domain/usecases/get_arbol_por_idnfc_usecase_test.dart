import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arbol_por_idnfc_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/lista_de_arboles_test.dart';

class MockArbolesRepositorio extends Mock implements ArbolesRepositorio {}

void main() {
  ///Abajo van los nombres de las variables que me interesan
  MockArbolesRepositorio mockArbolesRepositorio;
  GetArbolPorIdNFCUseCase usecase;

  ///Primer método en correr donde inicializo todos los objetos que voy a utilizar
  ///
  setUp(() {
    mockArbolesRepositorio = MockArbolesRepositorio();
    usecase = GetArbolPorIdNFCUseCase(mockArbolesRepositorio);
  });
  // La variable string de abajo es lo que entra como input en nuestro UseCase
  // Particular cuando se implementa la clase abstarcta del repositorio
  final String idNFC = '54sue93G80HAT';
  // La variable da abajo es lo que retorna nuestro UseCase Particular cuando
  // implementa la clase abstracta del repositorio

  final ArbolesEntity arbolesEntity = arbolesEntityTest;

  test(
    'Trae un árbol (una lista con uno solo) basado en un IdNFC',
    () async {
      // arrange
      when(mockArbolesRepositorio.getArbolPorIdNFC(any))
          .thenAnswer((_) async => Right(arbolesEntity));
      // act
      final result = await usecase.call(Params(idNFC: idNFC));
      // assert Aquí comparamos que el output de nuestro UseCase correspondería
      // lo que se produce por la mímica de salida de nuestro repositorio
      expect(result, Right(arbolesEntity));
      // se verifica que el método abajo citado ha sido llamado
      verify(mockArbolesRepositorio.getArbolPorIdNFC(idNFC));
      verifyNoMoreInteractions(mockArbolesRepositorio);
    },
  );
}
