import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arbol_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/comprobar_existencia_idnfc.dart';
import 'package:mockito/mockito.dart';

class MockListaArbolRepositorio extends Mock implements ListaArbolRepositorio {}

void main() {
  MockListaArbolRepositorio mockListaArbolRepositorio;
  ComprobarExistenciaIdNFC usecase;
  setUp(() {
    mockListaArbolRepositorio = MockListaArbolRepositorio();
    usecase = ComprobarExistenciaIdNFC(mockListaArbolRepositorio);
  });

  final String idNFC = '54sue93G80HAT';
  final bool existe = true;

  test(
      'Deberia entregarme un valor bool que me diga si el chip esta o no en la BD',
      () async {
    // arrange
    when(mockListaArbolRepositorio.comprobarExistenciaIdNFC(any))
        .thenAnswer((_) async => Right(existe));
    // act
    final result = await usecase.call(ParamsIdNFC(idNFC: idNFC));
    // assert
    expect(result, Right(existe));
    verify(mockListaArbolRepositorio.comprobarExistenciaIdNFC(idNFC));
    verifyNoMoreInteractions(mockListaArbolRepositorio);
  });
}
