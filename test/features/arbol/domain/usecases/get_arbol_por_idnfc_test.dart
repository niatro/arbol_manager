import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/lista_de_arboles.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arbol_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arbol_por_idnfc.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/lista_de_arboles_test.dart';

class MockListaArbolRepositorio extends Mock implements ListaArbolRepositorio {}

void main() {
  ///Abajo van los nombres de las variables que me interesan
  MockListaArbolRepositorio mockListaArbolRepositorio;
  GetArbolPorIdNFC usecase;

  ///Primer método en correr donde inicializo todos los objetos que voy a utilizar
  ///
  setUp(() {
    mockListaArbolRepositorio = MockListaArbolRepositorio();
    usecase = GetArbolPorIdNFC(mockListaArbolRepositorio);
  });
  final String idNFC = '54sue93G80HAT';
  final ListaDeArboles listaDeArboles =
      ListaDeArboles.fromJson(listaDeArbolesTest);

  test(
    'Trae un árbol (una lista con uno solo) basado en un IdNFC',
    () async {
      // arrange
      when(mockListaArbolRepositorio.getArbolPorIdNFC(any))
          .thenAnswer((_) async => Right(listaDeArboles));
      // act
      final result = await usecase.call(ParamsIdNFC(idNFC: idNFC));
      // assert
      expect(result, Right(listaDeArboles));
      verify(mockListaArbolRepositorio.getArbolPorIdNFC(idNFC));
      verifyNoMoreInteractions(mockListaArbolRepositorio);
    },
  );
}
