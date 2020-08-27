import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/constants/lista_de_arboles_test.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/grabar_arboles_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockListaArbolRepositorio extends Mock implements ArbolesRepositorio {}

void main() {
  ///Abajo van los nombres de las variables que me interesan
  MockListaArbolRepositorio mockListaArbolRepositorio;
  GrabarArbolesUseCase usecase;
  setUp(() {
    mockListaArbolRepositorio = MockListaArbolRepositorio();
    usecase = GrabarArbolesUseCase(mockListaArbolRepositorio);
  });

  final ArbolesEntity listaDeArbolesEntity = arbolesEntityTest;
  final ArbolEntity arbolEntity = arbolUno;
  final ServerGrabarSuccess existe = ServerGrabarSuccess();
  test(
    'debería pasar un listado de arboles al repositorio para luego grabarlo en BD, una vez operación se ha realizado debería devolver un true',
    () async {
      // arrange
      when(mockListaArbolRepositorio.grabarArboles(
              arboles: anyNamed('arboles'), nArbol: anyNamed('nArbol')))
          .thenAnswer((_) async => Right(existe));
      // act
      final result = await usecase
          .call(Params(arbolesEntity: listaDeArbolesEntity, nArbol: 1));
      // assert
      expect(result, Right(existe));
      verify(mockListaArbolRepositorio.grabarArboles(
          arboles: listaDeArbolesEntity, nArbol: 1));
      verifyNoMoreInteractions(mockListaArbolRepositorio);
    },
  );
}
