import 'package:dartz/dartz.dart';
import 'package:flutterapparbol/core/constants/lista_de_arboles_test.dart';
import 'package:flutterapparbol/core/error/failure.dart';
import 'package:flutterapparbol/core/success/success.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/update_arboles_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockListaArbolRepositorio extends Mock implements ArbolesRepositorio {}

void main() {
  ///Abajo van los nombres de las variables que me interesan
  MockListaArbolRepositorio mockListaArbolRepositorio;
  UpdateArbolesUseCase usecase;
  setUp(() {
    mockListaArbolRepositorio = MockListaArbolRepositorio();
    usecase = UpdateArbolesUseCase(mockListaArbolRepositorio);
  });

  final ArbolesEntity listaDeArbolesEntity = arbolesEntityTest;
  final ServerUpdateSuccess updatedExistosamente = ServerUpdateSuccess();
  test(
    'DEBERIA devolver un ServerUpdateSuccess CUANDO pasa lista Arboles y N y puede grabar el arbol',
    () async {
      // arrange
      when(mockListaArbolRepositorio.updateArbol(
              arboles: anyNamed('arboles'), nArbol: anyNamed('nArbol')))
          .thenAnswer((_) async => Right(updatedExistosamente));
      // act
      final result = await usecase
          .call(Params(arbolesEntity: listaDeArbolesEntity, nArbol: 1));
      // assert
      expect(result, Right(updatedExistosamente));
      verify(mockListaArbolRepositorio.updateArbol(
          arboles: listaDeArbolesEntity, nArbol: 1));
      verifyNoMoreInteractions(mockListaArbolRepositorio);
    },
  );
  test(
    'DEBERIA entregar un ServerFailure CUANDO no puede grabar el arbol estando conectado a la red',
    () async {
      // arrange
      when(mockListaArbolRepositorio.updateArbol(
              arboles: anyNamed('arboles'), nArbol: anyNamed('nArbol')))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await usecase
          .call(Params(arbolesEntity: listaDeArbolesEntity, nArbol: 1));
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockListaArbolRepositorio.updateArbol(
          arboles: listaDeArbolesEntity, nArbol: 1));
      verifyNoMoreInteractions(mockListaArbolRepositorio);
    },
  );

  test(
      'DEBERIA entregar un ArbolNoUpdateNoExisteFailure CUANDO el arbol no esta en la BD y por tanto no se puede actualizar',
      () async {
    // arrange
    when(mockListaArbolRepositorio.updateArbol(
            arboles: anyNamed('arboles'), nArbol: anyNamed('nArbol')))
        .thenAnswer((_) async => Left(ArbolNoGrabaYaExisteFailure()));
    // act
    final result = await usecase
        .call(Params(arbolesEntity: listaDeArbolesEntity, nArbol: 1));
    // assert
    expect(result, Left(ArbolNoGrabaYaExisteFailure()));
    verify(mockListaArbolRepositorio.updateArbol(
        arboles: listaDeArbolesEntity, nArbol: 1));
    verifyNoMoreInteractions(mockListaArbolRepositorio);
  });
}
