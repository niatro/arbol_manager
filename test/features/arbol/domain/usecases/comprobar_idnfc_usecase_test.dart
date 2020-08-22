import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/core/usecases/usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/comprobar_idnfc_usecase.dart';
import 'package:mockito/mockito.dart';

class MockListaArbolRepositorio extends Mock implements ArbolesRepositorio {}

void main() {
  MockListaArbolRepositorio mockListaArbolRepositorio;
  //OJO: este use case es lo que estamos testeando, el repositorio le pasa parámetros
  ComprobarIdNFCUseCase usecase;
  setUp(() {
    mockListaArbolRepositorio = MockListaArbolRepositorio();
    usecase = ComprobarIdNFCUseCase(mockListaArbolRepositorio);
  });

  final String idNFC = '54sue93G80HAT';
  final bool existe = true;

  test(
      'Deberia entregarme un valor bool que me diga si el chip esta o no en la BD',
      () async {
    // arrange
    when(mockListaArbolRepositorio.comprobarIdNFC(idNFC: anyNamed('idNFC')))
        .thenAnswer((_) async => Right(existe));
    // act
    final result = await usecase.call(Params(idNFC: idNFC));
    // assert
    expect(result, Right(existe));
    verify(mockListaArbolRepositorio.comprobarIdNFC(idNFC: idNFC));
    verifyNoMoreInteractions(mockListaArbolRepositorio);
  });
}
